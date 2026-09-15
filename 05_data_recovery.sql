-- Part 5: Data Recovery Using Time Travel
-- Scenario: id=2 was accidentally deleted in 04_time_travel.sql
USE WAREHOUSE assignment_wh;
USE DATABASE assignment_db;
USE SCHEMA assignment_schema;

-- Step 1: find the query_id of the DELETE statement
-- Easiest way: check query history
SELECT query_id, query_text, start_time
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY())
WHERE query_text ILIKE '%DELETE FROM tt_demo%'
ORDER BY start_time DESC
LIMIT 1;

-- Step 2: identify exactly what was deleted, by comparing
-- the table's state BEFORE the delete to its state NOW
SELECT * FROM tt_demo BEFORE (STATEMENT => '<delete_query_id>')
MINUS
SELECT * FROM tt_demo;

-- Step 3: recover the missing row(s) by inserting them back
INSERT INTO tt_demo
SELECT * FROM tt_demo BEFORE (STATEMENT => '<delete_query_id>')
WHERE id = 2;

-- Step 4: confirm the row is back
SELECT * FROM tt_demo ORDER BY id;
