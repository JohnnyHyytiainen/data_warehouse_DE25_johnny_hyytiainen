-- Setup för ROLES + USERS.
USE ROLE USERADMIN;

-- Kolla rätt nuvarande roll
SELECT CURRENT_ROLE();
-- Kolla rätt user
SELECT CURRENT_USER();

-- Skapa nya ROLES
CREATE ROLE icecream_reader COMMENT = "Able to read icecream_db";
CREATE ROLE icecream_writer COMMENT = "Able to do CRUD operations on icecream_db";
CREATE ROLE icecream_analyst COMMENT = "Able to create views on icecream_db";

-- Visa rollerna
SHOW ROLES;

-- Granta tillstånd till mina nya skapade roles.
-- Byt roll till sec admin
USE ROLE SECURITYADMIN;
SELECT CURRENT_ROLE();

-- Ge tillstånd till mitt warehouse, DB etc.
GRANT USAGE ON WAREHOUSE dev_wh TO ROLE icecream_reader;
GRANT USAGE ON DATABASE icecream_db TO ROLE icecream_reader;
GRANT USAGE ON ALL SCHEMAS IN DATABASE icecream_db TO ROLE icecream_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA icecream_db.public TO ROLE icecream_reader;
GRANT SELECT ON FUTURE TABLES IN SCHEMA icecream_db.public TO ROLE icecream_reader;
-- Ge SELECT TILLSTÅND(Läs rättigheter) till min icecream_reader ROLE
GRANT SELECT ON ALL TABLES IN SCHEMA icecream_db.public TO ROLE icecream_reader;
GRANT SELECT ON FUTURE TABLES IN SCHEMA icecream_db.public TO ROLE icecream_reader;
---
GRANT ROLE icecream_reader TO ROLE icecream_writer;

-- Kolla vilka rättigheter min writer har
SHOW GRANTS TO ROLE icecream_writer;

-- Nu ska WRITER få tillgång till CRUD operations
GRANT 
    INSERT, UPDATE, DELETE 
    ON ALL TABLES 
    IN SCHEMA icecream_db.public TO ROLE icecream_writer;

-- Ge det till FRAMTIDA tables också.
GRANT 
    INSERT, UPDATE, DELETE 
    ON FUTURE TABLES 
    IN SCHEMA icecream_db.public TO ROLE icecream_writer;

--
-- Vill även ge tillstånd att SKAPA tables
GRANT CREATE TABLE ON SCHEMA icecream_db.public TO ROLE icecream_writer;

-- Visa grants
SHOW GRANTS TO ROLE icecream_writer;
SHOW FUTURE GRANTS IN SCHEMA icecream_db.public;

USE ROLE USERADMIN;
-- ge en roll till en annan (inheritence)
GRANT ROLE icecream_writer TO USER johnnyhyytiainen;
-- Grant role som min reader, writer och analyst har till SYSTEM ADMIN (DB relaterad SYSADMIN)
GRANT ROLE icecream_reader TO ROLE SYSADMIN;
GRANT ROLE icecream_writer TO ROLE SYSADMIN;
GRANT ROLE icecream_analyst TO ROLE SYSADMIN;