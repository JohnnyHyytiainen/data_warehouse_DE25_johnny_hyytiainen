import json
import os
from pathlib import Path

import dlt
import requests

# URLS att använda mig av
# URL och dess /search ENDPOINT
url = "https://jobsearch.api.jobtechdev.se"
url_for_search = f"{url}/search"


# Funktion för att hämta adds. URL + /SEARCH endpoint
def _get_ads(url_for_search, params):
    headers = {"accept": "application/json"}
    response = requests.get(url_for_search, headers=headers, params=params)
    response.raise_for_status()  # check for http errors
    return json.loads(response.content.decode("utf8"))


@dlt.resource(write_disposition="replace")
def jobads_resource(params):
    # paginering, 100 är API'ts max
    limit = params.get("limit", 100)
    offset = 0
    # loopa över varje json objekt på varje sida.
    # Vid slutet av sidan, använd offset
    while True:
        page_params = {**params, "offset": offset}
        response = _get_ads(url_for_search, page_params)
        hits = response.get("hits", [])

        # Vid inga fler hits - BREAK(stanna hela loopen)
        if not hits:
            break

        # yield istället för return, return hade kört funktionen gång på gång
        # yield väntar på nästa objekt tills allting är klart.
        yield hits

        # Offset räknare + limit(offset = ny sida + 100 svar i form av json objekt)
        offset += limit

        # Om offset är större än response["total"]["value"] (response[värde][värde] avbryt while-loopen)
        if offset >= response["total"]["value"]:
            break


# Körning av pipen. Query + table namnet.
def run_pipeline(query, table_name):
    pipeline = dlt.pipeline(
        pipeline_name="class_job_ads", destination="snowflake", dataset_name="staging"
    )

    params = {"q": query, "limit": 100}

    load_info = pipeline.run(jobads_resource(params=params), table_name=table_name)
    print(load_info)


if __name__ == "__main__":
    working_directory = Path(__file__).parent
    os.chdir(working_directory)

    query = "data"
    table_name = "data_field_job_ads"

    run_pipeline(query, table_name)
