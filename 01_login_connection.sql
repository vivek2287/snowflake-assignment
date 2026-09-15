-- Part 1: SnowSQL Login and Connection
-- Run this AFTER connecting with:
--   snowsql -a <account_identifier> -u <username>

-- Verify the connection by checking session details
SELECT
    CURRENT_USER()      AS user_name,
    CURRENT_ROLE()      AS role_name,
    CURRENT_WAREHOUSE() AS warehouse_name,
    CURRENT_DATABASE()  AS database_name,
    CURRENT_SCHEMA()    AS schema_name;

-- If database/warehouse show as NULL, set them explicitly:
-- USE WAREHOUSE <your_warehouse>;
-- USE DATABASE <your_database>;
-- USE SCHEMA <your_schema>;
