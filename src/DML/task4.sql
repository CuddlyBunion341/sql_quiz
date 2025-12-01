-- Task 4: Advanced queries with subqueries, UNION, complex conditions
-- This file demonstrates complex SQL patterns

-- Setup: Create and populate a beer/brewery database
CREATE TABLE IF NOT EXISTS breweries (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS beers (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brewery_id INTEGER,
    type VARCHAR(50),
    stock INTEGER,
    FOREIGN KEY (brewery_id) REFERENCES breweries(id)
);

CREATE TABLE IF NOT EXISTS beer_ratings (
    id INTEGER PRIMARY KEY,
    beer_id INTEGER,
    visitor_name VARCHAR(50),
    rating INTEGER CHECK (rating BETWEEN 1 AND 10),
    FOREIGN KEY (beer_id) REFERENCES beers(id)
);

INSERT INTO breweries (id, name, country) VALUES
(1, 'Feldschlösschen', 'Switzerland'),
(2, 'Calanda', 'Switzerland'),
(3, 'Guinness', 'Ireland'),
(4, 'Heineken', 'Netherlands');

INSERT INTO beers (id, name, brewery_id, type, stock) VALUES
(1, 'Feldschlösschen Original', 1, 'Lager', 150),
(2, 'Feldschlösschen Dunkel', 1, 'Dark', 80),
(3, 'Calanda Bräu', 2, 'Lager', 120),
(4, 'Guinness Draught', 3, 'Stout', 200),
(5, 'Heineken Lager', 4, 'Lager', 180),
(6, 'Calanda IPA', 2, 'IPA', 90);

INSERT INTO beer_ratings (id, beer_id, visitor_name, rating) VALUES
(1, 1, 'Müller Peter', 8),
(2, 1, 'Schmidt Anna', 8),
(3, 1, 'Weber Hans', 8),
(4, 2, 'Müller Peter', 7),
(5, 2, 'Schmidt Anna', 9),
(6, 3, 'Weber Hans', 6),
(7, 4, 'Müller Peter', 10),
(8, 5, 'Schmidt Anna', 7);

-- Query 1: What is the average stock level for all beers? (Named as 'average_stock')
SELECT AVG(stock) AS average_stock FROM beers;

-- Query 2: Which beers have been rated with the same rating by all reviewers?
-- (Hint: minimum rating = maximum rating for that beer)
SELECT b.name, MIN(br.rating) AS consistent_rating
FROM beers b
INNER JOIN beer_ratings br ON b.id = br.beer_id
GROUP BY b.name
HAVING MIN(br.rating) = MAX(br.rating);

-- Query 3: List breweries with the number of beer types they produce
-- and the total stock across all their beers
SELECT br.name, COUNT(DISTINCT b.type) AS beer_types, SUM(b.stock) AS total_stock
FROM breweries br
LEFT JOIN beers b ON br.id = b.brewery_id
GROUP BY br.name;

-- Query 4: Find beers that have stock above the average stock level (subquery)
SELECT name, stock
FROM beers
WHERE stock > (SELECT AVG(stock) FROM beers);

-- Query 5: Show all Swiss beers and Irish beers using UNION
SELECT b.name, br.country, b.stock
FROM beers b
INNER JOIN breweries br ON b.brewery_id = br.id
WHERE br.country = 'Switzerland'
UNION
SELECT b.name, br.country, b.stock
FROM beers b
INNER JOIN breweries br ON b.brewery_id = br.id
WHERE br.country = 'Ireland';

-- Query 6: Find the beer with the highest average rating
SELECT b.name, AVG(br.rating) AS avg_rating
FROM beers b
INNER JOIN beer_ratings br ON b.id = br.beer_id
GROUP BY b.name
ORDER BY avg_rating DESC
LIMIT 1;

-- Query 7: List breweries that produce beers with stock greater than 150
SELECT DISTINCT br.name
FROM breweries br
INNER JOIN beers b ON br.id = b.brewery_id
WHERE b.stock > 150;

-- Query 8: For each beer type, show the count and average stock
SELECT type, COUNT(*) AS beer_count, AVG(stock) AS avg_stock
FROM beers
GROUP BY type
HAVING COUNT(*) >= 1
ORDER BY avg_stock DESC;
