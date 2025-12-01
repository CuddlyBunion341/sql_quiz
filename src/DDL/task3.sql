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

CREATE TABLE departments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100)
);

CREATE TABLE employees (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    department_id INTEGER,
    salary DECIMAL(10,2) CHECK (salary > 0),
    hire_date DATE NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL
);
