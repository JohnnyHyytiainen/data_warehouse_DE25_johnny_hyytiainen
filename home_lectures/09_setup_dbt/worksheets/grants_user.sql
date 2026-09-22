-- Setup för grans av users

-- Visa rollerna
SHOW ROLES;
-- Som alltid, välj rätt roll först.
USE ROLE USERADMIN;

-- Skapa rollen för lecture 09, HOME_ PREFIX
CREATE ROLE home_job_ads_dbt_role;

-- Granta rollerna.
GRANT ROLE home_job_ads_dbt_role to USER home_transformer;
GRANT ROLE home_job_ads_dbt_role TO USER johnnyhyytiainen;