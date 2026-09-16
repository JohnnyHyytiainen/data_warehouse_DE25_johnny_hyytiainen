-- Using the icecream_writer role, create a new table under the public schema. 
-- This is a table called suppliers with the columns: supplier_id and supplier_name
-- 
-- As an object manager, can you use the role SYSADMIN to drop this table. 
-- Because we find out that this is a wrong table to be created
-- 
-- by going through this step, can you conclude that our lecture/code along sql worksheets 
-- follows strictly the snowflake best practice of access control
USE ROLE icecream_writer;
SELECT CURRENT_ROLE();

-- 
CREATE TABLE suppliers (
    supplier_id INT AUTOINCREMENT,
    supplier_name STRING,
    email STRING,
    PRIMARY KEY (supplier_id)
);

