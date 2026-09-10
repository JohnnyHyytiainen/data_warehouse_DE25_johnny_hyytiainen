-- genomgång för att skapa databas manuellt via script i snowflake
-- Visa mina nuvarande DBs
SHOW DATABASES;

-- Skapa en DB
-- IF NOT EXISTS för att göra det idempotent.
create database if not exists DEMO_DB;

-- Dags att skapa ett schema
CREATE SCHEMA IF NOT EXISTS DEMO_DB.staging;

-- Skapa en table i mitt schema
-- Column constraint för customer_id med PK, PK col får ej vara null
CREATE TABLE IF NOT EXISTS customer (
    customer_id integer PRIMARY KEY,
    age integer,
    email varchar(50)
);

-- seeda table med data
INSERT INTO customer (customer_id, age, email)
VALUES
(1, 34, 'string@gmail.com'),
(2, 21, 'varchar@gmail.com'),
(3, 18, 'integer@gmail.com');

-- Gör en query för att säkerställa att data finns seedad i min demo databas
SELECT * FROM customer;

-- Droppa den byggda databasen för clean up
DROP DATABASE DEMO_DB;

-- Säkerställ att mitt droppande av databasen verkställdes
SHOW DATABASES;