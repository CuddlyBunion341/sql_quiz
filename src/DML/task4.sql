-- Task 4: Advanced queries with subqueries, UNION, complex conditions
-- This file demonstrates complex SQL patterns

-- Setup: Create and populate a beer/brewery database
-- Three tables: breweries, beers, beer_ratings
--
-- breweries: id, name, country
-- Data as in original file
--
-- beers: id, name, brewery_id (FK), type, stock
-- Data as in original file
--
-- beer_ratings: id, beer_id (FK), visitor_name, rating (CHECK 1-10)
-- Data as in original file

-- TODO: Create breweries table

-- TODO: Create beers table with foreign key

-- TODO: Create beer_ratings table with foreign key and check constraint

-- TODO: Insert brewery data

-- TODO: Insert beer data

-- TODO: Insert rating data

-- Query 1: What is the average stock level for all beers? (Named as 'average_stock')
-- TODO: Write a query using AVG to calculate average stock, name the column 'average_stock'

-- Query 2: Which beers have been rated with the same rating by all reviewers?
-- (Hint: minimum rating = maximum rating for that beer)
-- TODO: Write a query using GROUP BY and HAVING where MIN(rating) = MAX(rating)

-- Query 3: List breweries with the number of beer types they produce
-- and the total stock across all their beers
-- TODO: Write a query using LEFT JOIN, COUNT(DISTINCT), and SUM grouped by brewery

-- Query 4: Find beers that have stock above the average stock level (subquery)
-- TODO: Write a query with a subquery to find beers above average stock

-- Query 5: Show all Swiss beers and Irish beers using UNION
-- TODO: Write two queries combined with UNION for Swiss and Irish beers

-- Query 6: Find the beer with the highest average rating
-- TODO: Write a query to find the beer with highest average rating using GROUP BY, ORDER BY, LIMIT

-- Query 7: List breweries that produce beers with stock greater than 150
-- TODO: Write a query using DISTINCT and JOIN to find breweries with high-stock beers

-- Query 8: For each beer type, show the count and average stock
-- TODO: Write a query using GROUP BY, COUNT, AVG, HAVING, and ORDER BY
