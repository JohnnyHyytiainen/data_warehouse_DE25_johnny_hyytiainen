-- Skapa ett snowflake warehouse via sql script.
-- Alltid bra att börja med att VISA vilka warehouses som finns tillgängliga
SHOW WAREHOUSES;

-- Testa skapa ett nytt warehouse
CREATE WAREHOUSE demo_warehouse
WITH
WAREHOUSE_SIZE = "X-Small"
AUTO_SUSPEND = 240
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE
COMMENT = "Building a testing/demo warehouse for practice purposes";

SHOW WAREHOUSES;

-- DDL operation: ALTER to modify compute resources (warehouses) and database objects
-- Jag kan alter(ändra) på mina resources och modifiera mina compute resources för att spara credits.
ALTER WAREHOUSE COMPUTE_WH
SET AUTO_SUSPEND = 60;


-- scaling out - horizontal scaling
-- Om jag har flera mindre operations och vill skala med mindre operations som körs sekventiellt.
ALTER WAREHOUSE DEMO_WAREHOUSE
SET MAX_CLUSTER_COUNT = 3;

SHOW WAREHOUSES;

DROP WAREHOUSE DEMO_WAREHOUSE;


SHOW WAREHOUSES;