# Answers for exercise 0:
In this exercise, you get to familiarize yourself with snowflake and snowsql. You will also get some overview of pricing in Snowflake. Further, you'll get an SQL repetition through querying data from snowflakes marketplace.

Now create a worksheet on your local repository and start querying this data through vscode.
## 0) Google Queries

### a) Use this database and find out the underlying schemas, tables and views to get an overview of its logical structure.

| Result column   |      value        | meaning                                                       |
| --------------- | ----------------- | ------------------------------------------------------------- |
| `database_name` | `GOOGLE_KEYWORDS` | The database containing the table                             |
| `schema_name`   | `DATAFEEDS`       | The schema containing the table                               |
| `name`          | `GOOGLE_KEYWORDS` | The table’s name                                              |
| `kind`          | `TABLE`           | This object is a table                                        |
| `created_on`    | `2026-09-06…`     | When the table was created not when the first search happened |

### b) Find out the columns and its data types in the table `GOOGLE_KEYWORDS`.

- `DESCRIBE TABLE google_keywords;`

| name | type |
|:--|:--|
| COUNTRY | NUMBER(38,0) |
| KEYWORD | VARCHAR(16777216) |
| SITE | VARCHAR(16777216) |
| YEAR | VARCHAR(16777216) |
| MONTH | VARCHAR(16777216) |
| DAY | VARCHAR(16777216) |
| PLATFORM | VARCHAR(16777216) |
| REFERRAL_TYPE | VARCHAR(16777216) |
| CLEAN_LANDINGPAGE | VARCHAR(16777216) |
| CALIBRATED_USERS | FLOAT |
| CALIBRATED_CLICKS | FLOAT |
| IS_BRANDED_KEYWORD | NUMBER(38,0) |
| IS_QUESTION | VARCHAR(16777216) |
| DATE | VARCHAR(16777216) |

--- 

### c) Find out number of rows in the dataset.
-   ```
    SELECT COUNT(*) as number_of_rows
    FROM google_keywords;
    ```

- number of rows: 35,046,855 rows
---
### d) When is the first search and when is the latest search in the dataset?

-   ```
    SELECT MIN (DATE) AS first_search, MAX (DATE) AS last_search 
    FROM google_keywords;
    ```
- First search: 22-06-01
- Last search: 22-06-30

---

###  e) Which are the 10 most popular keywords?
```
SELECT keyword, 
    COUNT (*) AS num_of_searches 
FROM google_keywords 
GROUP BY keyword 
ORDER BY num_of_searches 
LIMIT 10;
```
| KEYWORD | NUM_OF_SEARCHES| 
|:--|:--|
| gmail | 36381| 
| youtube | 26847 | 
| facebook | 22003 | 
| google | 17809 | 
| amazon | 14953 | 
| google drive | 14085 | 
| canva | 13881 | 
| instagram | 13334 | 
| netflix | 13068 | 
| roblox | 12260 | 

--- 

### f) How many unique keywords are there?
```
SELECT COUNT(DISTINCT keyword) AS unique_keywords
FROM google_keywords;
```
- Unique keywords: 7,263,686

---

### g) Check what type of platforms are used and how many users per platform
```
SELECT 
    platform,
    COUNT (DISTINCT calibrated_users) AS num_of_users
FROM google_keywords
GROUP BY platform
ORDER BY num_of_users DESC;
```
- Desktop, number of users: 111 473