SHOW ROLES;

USE ROLE HOME_JOB_ADS_DLT_ROLE;

USE SCHEMA HOME_JOB_ADS.STAGING;

SHOW TABLES;

DESC TABLE DATA_FIELD_JOB_ADS;

USE WAREHOUSE dev_wh;
SELECT * FROM DATA_FIELD_JOB_ADS;

SELECT
    relevance,
    workplace_address__street_address,
    workplace_address__postcode,
    publication_date,
    webpage_url,
    source_type
FROM data_field_job_ads
LIMIT 5;

SELECT
    scope_of_work__min,
    scope_of_work__max,
    employer__name,
    salary_type__label,
    duration__label,
    logo_url,
    employer__workplace,
    employer__name,
    employer__url
FROM data_field_job_ads
LIMIT 5;