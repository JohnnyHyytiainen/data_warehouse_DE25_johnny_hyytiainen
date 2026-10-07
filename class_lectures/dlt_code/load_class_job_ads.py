import os
from pathlib import Path

import dlt
from dlt.sources.helpers.rest_client import RESTClient
from dlt.sources.helpers.rest_client.paginators import OffsetPaginator


@dlt.resource(write_disposition="replace")
def jobads_resource(params):
    # Klienten ska skapas HÄR INNE i funktionen. Resursen körs först när pipen hämtar data
    # och då kan os.chdir peka dlt mot rätt .dlt folder utan att krascha.
    # Klienten som vet VART den ska och HUR den ska bläddra sidor
    client = RESTClient(
        base_url="https://jobsearch.api.jobtechdev.se",
        headers={"accept": "application/json"},
        paginator=OffsetPaginator(
            limit=100,  # antal annonser per sida. 100 är API'ets MAX
            total_path="total.value",  # Vart totalen står i svaret
            maximum_offset=2100,  # jobtechs tak, och dess max offset.
        ),
        data_selector="hits",  # Var annonsen ligger i svaret. Pekar ut hits istället för att dlt ska inferera(?)(gissa)
    )
    # paginate() hämtar sida efter sida tills en regel för stopp uppnås.
    for page in client.paginate("/search", params=params):
        yield page


def run_pipeline(table_name):
    pipeline = dlt.pipeline(
        pipeline_name="class_technical_field_job_ads",  # eget namn = eget minne, rör inte andra skripts tabeller
        destination="snowflake",
        dataset_name="staging",
    )

    # limit ska nu skötas av paginatorn under @dlt.resource decoratorn
    params = {"occupation-field": "6Hq3_tKo_V57"}

    load_info = pipeline.run(jobads_resource(params=params), table_name=table_name)
    print(load_info)


if __name__ == "__main__":
    working_directory = Path(__file__).parent
    os.chdir(working_directory)

    run_pipeline(table_name="technical_field_job_ads")
