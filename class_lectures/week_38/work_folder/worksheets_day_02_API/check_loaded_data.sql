-- Välj roll
USE ROLE CLASS_JOB_ADS_DLT_ROLE;

-- Välj DB
USE DATABASE CLASS_job_ads;

-- visa schema
SHOW SCHEMAS;

-- Visa tables
SHOW TABLES IN SCHEMA staging;

-- DESC
DESC TABLE staging.data_field_job_ads;

USE WAREHOUSE dev_wh;
SELECT
    headline,
    employer__workplace,
    description__text
FROM staging.data_field_job_ads;


SELECT * FROM staging.data_field_job_ads;

-- Förväntat: samma antal, alltså inga dubbletter
SELECT COUNT(*) AS antal_rader, COUNT(DISTINCT id) AS antal_unika
FROM class_job_ads.staging.data_field_job_ads;