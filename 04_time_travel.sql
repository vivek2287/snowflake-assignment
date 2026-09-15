-- Part 4: Snowflake Time Travel
USE WAREHOUSE assignment_wh;
USE DATABASE assignment_db;
USE SCHEMA assignment_schema;

-- Create a fresh table for this demo
CREATE OR REPLACE TABLE tt_demo (
    id  INT,
    val STRING
);

-- Insert sample records
INSERT INTO tt_demo VALUES (1, 'A'), (2, 'B'), (3, 'C');

SELECT * FROM tt_demo;

-- Note the current time (useful for AT/BEFORE queries)
SELECT CURRENT_TIMESTAMP();

-- Perform an UPDATE
UPDATE tt_demo SET val = 'Z' WHERE id = 1;

-- Perform a DELETE
DELETE FROM tt_demo WHERE id = 2;

-- Current state (id=2 is gone, id=1 changed)
SELECT * FROM tt_demo;

-- ===== Query past versions with Time Travel =====

-- Option A: go back by a time offset (in seconds), e.g. 5 minutes ago
SELECT * FROM tt_demo AT (OFFSET => -60*5);

-- Option B: go back to an exact timestamp
-- SELECT * FROM tt_demo AT (TIMESTAMP => '2026-09-15 15:00:00'::TIMESTAMP);

-- Option C: go back to before a specific query (get the query_id first)
SELECT LAST_QUERY_ID();  -- run this right after the DELETE to capture its id
-- SELECT * FROM tt_demo BEFORE (STATEMENT => '<paste_query_id_here>');
