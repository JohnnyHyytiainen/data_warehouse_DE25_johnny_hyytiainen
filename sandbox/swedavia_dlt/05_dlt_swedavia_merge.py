# Script för att hämta både arrivals+departures
import logging
from datetime import datetime, timedelta
from zoneinfo import ZoneInfo

import dlt
from dlt.sources.helpers import requests

BASE_URL = "https://api.swedavia.se/flightinfo/v2"
AIRPORTS = ["ARN", "BMA", "GOT", "MMX", "LLA", "UME", "OSD", "VBY", "RNB", "KRN"]
# Swedavias egen flygidentitet + planerad tid (en flytt av tiden ger en ny rad hos Swedavia)
LEG_KEY = [
    "flight_leg_identifier__flight_id",
    "flight_leg_identifier__flight_departure_date_utc",
    "flight_leg_identifier__departure_airport_iata",
    "flight_leg_identifier__arrival_airport_iata",
]
ARRIVALS_KEY = LEG_KEY + ["arrival_time__scheduled_utc"]
DEPARTURES_KEY = LEG_KEY + ["departure_time__scheduled_utc"]

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(message)s")
logger = logging.getLogger(__name__)


def get_dates(days_back: int) -> list[str]:
    # API'ts datum är en Svensk kalenderdag och inte UTC, bekräftad och uppmätt i rådatan redan
    today = datetime.now(ZoneInfo("Europe/Stockholm")).date()
    return [(today - timedelta(days=i)).isoformat() for i in range(days_back)]


def fetch_flights(airport: str, direction: str, date: str, api_key: str) -> list[dict]:
    headers = {
        "Ocp-Apim-Subscription-Key": api_key,
        "Accept": "application/json",
    }
    url = f"{BASE_URL}/{airport}/{direction}/{date}"
    response = requests.get(url, headers=headers, timeout=30)
    response.raise_for_status()
    flights = response.json()["flights"]
    # En rad api call i loggen så syns det direkt direkt om en flygplats ger 0
    logger.info(f"{direction:<10} {airport} {date}: {len(flights)} flights")
    return flights


def flights(direction: str, airports: list[str], dates: list[str], api_key: str):
    # Samma generator för båda riktningarna, riktningen styr bara URL
    for airport in airports:
        for date in dates:
            yield fetch_flights(airport, direction, date, api_key)


@dlt.source(name="swedavia")
def swedavia_source(airports: list[str], dates: list[str], api_key: str):
    # Två resurser ur samma logik innebär två tables
    return (
        dlt.resource(
            flights("arrivals", airports, dates, api_key),
            name="arrivals",
            write_disposition="merge",
            primary_key=ARRIVALS_KEY,
        ),
        dlt.resource(
            flights("departures", airports, dates, api_key),
            name="departures",
            write_disposition="merge",
            primary_key=DEPARTURES_KEY,
        ),
    )


if __name__ == "__main__":
    api_key = dlt.secrets["sources.swedavia.api_key"]
    dates = get_dates(days_back=3)

    pipeline = dlt.pipeline(
        pipeline_name="sandbox_swedavia_merge",  # nytt namn → ny .duckdb-fil, rent schema
        destination="duckdb",
        dataset_name="swedavia_raw",
    )
    load_info = pipeline.run(swedavia_source(AIRPORTS, dates, api_key))
    print(load_info)
