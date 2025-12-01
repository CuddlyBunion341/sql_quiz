-- Task 2: Aggregate functions with GROUP BY and HAVING
-- This file demonstrates COUNT, AVG, SUM, MIN, MAX

-- Setup: Create and populate a restaurant database
CREATE TABLE IF NOT EXISTS restaurants (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    street VARCHAR(100),
    cuisine_type VARCHAR(50),
    soup_price DECIMAL(5,2)
);

CREATE TABLE IF NOT EXISTS menu_items (
    id INTEGER PRIMARY KEY,
    restaurant_id INTEGER,
    item_name VARCHAR(100),
    price DECIMAL(5,2),
    category VARCHAR(50),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);

INSERT INTO restaurants (id, name, street, cuisine_type, soup_price) VALUES
(1, 'Löwen', 'Bahnhofstrasse', 'Swiss', 4.50),
(2, 'Pizzeria Roma', 'Bachweg', 'Italian', 3.80),
(3, 'Sushi Palace', 'Seebach', 'Japanese', 5.20),
(4, 'Le Gourmet', 'Bahnhofstrasse', 'French', 6.50),
(5, 'Burger King', 'Bachstrasse', 'American', 3.20),
(6, 'Rössli', 'Bahnhofstrasse', 'Swiss', 4.80);

INSERT INTO menu_items (id, restaurant_id, item_name, price, category) VALUES
(1, 1, 'Cheese Fondue', 22.50, 'Main'),
(2, 1, 'Rösti', 18.00, 'Main'),
(3, 2, 'Margherita Pizza', 12.50, 'Main'),
(4, 2, 'Pasta Carbonara', 14.80, 'Main'),
(5, 3, 'Sushi Platter', 25.00, 'Main'),
(6, 4, 'Coq au Vin', 28.50, 'Main'),
(7, 5, 'Cheeseburger', 9.90, 'Main'),
(8, 5, 'Fries', 4.50, 'Side'),
(9, 6, 'Zürcher Geschnetzeltes', 24.00, 'Main');

-- Query 1: What is the average soup price across all restaurants?
SELECT AVG(soup_price) AS average_soup_price FROM restaurants;

-- Query 2: Which streets have at least 3 restaurants? (Use GROUP BY and HAVING)
SELECT street, COUNT(*) AS restaurant_count
FROM restaurants
GROUP BY street
HAVING COUNT(*) >= 3;

-- Query 3: For each restaurant, show the number of menu items and average price
SELECT r.name, COUNT(m.id) AS item_count, AVG(m.price) AS avg_price
FROM restaurants r
LEFT JOIN menu_items m ON r.id = m.restaurant_id
GROUP BY r.name;

-- Query 4: Find the minimum and maximum soup prices
SELECT MIN(soup_price) AS min_price, MAX(soup_price) AS max_price FROM restaurants;

-- Query 5: Show cuisine types with total number of restaurants
SELECT cuisine_type, COUNT(*) AS count
FROM restaurants
GROUP BY cuisine_type
ORDER BY count DESC;
