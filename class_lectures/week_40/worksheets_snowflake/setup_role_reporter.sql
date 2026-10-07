-- setup för min class reporter role
USE ROLE USERADMIN;

SHOW ROLES;
-- Skapa na rollen
CREATE ROLE class_job_ads_reporter_role;

SHOW ROLES;
--

-- Välj security admin pga säkerhetsfrågor och tillstånd av usage
USE ROLE SECURITYADMIN;

-- Granta usage till rollen
-- Warehouset
GRANT USAGE ON WAREHOUSE dev_wh TO ROLE class_job_ads_reporter_role;

-- Databasen
GRANT USAGE ON DATABASE class_job_ads TO ROLE class_job_ads_reporter_role;

-- Schemat
GRANT USAGE ON SCHEMA class_job_ads.marts TO ROLE class_job_ads_reporter_role;

-- SELECT på alla scheman
GRANT SELECT ON ALL TABLES IN SCHEMA class_job_ads.marts TO ROLE class_job_ads_reporter_role;
GRANT SELECT ON ALL VIEWS IN SCHEMA class_job_ads.marts TO ROLE class_job_ads_reporter_role;

-- Framtida
GRANT SELECT ON FUTURE TABLES IN SCHEMA class_job_ads.marts TO ROLE class_job_ads_reporter_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA class_job_ads.marts TO ROLE class_job_ads_reporter_role;


-- Ge USER class_reporter till ROLE class_job_ads_reporter_role
GRANT ROLE class_job_ads_reporter_role TO USER class_reporter;
GRANT ROLE class_job_ads_reporter_role TO USER johnnyhyytiainen1;

-- Välj rollen
USE ROLE class_job_ads_reporter_role;

SHOW GRANTS TO ROLE class_job_ads_reporter_role;
-- Test query
USE WAREHOUSE dev_wh;
SELECT * FROM class_job_ads.marts.mart_technical_jobs;
