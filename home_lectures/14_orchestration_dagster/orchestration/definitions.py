from pathlib import Path
import dlt
import dagster as dg
from dagster_dlt import DagsterDltResource, dlt_assets
from dagster_dbt import DbtCliResource, DbtProject, dbt_assets

import sys

sys.path.insert(0, "../data_extract_load")
# Läraren pratar om att detta är de "fula sättet". Egentligen bör jag köra en dagster init först
# CC: Varför? Vad är korrekta versionen att köra?

from load_home_job_ads import jobads_source


# DLT asset
# Skapa en instans av resursklassen för att kunna köra dlt koden
dlt_resource = DagsterDltResource()


@dlt_assets(
    dlt_source=jobads_source(),
    dlt_pipeline=dlt.pipeline(
        pipeline_name="jobsearch",
        destination="snowflake",
        dataset_name="staging",
    ),
)
def dlt_home_load(context: dg.AssetCheckExecutionContext, dlt: DagsterDltResource):
    yield from dlt.run(context=context)


# DBT asset

dbt_project_directory = Path(__file__).parents[1] / "data_transformation"
profiles_directory = Path.home() / ".dbt"

dbt_project = DbtProject(
    project_dir=dbt_project_directory, profiles_directory=profiles_directory
)

# Få CLI commands
dbt_resource = DbtCliResource(project_dir=dbt_project)

# Få manifestet under runtime
dbt_project.prepare_if_dev()


# DBT asset
@dbt_assets(manifest=dbt_project.manifest_path)
def dbt_models(context: dg.AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], conext=context).stream()


# Jobs
jobs_dlt = dg.define_asset_job(
    "jobs_dlt", selection=dg.AssetSelection.keys("dlt_jobads_source_jobads_resource")
)

jobs_dbt = dg.define_asset_job(
    "jobs_dbt", selection=dg.AssetSelection.key_prefixes("warehouse", "marts")
)

schedule_dlt = dg.ScheduleDefinition(job=jobs_dlt, cron_schedule="10 30 * * *")


@dg.asset_sensor(
    asset_key=dg.AssetKey("dlt_jobads_source_jobads_resource"), job_name="jobs_dbt"
)
def dlt_load_sensor():
    yield dg.RunRequest()


# Definitions
defs = dg.Definitions(
    assets=[dlt_home_load, dbt_models],
    resources={"dlt": dlt_resource, "dbt": dbt_resource},
    jobs=[jobs_dlt, jobs_dbt],
    schedules=[schedule_dlt],
    sensors=[dlt_load_sensor],
)
