-- Task 3: JOINs (INNER, LEFT, RIGHT, CROSS) and combinations
-- This file demonstrates various types of joins

-- Setup: Create and populate visitor and guest databases
-- NOTE: This task requires the restaurants table from Task 2
--
-- visitors table: name, first_name, street, city (composite primary key on name, first_name)
-- Data:
-- Müller, Peter, Bachweg 5, Zürich
-- Schmidt, Anna, Seebach 12, Zürich
-- Weber, Hans, Bahnhofstrasse 8, Bern
-- Meyer, Sophie, Hauptstrasse 3, Basel
-- Fischer, Thomas, Rosenbach 7, Zürich
-- Hoffmann, Maria, Kirchweg 15, Bern
--
-- guests table: guest_name, guest_first_name, restaurant_name, frequency
-- Data as in original file

-- TODO: Create visitors table

-- TODO: Create guests table

-- TODO: Insert visitor data

-- TODO: Insert guest data

-- Query 1: Create a CROSS JOIN between restaurants and visitors
-- (Shows all possible combinations - useful for generating complete matrices)
-- TODO: Write a CROSS JOIN query between restaurants and visitors, limit to 10 results

-- Query 2: Show visitors with their restaurant visit frequency
-- Use LEFT JOIN to include visitors who never visited any restaurant (frequency = 0)
-- TODO: Write a LEFT JOIN query using COALESCE to show 0 for visitors with no restaurant visits

-- Query 3: Show only visitors who are also guests (INNER JOIN)
-- TODO: Write an INNER JOIN query to show only visitors who have restaurant visits

-- Query 4: Find visitors living on streets containing 'bach' (case-insensitive)
-- TODO: Write a query using LIKE to find visitors on streets containing 'bach'

-- Query 5: Show all guests with their full visitor information and restaurant details
-- TODO: Write an INNER JOIN query showing visitor info and restaurant details, ordered by name
