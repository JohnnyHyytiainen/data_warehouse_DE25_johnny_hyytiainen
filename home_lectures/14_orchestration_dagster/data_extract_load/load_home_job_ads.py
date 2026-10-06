import json

import dlt
import requests

# DLT tömmer sin tillfälliga staging area i Snowflake efter varje laddning
dlt.config["load.truncate_staging_dataset"] = True

url = "https://jobsearch.api.jobtechdev.se"
url_for_search = f"{url}/search"

# sökparametrar, en sida med 100 annonser inom det tekniska yrkesområdet
# Bör kunna använda mitt script i class_lectures med pagination här.
params = {"limit": 100, "occupation-field": "6Hq3_tKo_V57"}


def _get_ads(url_for_search, params):
    headers = {"accept": "application/json"}
    response = requests.get(url_for_search, headers=headers, params=params)
    response.raise_for_status()  # stoppa direkt vid HTTP-fel
    return json.loads(response.content.decode("utf8"))


# table_name MÅSTE vara den samma som identifier i dbts sources.yml fil
@dlt.resource(table_name="technical_field_job_ads", write_disposition="replace")
def jobads_resource(params):
    for ad in _get_ads(url_for_search, params)["hits"]:
        yield ad


# Dagster tar emot en SOURCE, inte en RESOURCE
# Funktionsnamnen bildar asset-nyckeln -  dlt_jobads_source_jobads_resource
@dlt.source
def jobads_source():
    return jobads_resource(params)
