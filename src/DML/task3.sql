-- Task 3: JOINs (INNER, LEFT, RIGHT, CROSS) and combinations
-- This file demonstrates various types of joins

-- Setup: Create and populate visitor and guest databases
CREATE TABLE IF NOT EXISTS visitors (
    name VARCHAR(50),
    first_name VARCHAR(50),
    street VARCHAR(100),
    city VARCHAR(50),
    PRIMARY KEY (name, first_name)
);

CREATE TABLE IF NOT EXISTS guests (
    guest_name VARCHAR(50),
    guest_first_name VARCHAR(50),
    restaurant_name VARCHAR(100),
    frequency INTEGER,
    PRIMARY KEY (guest_name, guest_first_name, restaurant_name)
);

INSERT INTO visitors (name, first_name, street, city) VALUES
('Müller', 'Peter', 'Bachweg 5', 'Zürich'),
('Schmidt', 'Anna', 'Seebach 12', 'Zürich'),
('Weber', 'Hans', 'Bahnhofstrasse 8', 'Bern'),
('Meyer', 'Sophie', 'Hauptstrasse 3', 'Basel'),
('Fischer', 'Thomas', 'Rosenbach 7', 'Zürich'),
('Hoffmann', 'Maria', 'Kirchweg 15', 'Bern');

INSERT INTO guests (guest_name, guest_first_name, restaurant_name, frequency) VALUES
('Müller', 'Peter', 'Löwen', 3),
('Schmidt', 'Anna', 'Pizzeria Roma', 2),
('Weber', 'Hans', 'Le Gourmet', 1),
('Müller', 'Peter', 'Pizzeria Roma', 2),
('Schmidt', 'Anna', 'Löwen', 4);

-- Query 1: Create a CROSS JOIN between restaurants and visitors
-- (Shows all possible combinations - useful for generating complete matrices)
SELECT r.name AS restaurant, v.name AS visitor_name, v.first_name
FROM restaurants r
CROSS JOIN visitors v
LIMIT 10;

-- Query 2: Show visitors with their restaurant visit frequency
-- Use LEFT JOIN to include visitors who never visited any restaurant (frequency = 0)
SELECT v.name, v.first_name, COALESCE(g.frequency, 0) AS visit_frequency
FROM visitors v
LEFT JOIN guests g ON v.name = g.guest_name AND v.first_name = g.guest_first_name;

-- Query 3: Show only visitors who are also guests (INNER JOIN)
SELECT DISTINCT v.name, v.first_name, v.street
FROM visitors v
INNER JOIN guests g ON v.name = g.guest_name AND v.first_name = g.guest_first_name;

-- Query 4: Find visitors living on streets containing 'bach' (case-insensitive)
SELECT name, first_name, street
FROM visitors
WHERE street LIKE '%bach%' OR street LIKE '%Bach%';

-- Query 5: Show all guests with their full visitor information and restaurant details
SELECT v.name, v.first_name, v.street, g.restaurant_name, g.frequency
FROM visitors v
INNER JOIN guests g ON v.name = g.guest_name AND v.first_name = g.guest_first_name
ORDER BY v.name, v.first_name;
