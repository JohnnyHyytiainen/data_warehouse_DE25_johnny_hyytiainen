-- Välj ROLE
 USE ROLE SYSADMIN;

-- Se över vilken ROLE som är aktiv för tillfället
 SELECT CURRENT_ROLE();

-- Se om SECONDARY ROLES ÄR AKTIVA
SELECT CURRENT_SECONDARY_ROLES();

-- Skapa DB
CREATE DATABASE IF NOT EXISTS icecream_db;

-- Välj warehouse
USE WAREHOUSE dev_wh;

-- Välj SCHEMA att använda
USE SCHEMA icecream_db.public; 

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

--
