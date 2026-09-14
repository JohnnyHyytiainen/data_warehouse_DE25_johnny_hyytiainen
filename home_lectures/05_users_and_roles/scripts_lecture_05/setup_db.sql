-- Script för att sätta upp en db för lecture_05
-- users and roles
-- ctrl+shift+p -> change language mode -> snowflake SQL om det är fel mode.
--
--
-- Välj din roll. Här är jag system admin
 USE ROLE SYSADMIN;

 -- Ta och se över vilken roll jag använder
 -- Tidigare var min roll ACCOUNTADMIN
 SELECT current_role();

-- Välj current user, dubbelkolla och se vilken current användare det är.
 SELECT CURRENT_USER();

-- Sysadmin är ansvarig för att skapa DBs 
-- if not exists (för idempotens)
CREATE DATABASE IF NOT EXISTS icecream_db;

-- Visa mina warehouses(Compute)
Show warehouses;

-- Droppar min skapade demo_Warehouse ifrån tidigare lektion 00-04 vecka 37.
DROP WAREHOUSE demo_warehouse;

-- Nytt warehouse för lecture 05
CREATE WAREHOUSE dev_wh
WITH
WAREHOUSE_SIZE = "X-SMALL"
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE
COMMENT = "Warehouses for development and analysis - lecture 05, week 38";

-- Visa och dubbelkolla att jag skapade allting rätt.
SHOW WAREHOUSES;