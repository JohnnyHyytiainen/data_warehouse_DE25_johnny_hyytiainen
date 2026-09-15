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


---

## 1) How much does it cost?


For Standard Edition on Microsoft Azure, Sweden Central, the on-demand rate is US$2.40 per credit. Snowflake pricing table
Monthly cost = total credits × $2.40

| Exercise                | How to calculate the credits                                                    | Monthly credits | Monthly cost (USD) |
| ----------------------- | ------------------------------------------------------------------------------- | --------------: | -----------------: |
| **a) Daily workload**   | 0.5 × 30 days                                                                   |          **15** |            **$36** |
| **b) Varying workload** | (2 × 10 days) + (1.5 × 10 days) + (1 × 10 days)                                 |          **45** |           **$108** |
| **c) Three warehouses** | A: 1 × 10 hours × 30 = 300; B: 2 × 2 hours × 30 = 120; C: 4 × 1 hour × 30 = 120 |         **540** |         **$1,296** |
| **d) Scaling clusters** | (2 clusters × 10 hours × 10 days) + (3 × 10 × 10) + (4 × 10 × 10)               |         **900** |        **$2,160*** |


# Exercise 2: Theory Questions

| Question                                                                                              | Beginner-friendly answer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| ----------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **a) What are the main components of Snowflake’s architecture?**                                      | Snowflake has **three layers: storage, compute, and cloud services**. Storage keeps the data, compute processes it, and cloud services coordinates how everything works. [Source](https://docs.snowflake.com/en/user-guide/intro-key-concepts)                                                                                                                                                                                                                                                                                                                                                                        |
| **b) What is the role of the storage layer?**                                                         | It **stores your data in the cloud**. Snowflake automatically organizes, compresses, and encrypts it. Storage is separate from compute, so your data remains available even when your virtual warehouse is stopped. [Source](https://docs.snowflake.com/en/user-guide/intro-key-concepts)                                                                                                                                                                                                                                                                                                                             |
| **c) What is the purpose of the compute layer?**                                                      | It provides the **processing power to run queries, load data, and transform data**. For example, when you count searches by country, a virtual warehouse performs that work. [Source](https://docs.snowflake.com/en/user-guide/warehouses)                                                                                                                                                                                                                                                                                                                                                                            |
| **d) How does the cloud services layer help Snowflake work?**                                         | It **coordinates tasks behind the scenes**, including checking logins and permissions, tracking information about tables, and planning how SQL queries should run efficiently. [Source](https://docs.snowflake.com/en/user-guide/intro-key-concepts)                                                                                                                                                                                                                                                                                                                                                                  |
| **e) What is a virtual warehouse, and how is it different from a traditional data warehouse?**        | A **virtual warehouse is a group of compute resources** used to process data. It does not permanently store your tables. A traditional data warehouse usually refers to the whole system, including storage and processing. Snowflake separates these, letting you resize or stop compute without moving your stored data. [Source](https://docs.snowflake.com/en/user-guide/warehouses)                                                                                                                                                                                                                              |
| **f) When should you scale up versus scale out?**                                                     | **Scale up** means making a warehouse larger, such as XS → M. Use it when a demanding query needs more processing power. **Scale out** means adding clusters to handle more queries at the same time. Use it when many users or jobs cause queries to queue. Multi-cluster warehouses require Enterprise Edition or higher. [Source](https://docs.snowflake.com/en/user-guide/warehouses-considerations)                                                                                                                                                                                                              |
| **g) How does Snowflake pricing differ from traditional on-premise data warehousing?**                | With **Snowflake**, you pay for resources consumed, including compute and storage separately. You can stop warehouses to stop their compute consumption. With **on-premise systems**, you usually buy hardware and licenses upfront and pay for maintenance, electricity, and staff—even when the hardware is idle. [Snowflake cost model](https://docs.snowflake.com/en/user-guide/cost-understanding-overall)                                                                                                                                                                                                       |
| **h) What is the difference between pay-as-you-go and upfront storage? When should you choose each?** | **Pay-as-you-go (On Demand)** means paying for usage without a long-term commitment. It suits learning, small projects, or uncertain demand. **Upfront commitment (Capacity)** means committing to spending in advance for discounted pricing. It suits organizations with predictable, ongoing usage. In both cases, storage charges depend on how much data you actually store; Capacity is a purchasing agreement, not a fixed disk you buy. [Source](https://docs.snowflake.com/en/user-guide/intro-editions)                                                                                                     |
| **i) What are Time Travel and Fail-safe, and when are they useful?**                                  | **Time Travel** lets you query earlier versions of data and recover from mistakes, such as accidental updates or dropped tables, within the retention period. Your Standard Edition supports **up to 1 day**. **Fail-safe** provides an additional **7-day recovery period for permanent tables** after Time Travel ends. Snowflake handles this recovery as a last resort; you cannot query Fail-safe data yourself. Temporary and transient tables have no Fail-safe. [Time Travel](https://docs.snowflake.com/en/user-guide/data-time-travel), [Fail-safe](https://docs.snowflake.com/en/user-guide/data-failsafe) |

# Exercise 3: Glossary

| **Terminology**       | **Explanation**                                                                                                                                         |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **downstream**        | A later step in a data pipeline. For example, a dashboard is downstream from the tables it reads.                                                       |
| **upstream**          | An earlier step that supplies data to later steps. For example, a source API is upstream from the database receiving its data.                          |
| **data warehouse**    | A system that brings together data for analysis and reporting, often including historical data from multiple sources.                                   |
| **cloud computing**   | Using computing resources, such as storage and processing power, over the internet instead of running your own physical servers.                        |
| **OLAP**              | **Online Analytical Processing.** Analyzing large amounts of data to answer questions, such as “What were our sales per country last year?”             |
| **OLTP**              | **Online Transaction Processing.** Handling everyday transactions quickly, such as placing an order or updating an account balance.                     |
| **virtual warehouse** | Snowflake’s compute resources for running queries, loading data, and transforming data. Your tables remain stored separately when it stops.             |
| **external stage**    | A Snowflake object that points to files in external cloud storage, such as Azure Blob Storage or Amazon S3. It is used to load or unload data.          |
| **data consumer**     | A person, application, or team that uses data. For example, an analyst reading a table to create a report.                                              |
| **scaling out**       | Adding more compute clusters to handle more work at the same time, such as many users running queries simultaneously.                                   |
| **scaling up**        | Increasing the size of a compute cluster to give it more resources, such as changing a Snowflake warehouse from XS to M.                                |
| **snowflake credit**  | A unit used to measure compute consumption. Its dollar price depends on your edition, cloud provider, region, and pricing agreement.                    |
| **securable object**  | Something in Snowflake that you can control access to using permissions, such as a database, schema, table, or warehouse.                               |
| **schema**            | A named container inside a database that organizes tables, views, and other objects. Your `DATAFEEDS` schema is an example.                             |
| **permanent table**   | The default Snowflake table type. It stays until explicitly dropped and supports both Time Travel and Fail-safe protection.                             |
| **transient table**   | A table that stays until explicitly dropped but has **no Fail-safe** and at most one day of Time Travel. Useful for intermediate data you can recreate. |
| **temporary table**   | A table available only within the session that created it. Snowflake removes it when that session ends. Useful for short-term processing.               |
| **time-travel**       | Accessing earlier versions of data within a retention period. Useful for checking previous values or recovering from accidental changes.                |
| **fail-safe**         | An additional seven-day recovery period for permanent table data after Time Travel ends. Snowflake manages this last-resort recovery.                   |
| **view**              | A saved query that you can query like a table. A regular view stores the query definition rather than its own separate copy of the results.             |
| **table**             | An object that stores data in rows and columns. Columns describe fields, and rows contain individual records.                                           |
| **DML**               | **Data Manipulation Language.** Commands that change table data, such as `INSERT`, `UPDATE`, `DELETE`, and `MERGE`.                                     |
| **DDL**               | **Data Definition Language.** Commands that create or change database objects, such as `CREATE`, `ALTER`, and `DROP`.                                   |
| **DQL**               | **Data Query Language.** A common term for commands that retrieve data, mainly `SELECT`. Some SQL classifications include querying under DML.           |
| **DCL**               | **Data Control Language.** Commands that control permissions, such as `GRANT` to give access and `REVOKE` to remove access.                             |