-- Setup för grants av users

-- Visa rollerna
SHOW ROLES;
-- Som alltid, välj rätt roll först.
USE ROLE USERADMIN;

-- Skapa rollen med CLASS_ PREFIX
CREATE ROLE class_job_ads_dbt_role;

-- Granta rollerna.
GRANT ROLE class_job_ads_dbt_role to USER class_transformer;
GRANT ROLE class_job_ads_dbt_role TO USER johnnyhyytiainen;