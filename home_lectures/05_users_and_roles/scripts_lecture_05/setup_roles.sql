-- Setup för att sätta upp mina roles för kontot
-- useramdin är ansvarig och till för att hantera
-- SKAPANDET AV ROLLER
-- HANTERINGEN AV ROLLER
USE ROLE USERADMIN;

-- Dubbelkolla vilken roll(role) jag använder
SELECT CURRENT_ROLE();

-- Skapa en NY ROLE (ROLL)
-- Roll för att LÄSA iceream_db databasen
CREATE ROLE ice_cream_reader COMMENT = "Role that is able to read icecream_db";

-- Ny role
-- Roll för att utföra CRUD operations(create, read, update, delete) på icecream_db databasen
CREATE ROLE ice_cream_writer COMMENT = "Role that is able to do CRUD operations on icecream_db";

-- Ny role
-- Roll för att analysera icecream_db databasen
CREATE ROLE ice_cream_analyst COMMENT = "Role that is able to create VIEWS on icecream_db";

-- Kolla roles / Visa roles
SHOW ROLES;

-- Nu när jag har roles är det dags att ge rättigheter till roles med GRANTS
--
-- Nu är det dags att byta role till SECURITYADMIN för att GRANT rättigheter till skapade roles
-- (CC(?))
USE ROLE SECURITYADMIN;

-- Nu när jag använder securityadmin rollen
-- Kan jag godkänna olika rättigheter till roles
-- Tillåter användning av min dev_wh WAREHOUSE till ice_cream_reader rollen som skapades ovan
-- (CC(?))
GRANT USAGE ON WAREHOUSE dev_wh TO ROLE ice_cream_reader;

-- Dags att godkänna usage på DATABASEN till en ROLE
-- (CC(?))
GRANT USAGE ON DATABASE icecream_db TO ROLE ice_cream_reader;


-- Nu när jag tillåtit rättigheter till mitt WAREHOUSE(dev_wh) & tillåtit användning av DATABASE 
-- Så godkänner jag ALLA rättigheter till role ice_cream_reader och icecream_db's ALLA SCHEMAS
-- (CC(?))
GRANT USAGE ON ALL SCHEMAS IN DATABASE icecream_db TO ROLE ice_cream_reader;

-- Dags att ge READ tillstånd, dvs kunna göra SELECTs
-- Ger tillgång till ALLA tables i schemat. 
-- (CC(?))
GRANT SELECT ON ALL TABLES IN SCHEMA icecream_db.public TO ROLE ice_cream_reader;
-- Godkänt SELECT på alla tables i ett schema, under är det dags att ge tillåtelse till FRAMTIDA scheman
-- Om ett schema ändras eller fler tillkommer så kommer ice_cream_reader nu ha tillgång till dom för SELECT statements(?)
-- (CC(?))
GRANT SELECT ON FUTURE TABLES IN SCHEMA icecream_db.public TO ROLE ice_cream_reader;


-- Kolla grants
SHOW GRANTS TO ROLE ice_cream_reader;

-- Kolla framtida godkända db.PUBLIC.table som kan skapas för reading rights
SHOW FUTURE GRANTS IN SCHEMA icecream_db.public;

-- Writer rollen ska ha HÖGRE access än enbart en READER role.
-- Ger min WRITER role den access som min reader har + lite till (min writer ÄRVER från reader rollen)
GRANT ROLE ice_cream_reader TO ROLE ice_cream_writer;

-- Kolla vilka rättigheter min writer har
SHOW GRANTS TO ROLE ice_cream_writer;

-- Nu ska WRITER få tillgång till CRUD operations
GRANT 
    INSERT, UPDATE, DELETE 
    ON ALL TABLES 
    IN SCHEMA icecream_db.public TO ROLE ice_cream_writer;

-- Ge det till FRAMTIDA tables också.
GRANT 
    INSERT, UPDATE, DELETE 
    ON FUTURE TABLES 
    IN SCHEMA icecream_db.public TO ROLE ice_cream_writer;

--
-- Vill även ge tillstånd att SKAPA tables
GRANT CREATE TABLE ON SCHEMA icecream_db.public TO ROLE ice_cream_writer;

-- Visa grants
SHOW GRANTS TO ROLE ice_cream_writer;
SHOW FUTURE GRANTS IN SCHEMA icecream_db.public;

-- använd useradmin
USE ROLE USERADMIN;
-- ge en roll till en annan (inheritence)
GRANT ROLE ice_cream_writer TO USER johnnyhyytiainen;

-- ÖVNING - GE ANALYS ACCESS TILL SISTA ROLLEN