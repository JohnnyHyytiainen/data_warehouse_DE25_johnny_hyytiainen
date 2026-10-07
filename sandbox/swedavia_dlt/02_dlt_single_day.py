# Basic script för att hämta data ifrån Swedavia API fast med DLT resource decorator.
import dlt
import requests

# BaseURL för FlightInfo v2
BASE_URL = "https://api.swedavia.se/flightinfo/v2"


# dlt resource decorator
@dlt.resource(name="arrivals", write_disposition="replace")
def arrivals(airport: str, date: str):
    # samma key och headers som i 01_single_call.py
    api_key = dlt.secrets["sources.swedavia.api_key"]
    headers = {
        "Ocp-Apim-Subscription-Key": api_key,
        "Accept": "application/json",
    }
    url = f"{BASE_URL}/{airport}/arrivals/{date}"
    response = requests.get(url, headers=headers, timeout=30)
    response.raise_for_status()
    # Bara listan med flyg – "to" och "numberOfFlights" är svarets kuvert, inte data
    # (CC, vad menas med kommentaren ovan - utveckling behövs)
    yield response.json()["flights"]


if __name__ == "__main__":
    # Nytt och eget pipeline namn, dlt minnet ska ej delas med kursen
    pipeline = dlt.pipeline(
        pipeline_name="sandbox_swedavia",
        destination="duckdb",
        dataset_name="swedavia_raw",
    )
    # Samma datum som i raw json filen för att jämfra med 349 flights
    load_info = pipeline.run(arrivals("ARN", "2026-10-07"))
    print(load_info)
