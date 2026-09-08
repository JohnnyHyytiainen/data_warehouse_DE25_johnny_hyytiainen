-- Showing warehouses
-- Visar vilka warehouses du har
SHOW WAREHOUSES;

-- Skapande av ett nytt warehouse
-- Sätt STORLEKEN på skapade warehouset(VIKTIGT)
-- Storlekarna är 'X-Small', 'Medium', 'Large', 'X-Large'... ...
-- AUTO_SUSPEND = 300 innebär att den droppas efter 5 minuter
-- AUTO_RESUME = TRUE innebär att den startar upp vid användning
CREATE WAREHOUSE warehouse_demo
WITH
WAREHOUSE_SIZE = 'X-Small'
AUTO_SUSPEND = 300
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE
COMMENT = 'Demo warehouse created through a worksheet';

SHOW WAREHOUSES;


-- DDL operation: ALTER to modify compute resources (warehouses) and database objects
-- Jag kan alter(ändra) på mina resources och modifiera mina compute resources för att spara credits.
ALTER WAREHOUSE COMPUTE_WH
SET AUTO_SUSPEND = 60;


-- scaling out - horizontal scaling
-- Om jag har flera mindre operations och vill skala med mindre operations som körs sekventiellt.
ALTER WAREHOUSE WAREHOUSE_DEMO
SET MAX_CLUSTER_COUNT = 3;

SHOW WAREHOUSES;

DROP WAREHOUSE WAREHOUSE_DEMO;

SHOW WAREHOUSES;