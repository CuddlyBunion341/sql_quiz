-- Task 2: Aggregate functions with GROUP BY and HAVING
-- This file demonstrates COUNT, AVG, SUM, MIN, MAX

-- Setup: Create and populate a restaurant database
-- Create two tables: 'restaurants' and 'menu_items'
--
-- restaurants: id, name, street, cuisine_type, soup_price
-- Data:
-- 1. Löwen, Bahnhofstrasse, Swiss, 4.50
-- 2. Pizzeria Roma, Bachweg, Italian, 3.80
-- 3. Sushi Palace, Seebach, Japanese, 5.20
-- 4. Le Gourmet, Bahnhofstrasse, French, 6.50
-- 5. Burger King, Bachstrasse, American, 3.20
-- 6. Rössli, Bahnhofstrasse, Swiss, 4.80
--
-- menu_items: id, restaurant_id, item_name, price, category
-- Data for menu items as described in original file

-- TODO: Create restaurants table

-- TODO: Create menu_items table with foreign key

-- TODO: Insert restaurant data

-- TODO: Insert menu items data

-- Query 1: What is the average soup price across all restaurants?
-- TODO: Write a query using AVG to calculate average soup price

-- Query 2: Which streets have at least 3 restaurants? (Use GROUP BY and HAVING)
-- TODO: Write a query using GROUP BY and HAVING to find streets with 3+ restaurants

-- Query 3: For each restaurant, show the number of menu items and average price
-- TODO: Write a query using LEFT JOIN, COUNT, and AVG grouped by restaurant

-- Query 4: Find the minimum and maximum soup prices
-- TODO: Write a query using MIN and MAX aggregate functions

-- Query 5: Show cuisine types with total number of restaurants
-- TODO: Write a query using GROUP BY and COUNT, ordered by count descending
