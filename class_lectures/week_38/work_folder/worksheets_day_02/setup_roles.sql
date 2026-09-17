-- Välj din roll
USE ROLE USERADMIN;

-- Skapa ny roller som ska användas
-- DLT rollen behöver ej läsrättigheter(SELECT), den behöver priviligages för att
-- INSERT, UPDATE, DELETE
CREATE ROLE IF NOT EXISTS class_movies_dlt_role;
CREATE ROLE IF NOT EXISTS class_movies_reader_role;


-- Välj securityadmin rollen för att granta tillåtelser till movies_dlt_role
USE ROLE SECURITYADMIN;

-- Ge tillståndet till dlt rollen som redan är skapad med lösenord etc i setup_user_role.sql
GRANT ROLE class_movies_dlt_role TO USER class_extract_loader;

-- Ge min egna personliga user rollen som movies_reader_role
GRANT ROLE class_movies_reader_role TO USER johnnyhyytiainen;
GRANT ROLE class_movies_dlt_role TO USER johnnyhyytiainen;


-- Ge tillstånd till rollerna.
GRANT USAGE ON WAREHOUSE dev_wh TO ROLE class_movies_dlt_role;
--
GRANT USAGE ON DATABASE class_movies TO ROLE class_movies_dlt_role;
--
GRANT USAGE ON SCHEMA class_movies.staging TO ROLE class_movies_dlt_role;

--
-- Ge tillstånd till alla CRUD operations förutom R(READ)
GRANT CREATE TABLE ON SCHEMA class_movies.staging TO ROLE class_movies_dlt_role;
-- Till nuvarande tables i schemat
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA class_movies.staging TO ROLE class_movies_dlt_role;
-- Till framtida tables i schemat
GRANT INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA class_movies.staging TO ROLE class_movies_dlt_role;

-- Dubbelkolla mina GRANTS(Mina skapade tillstånd för rollen)
SHOW GRANTS ON SCHEMA class_movies.staging;
SHOW FUTURE GRANTS IN SCHEMA class_movies.staging;
--
SHOW GRANTS TO ROLE class_movies_dlt_role;
SHOW GRANTS TO USER class_extract_loader;

--
-- Skapa min READER ROLE
USE ROLE useradmin;
CREATE ROLE IF NOT EXISTS class_movies_reader_role;

-- Välj security rollen för att granta movies_reader_role sina tillstånd
USE ROLE SECURITYADMIN;

-- Ge mina tillstånd till movies_reader_role rollen
GRANT USAGE ON WAREHOUSE dev_wh TO ROLE class_movies_reader_role;
GRANT USAGE ON DATABASE class_movies TO ROLE class_movies_reader_role;
GRANT USAGE ON SCHEMA class_movies.staging TO ROLE class_movies_reader_role;


-- Ge tillstånd för läsningen(SELECT) statements till class_movies_reader_role
GRANT SELECT ON ALL TABLES IN SCHEMA class_movies.staging TO ROLE class_movies_reader_role;
GRANT SELECT ON FUTURE TABLES IN DATABASE class_movies TO ROLE class_movies_reader_role;

USE ROLE USERADMIN;

GRANT ROLE class_movies_reader_role TO ROLE SYSADMIN;
GRANT ROLE class_movies_dlt_role TO ROLE SYSADMIN;
GRANT ROLE class_movies_reader_role TO USER johnnyhyytiainen;
GRANT ROLE class_movies_dlt_role TO USER johnnyhyytiainen;

