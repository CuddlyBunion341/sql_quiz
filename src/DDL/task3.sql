-- Task 3: Create tables with foreign key relationships
-- Create two tables: 'departments' and 'employees'
--
-- departments table:
-- - id: integer, primary key, auto-increment
-- - name: variable character string (max 100), not null, unique
-- - location: variable character string (max 100)
--
-- employees table:
-- - id: integer, primary key, auto-increment
-- - name: variable character string (max 100), not null
-- - department_id: integer, foreign key references departments(id)
-- - salary: decimal (10,2), check salary > 0
-- - hire_date: date, not null
-- - foreign key constraint with ON DELETE SET NULL

-- TODO: Implement the departments table

-- TODO: Implement the employees table with foreign key relationship
