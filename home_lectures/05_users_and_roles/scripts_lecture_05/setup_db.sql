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

-- Sysadmin är ansvarig för att skapa DBs 
-- if not exists (för idempotens)
CREATE DATABASE IF NOT EXISTS icecream_db;

-- Visa mina warehouses(Compute)
Show warehouses;

-- Droppar min skapade demo_Warehouse ifrån tidigare lektion 00-04 vecka 37.
DROP WAREHOUSE demo_warehouse;

-- Skapa table för glass smakerna
CREATE TABLE flavors (
    flavor_id INT AUTOINCREMENT,
    flavor_name STRING,
    price DECIMAL(5, 2),
    PRIMARY KEY (flavor_id)
);

-- Skapa table för kunder
CREATE TABLE customers (
    customer_id INT AUTOINCREMENT,
    customer_name STRING,
    email STRING,
    PRIMARY KEY (customer_id)
);

-- Skapa table för transaktioner
CREATE TABLE transactions (
    transaction_id INT AUTOINCREMENT,
    customer_id INT,
    flavor_id INT,
    quantity INT,
    transaction_date TIMESTAMP,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (flavor_id) REFERENCES flavors (flavor_id)
);
