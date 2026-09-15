-- Script för att ge mina roller sina tillstånd för att kunna arbeta med min databas
-- 
-- Välj första rollen att skapa allting med
USE ROLE SECURITYADMIN;

-- Dags att ge tillstånd som SEC-admin
GRANT ROLE home_job_ads_dlt_role TO USER home_extract_loader;

-- Ge USAGE tillstånden(privileges) till rollen
GRANT USAGE ON WAREHOUSE dev_wh to ROLE home_job_ads_dlt_role;
GRANT USAGE ON DATABASE home_job_ads TO ROLE home_job_ads_dlt_role;
GRANT USAGE ON SCHEMA home_job_ads.staging TO ROLE home_job_ads_dlt_role;

-- Ge vad för typ av OPERATIONS privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA home_job_ads.staging TO ROLE home_job_ads_dlt_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA home_job_ads.staging TO ROLE home_job_ads_dlt_role;


--
-- Dubbelkolla alla tillstånd
SHOW GRANTS ON SCHEMA home_job_ads.staging;
SHOW FUTURE GRANTS IN SCHEMA home_job_ads.staging;
SHOW GRANTS TO ROLE home_job_ads_dlt_role;
SHOW GRANTS TO USER home_extract_loader;

GRANT ROLE home_job_ads_dlt_role TO USER johnnyhyytiainen;
