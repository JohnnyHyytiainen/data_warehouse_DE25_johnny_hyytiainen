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
