-- Rensa upp roller, databaser och users som inte längre används.
--
-- Börja med att använda USERADMIN och kolla ROLES
-- Droppa roles jag ej använder längre.
USE ROLE USERADMIN;
SHOW ROLES;
DROP ROLE ICECREAM_ANALYST;
DROP ROLE ICECREAM_READER;
SHOW USERS;

-- Droppa databaser jag ej använder mig utav längre.
-- Välj rätt roll(SYSADMIN)
USE ROLE SYSADMIN;
SHOW DATABASES;
DROP DATABASE US_ZIP_META;
DROP DATABASE GOOGLE_KEYWORDS_SEARCH_DATASET_DISCOVER_ALL_SEARCHES_ON_GOOGLE;
DROP DATABASE ICECREAM_DB;
-- Visa databaser efter rensningen
SHOW DATABASES;