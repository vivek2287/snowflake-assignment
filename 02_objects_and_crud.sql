-- Part 2: Creation of Snowflake Objects + CRUD

-- 1. Database
CREATE DATABASE IF NOT EXISTS assignment_db;

-- 2. Schema
CREATE SCHEMA IF NOT EXISTS assignment_db.assignment_schema;

-- 3. Warehouse
CREATE WAREHOUSE IF NOT EXISTS assignment_wh
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE;

-- Set context
USE WAREHOUSE assignment_wh;
USE DATABASE assignment_db;
USE SCHEMA assignment_schema;

-- 4. Table
CREATE TABLE IF NOT EXISTS students (
    student_id INT,
    name       STRING,
    branch     STRING,
    marks      INT
);

-- 5. Stage (for file loading in Part 3)
CREATE STAGE IF NOT EXISTS my_stage;

-- Insert sample records
INSERT INTO students VALUES
    (1, 'Vivek',    'CSE-BigData', 88),
    (2, 'Akash',    'CSE',         75),
    (3, 'Praneeth', 'CSE',         91);

-- SELECT
SELECT * FROM students;

-- UPDATE
UPDATE students SET marks = 95 WHERE student_id = 1;

-- DELETE
DELETE FROM students WHERE student_id = 2;

-- Verify final state
SELECT * FROM students;
