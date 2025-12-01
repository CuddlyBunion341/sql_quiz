-- Task 1: Basic SELECT queries with WHERE, ORDER BY, and LIKE
-- This file contains sample data and query tasks

-- Setup: Create and populate a simple books database
CREATE TABLE IF NOT EXISTS books (
    id INTEGER PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    price DECIMAL(10,2),
    publication_year INTEGER,
    stock INTEGER
);

INSERT INTO books (id, title, author, genre, price, publication_year, stock) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 12.99, 1925, 15),
(2, '1984', 'George Orwell', 'Science Fiction', 14.99, 1949, 20),
(3, 'To Kill a Mockingbird', 'Harper Lee', 'Classic', 13.50, 1960, 18),
(4, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 16.99, 1937, 25),
(5, 'Pride and Prejudice', 'Jane Austen', 'Romance', 11.99, 1813, 12),
(6, 'The Catcher in the Rye', 'J.D. Salinger', 'Classic', 13.99, 1951, 10),
(7, 'Harry Potter', 'J.K. Rowling', 'Fantasy', 19.99, 1997, 30),
(8, 'Animal Farm', 'George Orwell', 'Classic', 10.99, 1945, 22);

-- Query 1: Select all books published after 1950
SELECT * FROM books WHERE publication_year > 1950;

-- Query 2: Find all books with 'The' in the title (case-insensitive)
SELECT title, author FROM books WHERE title LIKE '%The%' OR title LIKE '%the%';

-- Query 3: List all books ordered by price (highest first)
SELECT title, price FROM books ORDER BY price DESC;

-- Query 4: Find books by George Orwell
SELECT * FROM books WHERE author = 'George Orwell';

-- Query 5: List Classic genre books with stock less than 15
SELECT title, stock FROM books WHERE genre = 'Classic' AND stock < 15;
