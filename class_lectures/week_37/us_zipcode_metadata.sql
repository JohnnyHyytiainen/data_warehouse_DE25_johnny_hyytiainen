-- Välj roll
USE ROLE sysadmin;

-- Visa mina warehouses för att se vilken compute jag ska använda
SHOW WAREHOUSES;

-- Välj vilken warehouse(compute) jag ska använda
USE WAREHOUSE WEEK_1_TEST;

--Visa mina databaser
SHOW DATABASES;

-- Välj databasen
USE DATABASE us_zip_meta;

-- Visa scheman
SHOW SCHEMAS;

-- Välj mitt schema
USE SCHEMA ZIP_DEMOGRAPHICS;

-- Gör första test queryn
SELECT * FROM ZIP_CODE_METADATA
LIMIT 150;


-- Gör lite fler queries
SELECT 
    MEDIAN_AGE, 
    TOTAL_MALE_POPULATION AS MALE_POP, 
    TOTAL_FEMALE_POPULATION AS FEMALE_POP, 
    ZIP, 
    CITY, 
    STATE, 
    TOTAL_POPULATION
FROM ZIP_CODE_METADATA
LIMIT 20;

-- Vad har jag kört, hur länge tog det, hur mycket lästes?
-- Går att göra denna query istället för att kolla 
SELECT
    query_text,
    warehouse_name,
    execution_status,
    total_elapsed_time / 1000 AS elapsed_seconds,
    bytes_scanned,
    rows_produced,
    start_time
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY())
ORDER BY start_time DESC
LIMIT 20;

-- Vad är en rad, hur många rader finns, hur många unika ZIP. 
-- 37 704 ZIP codes
-- 37 702 DISTINCT ZIP codes
SELECT 
    DISTINCT ZIP
FROM ZIP_CODE_METADATA;

-- 37 704
SELECT 
COUNT(*) ZIP
FROM ZIP_CODE_METADATA;

