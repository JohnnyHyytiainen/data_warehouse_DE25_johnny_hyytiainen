# Fetch script via API calls och testa att ingesta data.
# Kod: Engelska
# Kommentarer: Svenska
import json
from datetime import datetime, timezone
from pathlib import Path

import dlt
import requests

# Base url för FlightInfo v2
BASE_URL = "https://api.swedavia.se/flightinfo/v2"


# Funktion för att hämta flight data
def fetch_flights(airport: str, direction: str, date: str) -> dict:
    # Nyckel läses direkt från .dlt/serets.toml, samma plats som använder DLT sen
    api_key = dlt.secrets["sources.swedavia.api_key"]
    headers = {
        "Ocp-Apim-Subscription-Key": api_key,
        "Accept": "application/json",
    }
    url = f"{BASE_URL}/{airport}/{direction}/{date}"
    response = requests.get(url, headers=headers, timeout=30)
    # Kasta fel direkt vid 400-koder
    response.raise_for_status()
    return response.json()


if __name__ == "__main__":
    # dagens date i UTC, API't använder UTC inte svensk tid.
    today = datetime.now(timezone.utc).strftime("%Y-%m-%d")
    data = fetch_flights("ARN", "arrivals", today)

    # Sparar ner raw data i json.
    out = Path("raw") / f"ARN_arrivals_{today}.json"
    out.parent.mkdir(exist_ok=True)
    out.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding="utf-8")

    # Första blicken på datan: toppnivåns nycklar och längden på listorna
    for key, value in data.items():
        if isinstance(value, list):
            print(f"{key}: list with {len(value)} items")
        else:
            print(f"{key}: {value}")
