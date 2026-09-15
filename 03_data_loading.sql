-- Part 3: Data Loading Using SnowSQL
-- Make sure you're using the right context first
USE WAREHOUSE assignment_wh;
USE DATABASE assignment_db;
USE SCHEMA assignment_schema;

-- Upload the local CSV file to the stage
-- IMPORTANT: replace the path below with the actual location of sample_data.csv
-- on YOUR machine (this command only works inside the SnowSQL CLI, not Snowsight)
PUT file:///full/path/to/sample_data.csv @my_stage;

-- Check the file arrived in the stage
LIST @my_stage;

-- Load the data into the students table
COPY INTO students
FROM @my_stage/sample_data.csv
FILE_FORMAT = (
    TYPE = CSV
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
)
ON_ERROR = 'CONTINUE';

-- Verify the data loaded successfully
SELECT * FROM students ORDER BY student_id;

-- Count check
SELECT COUNT(*) AS total_rows FROM students;
