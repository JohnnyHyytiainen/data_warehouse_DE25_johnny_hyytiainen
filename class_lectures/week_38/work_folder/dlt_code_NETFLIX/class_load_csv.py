# Script för att ingesta datan i data foldern
import os
from pathlib import Path

import dlt
import pandas as pd


@dlt.resource(write_disposition="replace")
def load_csv(file_path: str, **kwargs):
    df = pd.read_csv(file_path, **kwargs)
    yield df


if __name__ == "__main__":
    working_directory = Path(__file__).parent

    os.chdir(working_directory)
    csv_path = working_directory / "data" / "NetflixOriginals.csv"
    data = load_csv(csv_path, encoding="latin1")
    pipeline = dlt.pipeline(
        pipeline_name="class_movies",
        destination="snowflake",
        dataset_name="staging",
    )

    load_info = pipeline.run(data, table_name="netflix")
    print(load_info)
