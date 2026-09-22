-- Script för att sätta upp mitt warehouse lager.

-- Välj roll(SYSADMIN FÖR DB RELATERAT)
USE ROLE SYSADMIN;

-- Välj DB
USE DATABASE HOME_JOB_ADS;

-- Skapa ett schema i DB
CREATE SCHEMA IF NOT EXISTS warehouse;

-- Visa schemas i nuvarande DB
SHOW SCHEMAS IN DATABASE HOME_JOB_ADS;

-- Välj securityadmin rollen då det handlar om säkerhets grants
USE ROLE SECURITYADMIN;

-- Jag grantar DLT rollen TILL DBT rollen då DBT rollen ska ha TILLGÅNG till staging.
-- Detta för att DBT rollen ska kunna välja och använda datan ifrån STAGING lagret för att kunna 
-- göra transformationerna i DBT
GRANT ROLE home_job_ads_dlt_role TO ROLE home_job_ads_dbt_role;

-- Visa grants till DBT rollen
SHOW GRANTS TO ROLE home_job_ads_dbt_role;

GRANT USAGE,
CREATE TABLE,
CREATE VIEW ON SCHEMA home_job_ads.warehouse TO ROLE home_job_ads_dbt_role;

-- Ge tillåtelse för CRUD och SELECT tables + views
GRANT 
    SELECT,
    INSERT,
    UPDATE,
    DELETE ON ALL TABLES IN SCHEMA home_job_ads.warehouse TO ROLE home_job_ads_dbt_role;

GRANT SELECT ON ALL VIEWS IN SCHEMA home_job_ads.warehouse TO ROLE home_job_ads_dbt_role;

-- Ge tillåtelse för FRAMTIDA
GRANT
    INSERT,
    UPDATE,
    DELETE ON FUTURE TABLES IN SCHEMA home_job_ads.warehouse TO ROLE home_job_ads_dbt_role;

GRANT SELECT ON FUTURE VIEWS IN SCHEMA home_job_ads.warehouse TO ROLE home_job_ads_dbt_role;


-- Testa nya rollen
USE ROLE home_job_ads_dbt_role;

SELECT * FROM home_job_ads.staging.data_field_job_ads LIMIT 10;

SHOW GRANTS ON SCHEMA HOME_JOB_ADS.warehouse;


USE SCHEMA home_job_ads.warehouse;
CREATE TABLE test (id INTEGER);
SHOW TABLES;
SHOW GRANTS TO ROLE home_job_ads_dbt_role;
DROP TABLE TEST;