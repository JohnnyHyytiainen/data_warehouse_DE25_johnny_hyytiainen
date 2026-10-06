-- setup för min class reporter role
USE ROLE USERADMIN;

SHOW ROLES;
-- Skapa na rollen
CREATE ROLE home_job_ads_reporter_role;
GRANT ROLE home_job_ads_reporter_role TO ROLE SYSADMIN;

SHOW ROLES;
--

-- Välj security admin pga säkerhetsfrågor och tillstånd av usage
USE ROLE SECURITYADMIN;

-- Granta usage till rollen
-- Warehouset
GRANT USAGE ON WAREHOUSE dev_wh TO ROLE home_job_ads_reporter_role;

-- Databasen
GRANT USAGE ON DATABASE home_job_ads TO ROLE home_job_ads_reporter_role;

-- Schemat
GRANT USAGE ON SCHEMA home_job_ads.marts TO ROLE home_job_ads_reporter_role;

-- SELECT på alla scheman
GRANT SELECT ON ALL TABLES IN SCHEMA home_job_ads.marts TO ROLE home_job_ads_reporter_role;
GRANT SELECT ON ALL VIEWS IN SCHEMA home_job_ads.marts TO ROLE home_job_ads_reporter_role;

-- Framtida
GRANT SELECT ON FUTURE TABLES IN SCHEMA home_job_ads.marts TO ROLE home_job_ads_reporter_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA home_job_ads.marts TO ROLE home_job_ads_reporter_role;


-- Ge USER home_reporter till ROLE home_job_ads_reporter_role
GRANT ROLE home_job_ads_reporter_role TO USER home_reporter;
GRANT ROLE home_job_ads_reporter_role TO USER johnnyhyytiainen;

-- Välj rollen
USE ROLE home_job_ads_reporter_role;

SHOW GRANTS TO ROLE home_job_ads_reporter_role;
-- Test query
USE WAREHOUSE dev_wh;
SELECT * FROM home_job_ads.marts.mart_technical_jobs;


-- ===== Testblock: rapportrollen =====
USE ROLE home_job_ads_reporter_role;
USE SECONDARY ROLES NONE;   -- stäng av lånade rättigheter från mina andra roller
USE WAREHOUSE dev_wh;

-- Förväntat: lyckas, rollen får läsa marten
SELECT COUNT(*) FROM home_job_ads.marts.mart_technical_jobs;

-- Förväntat: nekas, warehouse-schemat ligger utanför rollen
SELECT COUNT(*) FROM home_job_ads.warehouse.fct_job_ads;

-- Förväntat: nekas, rollen får bara läsa, inte skapa
CREATE TABLE home_job_ads.marts.skrivtest (id INT);

USE SECONDARY ROLES ALL;    -- återställ