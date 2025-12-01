-- Task 1: Create a simple table with basic data types
-- Create a table named 'students' with the following columns:
-- - id: integer, primary key
-- - first_name: variable character string (max 50), not null
-- - last_name: variable character string (max 50), not null
-- - email: variable character string (max 100), unique
-- - birth_date: date
-- - created_at: timestamp with default value of current timestamp

CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    birth_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
