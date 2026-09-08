-- Vilka warehouses finns?
SHOW WAREHOUSES;

-- Slå på beräkningen (COMPUTE_WH finns förvalt i ett nytt konto)
USE WAREHOUSE COMPUTE_WH;

-- Se efter vilka databaser jag har
SHOW DATABASES;

-- Använd mig av den databasen jag vill använda
USE DATABASE google_keywords_search_dataset_discover_all_searches_on_google;

-- Visa dess schemas
SHOW SCHEMAS;

-- Välj vilket SCHEMA jag ska anävnda(datafeeds som innehåller GOOGLE_KEYWORDS table)
USE SCHEMA DATAFEEDS;


-- B) Find out the columns and its  data types in the table google_keywords
DESCRIBE TABLE google_keywords;

-- Nu räcker det korta namnet
SELECT * FROM google_keywords LIMIT 10;

-- C) Number of rows in the dataset
-- Svar: 35046855 rader
SELECT COUNT(*) as number_of_rows
FROM google_keywords;

-- D) When is the first search and when is the latest search in the dataset?
-- First search: 22-06-01
-- Last search: 22-06-30
SELECT MIN (DATE) AS first_search, MAX (DATE) AS last_search 
FROM google_keywords;

-- E) What are the 10 most popular keywords?
SELECT keyword, 
    COUNT(*) AS num_of_searches 
FROM google_keywords 
GROUP BY keyword 
ORDER BY num_of_searches DESC
LIMIT 10;

-- F) How many unique keywords are there?
-- 7263686
SELECT COUNT(DISTINCT keyword) AS unique_keywords
FROM google_keywords;

-- G) Check what type of platforms are used and how many users there are per platform
-- Desktop
-- 111473
SELECT 
    platform,
    COUNT (DISTINCT calibrated_users) AS num_of_users
FROM google_keywords
GROUP BY platform
ORDER BY num_of_users DESC;

-- H) Let's dive into what swedish people are searching. Go into worldbanks country codes to find out the country code for Sweden. 
-- Find the 20 most popular keywords and the number of searches of that keyword.
-- gmail	403 
-- länsförsäkringar	243
-- 1177	243
-- youtube	243
-- google drive	220
-- porn	204
-- facebook	190
-- youtube to mp3	188
-- google	174
-- spotify	170
-- foodora	165
-- hotmail	161
-- disney plus	154
-- hbo	154
-- google translate	152
-- postnord	151
-- translate	151
-- netflix	149
-- sas	144
-- outlook	143
SELECT 
    keyword,
    COUNT (*) AS num_of_searches
FROM google_keywords
WHERE country = 752
GROUP BY keyword
ORDER BY num_of_searches DESC
LIMIT 20;


-- I) Lets see how popular spotify is around the world. List the top 10 number countries and the number of searches for spotify.
SELECT
    country,
    COUNT(*) AS num_of_searches
FROM google_keywords
WHERE keyword = 'spotify'
GROUP BY country
ORDER BY num_of_searches DESC
LIMIT 10;
