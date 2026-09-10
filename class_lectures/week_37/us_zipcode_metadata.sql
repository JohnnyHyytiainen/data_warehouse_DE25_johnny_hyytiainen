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
LIMIT 10;


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

----------------------
-- 1: Vad är en row, hur många rows finns totalt, hur många unika zips
SELECT 
    COUNT(*) AS TOTAL_ROWS, 
    COUNT(DISTINCT ZIP) AS UNIQUE_ZIPS 
FROM ZIP_CODE_METADATA;

---------------------
-- 2: Täckning. Hur många delstater finns med, och hur många postnummer har var och en?
-- svar: 58 stater, 2314 nr_of_zips i tx, 1 nr_of_zipz i as
SELECT 
    STATE, 
    COUNT(ZIP) AS NUMBER_OF_ZIPS 
FROM ZIP_CODE_METADATA 
GROUP BY STATE 
ORDER BY NUMBER_OF_ZIPS DESC;

----------
-- 3: Hitta hål i datan. Hur många rows saknar TOTAL_POPULATION? 
-- Svar: 4 688 rows
SELECT
    COUNT(*) - COUNT(TOTAL_POPULATION) AS MISSING_POP_ROWS
FROM ZIP_CODE_METADATA;

--------
-- 4: Topplista, tio mest folkrika postnumren, med stad och delstat
-- Nulls last är bra att använda i snowflake, de sätter NULLS allra sist och inte först som DESC kan göra
-- Svar: zip 77494, city Katy, state TX och total_pop 126310 på plats nr 1
-- Svar: zip 11385, city Ridgewood, state NY och total_pop 105025 på plats nr 10
SELECT
    ZIP,
    CITY,
    STATE,
    TOTAL_POPULATION
FROM ZIP_CODE_METADATA
ORDER BY TOTAL_POPULATION DESC NULLS LAST
LIMIT 10;

-------
-- 5: Uppåt i nivå. Total befolkning per delstat, SORTERAT. SUM över GROUP BY
-- Svar: State CA population 39182218 
-- svar: AS population null (no value)
SELECT
    STATE,
    SUM(TOTAL_POPULATION) AS STATE_POPULATION
FROM ZIP_CODE_METADATA
GROUP BY STATE
ORDER BY STATE_POPULATION DESC NULLS LAST;

-------
-- 6: Fälla. Ta fram meddelålder PER delstat. Fungerar AVG(MEDIAN_AGE) här?
-- Svar: Det här blir vinklat, simpsons paradox(?) En liten stat och eller ett postnummer med få invånare väger lika tungt
-- som en delstat och postnummer med otroligt många fler människor i sig.
-- Här bör jag skriva en query som aggregerar/räknar ut median age * totala populationen och delar med totala populationen?
-- Fel query här under
-- Svar: State: MO, AVG_OF_MEDIAN_AGE: 42.944674556
SELECT 
    STATE, 
    AVG(MEDIAN_AGE) AS AVG_OF_MEDIAN_AGE 
FROM ZIP_CODE_METADATA 
GROUP BY STATE;

-- 6: Rätt query(?)
-- Svar: State: MO, AVG_OF_MEDIAN_AGE: 39.114919534
SELECT
    STATE,
    SUM(MEDIAN_AGE * TOTAL_POPULATION) / SUM(TOTAL_POPULATION) AS AVG_OF_MEDIAN_AGE
FROM ZIP_CODE_METADATA
GROUP BY STATE;

-------
-- 7: Skevhet. Vilken zip har störst obalans mellan kvinnor och män.
SELECT 
