-- Task 2: Create a table with check constraints
-- Create a table named 'products' with the following columns:
-- - id: integer, primary key, auto-increment
-- - name: variable character string (max 100), not null
-- - price: decimal (10,2), must be greater than 0
-- - quantity: integer, must be >= 0
-- - category: variable character string (max 50)
-- - check constraint: ensure price * quantity < 1000000

CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0),
    quantity INTEGER CHECK (quantity >= 0),
    category VARCHAR(50),
    CHECK (price * quantity < 1000000)
);
