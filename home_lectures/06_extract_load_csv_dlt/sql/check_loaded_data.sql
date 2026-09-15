-- Nu när jag kört mitt load_csv script är det dags att dubbelkolla och bekräfta att datan finns i min databas

-- Välj roll
USE ROLE MOVIES_READER_ROLE;

-- Visa mina DBs
show databases;

-- Välj DB
USE DATABASE MOVIES;

-- Describe databasen för att se schema
-- Kind = SCHEMA
DESCRIBE DATABASE MOVIES;

-- Describe SCHEMAT i databasen
-- Kind = TABLE
DESCRIBE SCHEMA STAGING;

-- Describe tables, se mina columns och datatyperna.
-- DLT skapar schemat (inferring schema baserat på datatyperna)
DESC TABLE staging.netflix;

-- Gräv lite djupare i mina tables
SELECT * FROM staging.netflix;

--
SELECT COUNT(*) FROM staging.netflix;
