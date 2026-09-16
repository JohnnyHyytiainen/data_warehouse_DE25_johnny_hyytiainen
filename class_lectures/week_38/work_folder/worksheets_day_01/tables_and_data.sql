USE ROLE icecream_writer;
USE WAREHOUSE dev_wh;
USE SCHEMA icecream_db.public;


INSERT INTO flavors (flavor_name, price) VALUES
('Vanilla', 2.50),
('Chocolate', 2.75),
('Strawberry', 2.50),
('Mint Chocolate Chip', 3.00),
('Cookie Dough', 3.25),
('French Vanilla', 6.90);

-- insert data i customer table
INSERT INTO customers (customer_name, email) VALUES
('Claude Opus', 'john.doe@OpenAI.com'),
('GPT Fable', 'jane.smith@Anthropic.com'),
('Gemini Astra', 'alice.johnson@Google-deepmind.com'),
('Haiku Flash', 'haiku.flash@OpenGemini.com');


-- insert data i transaktion table
INSERT INTO transactions (
    customer_id, flavor_id, quantity, transaction_date
) VALUES
(1, 6, 3, CURRENT_TIMESTAMP),
(2, 4, 4, CURRENT_TIMESTAMP),
(3, 1, 1, CURRENT_TIMESTAMP),
(4, 2, 5, CURRENT_TIMESTAMP),
(2, 4, 6, CURRENT_TIMESTAMP),
(3, 2, 7, CURRENT_TIMESTAMP),
(4, 3, 8, CURRENT_TIMESTAMP),
(2, 4, 2, CURRENT_TIMESTAMP),
(1, 5, 3, CURRENT_TIMESTAMP);


-- Testing
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


-- BYT ROLE Till ice_cream_reader
USE ROLE icecream_reader;
-- Läs ifrån den rollen
SELECT * FROM customers;

-- Testa seeda mina tables med reader rollen. Menat att krascha
INSERT INTO customers (customer_name, email) VALUES ('Sol Sonnet', 'Sol.Sonnet@google-deepmind.com');

USE ROLE icecream_writer;
INSERT INTO customers (customer_name, email) VALUES ('Sol Sonnet', 'sol.sonnet@google-deempind.com');

SELECT * FROM customers;