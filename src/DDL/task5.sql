-- Task 5: Database cleanup and DROP operations
-- This task teaches how to properly clean up database objects
--
-- Setup: First create the library tables from Task 4
-- Then implement the cleanup operations below

-- Part 1: Create the library schema (from Task 4)
-- TODO: Create authors table

-- TODO: Create books table with foreign key to authors

-- TODO: Create borrowers table

-- TODO: Create loans table with foreign keys


-- Part 2: Cleanup operations
-- Drop tables in the correct order (respecting foreign key dependencies)
-- Remember: Tables with foreign keys must be dropped before the tables they reference

-- TODO: Drop the loans table

-- TODO: Drop the borrowers table

-- TODO: Drop the books table

-- TODO: Drop the authors table


-- Part 3: Safe cleanup with IF EXISTS
-- Recreate all tables, then drop them safely using IF EXISTS
-- This prevents errors if tables don't exist

-- TODO: Recreate all four tables (authors, books, borrowers, loans)

-- TODO: Drop all tables safely using DROP TABLE IF EXISTS in correct order
