-- Script för att ge mina roller sina tillstånd för att kunna arbeta med min databas
-- 
-- Välj första rollen att skapa allting med
USE ROLE SECURITYADMIN;

-- Dags att ge tillstånd som SEC-admin
GRANT ROLE class_job_ads_dlt_role TO USER class_extract_loader;
-- Ge mitt konto denna roll också
GRANT ROLE class_job_ads_dlt_role TO USER johnnyhyytiainen;

-- Ge USAGE tillstånden(privileges) till rollen
GRANT USAGE ON WAREHOUSE dev_wh to ROLE class_job_ads_dlt_role;
GRANT USAGE ON DATABASE class_job_ads TO ROLE class_job_ads_dlt_role;
GRANT USAGE ON SCHEMA class_job_ads.staging TO ROLE class_job_ads_dlt_role;

-- Ge vad för typ av OPERATIONS privileges
GRANT CREATE TABLE ON SCHEMA class_job_ads.staging TO ROLE class_job_ads_dlt_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA class_job_ads.staging TO ROLE class_job_ads_dlt_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA class_job_ads.staging TO ROLE class_job_ads_dlt_role;

USE ROLE USERADMIN;

GRANT ROLE class_job_ads_dlt_role TO ROLE SYSADMIN;
GRANT ROLE class_job_ads_dlt_role TO USER johnnyhyytiainen;

--
-- Dubbelkolla alla tillstånd
SHOW GRANTS ON SCHEMA class_job_ads.staging;
SHOW FUTURE GRANTS IN SCHEMA class_job_ads.staging;
SHOW GRANTS TO ROLE class_job_ads_dlt_role;
SHOW GRANTS TO USER class_extract_loader;




