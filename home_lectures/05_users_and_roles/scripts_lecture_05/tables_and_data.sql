-- Script för att "seeda" mina tables med data.
-- Välj roll, warehouse, och schema för att kunna fylla tables med data
USE ROLE ice_cream_writer;
USE WAREHOUSE dev_wh;
USE SCHEMA icecream_db.public;

-- Väl inne i mitt schema så ska jag seeda mina tables
-- Insert data in i smaker
INSERT INTO flavors (flavor_name, price) VALUES
('Vanilla', 2.50),
('Chocolate', 2.75),
('Strawberry', 2.50),
('Mint Chocolate Chip', 3.00),
('Cookie Dough', 3.25);

-- insert data i customer table
INSERT INTO customers (customer_name, email) VALUES
('Claude Opus', 'john.doe@OpenAI.com'),
('GPT Fable', 'jane.smith@Anthropic.com'),
('Gemini Astra', 'alice.johnson@Google-deepmind.com');


-- insert data i transaktion table
INSERT INTO transactions (
    customer_id, flavor_id, quantity, transaction_date
) VALUES
(1, 1, 2, CURRENT_TIMESTAMP),
(2, 2, 1, CURRENT_TIMESTAMP),
(3, 3, 3, CURRENT_TIMESTAMP),
(1, 4, 1, CURRENT_TIMESTAMP),
(2, 5, 2, CURRENT_TIMESTAMP);

-- Simple query mot flavors, customers, transaktioner
SELECT * FROM FLAVORS;
SELECT * FROM CUSTOMERS;
SELECT * FROM TRANSACTIONS;
-- Se vilken kund som är "tjockast" och gillar glass mest.
SELECT
    c.customer_name,
    t.quantity,
FROM customers AS c
INNER JOIN transactions AS t
    ON c.customer_id = t.customer_id;

--
-- BYT ROLE Till ice_cream_reader
USE ROLE ice_cream_reader;
-- Läs ifrån den rollen
SELECT * FROM customers;

-- Testa seeda mina tables med reader rollen.
-- Ska krascha(?)
-- (CC(?))
INSERT INTO customers (customer_name, email) VALUES ('Sol Sonnet', 'Sol.Sonner@google-deepmind.com');


-- Varför det inte kraschade:
-- Jag använde tydligen flera roller i en. Både ice_cream_writer, accountadmin, orgadmin. Value var ALL....
SELECT CURRENT_SECONDARY_ROLES();

SELECT * FROM transactions;