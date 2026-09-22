-- Script för att sätta upp mina data marts.
--
-- Välj rätt roll
USE ROLE SYSADMIN;

-- Välj DB
USE DATABASE HOME_JOB_ADS;

-- Skapa schema för mina data-marts
CREATE SCHEMA IF NOT EXISTS marts;

SHOW SCHEMAS IN DATABASE HOME_JOB_ADS;

-- Byt roll till Securityadmin
USE ROLE SECURITYADMIN;

-- Granta tillåtelser.
GRANT USAGE, CREATE TABLE, CREATE VIEW ON SCHEMA HOME_JOB_ADS.MARTS TO ROLE HOME_JOB_ADS_DBT_ROLE;

-- Granta tillåtelser för CRUD + SELECT + VIEWS
GRANT
    SELECT,
    INSERT,
    UPDATE,
    DELETE ON ALL TABLES IN SCHEMA HOME_JOB_ADS.MARTS TO ROLE HOME_JOB_ADS_DBT_ROLE;
-- SELECT på views
GRANT SELECT ON ALL VIEWS IN SCHEMA HOME_JOB_ADS.MARTS TO ROLE HOME_JOB_ADS_DBT_ROLE;

-- Granta CRUD, SELECT + VIEWS på FRAMTIDA
GRANT SELECT,
    INSERT,
    UPDATE,
    DELETE ON FUTURE TABLES IN SCHEMA home_job_ads.marts TO ROLE home_job_ads_dbt_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA home_job_ads.marts TO ROLE home_job_ads_dbt_role;

-- Välj rollen och dubbelkolla.
USE ROLE home_job_ads_dbt_role;
SHOW GRANTS ON SCHEMA home_job_ads.marts;

-- Manuellt test för att vara säker
USE SCHEMA HOME_JOB_ADS.MARTS;
CREATE TABLE testing (id INTEGER);
SHOW TABLES;
DROP TABLE TESTING;
SHOW TABLES;