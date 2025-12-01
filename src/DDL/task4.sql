-- Task 4: Complex schema with multiple constraints and relationships
-- Create a library management system with books, authors, and borrowers
--
-- authors table:
-- - id: integer, primary key, auto-increment
-- - name: variable character string (max 100), not null
-- - country: variable character string (max 50)
--
-- books table:
-- - id: integer, primary key, auto-increment
-- - title: variable character string (max 200), not null
-- - author_id: integer, foreign key references authors(id) ON DELETE CASCADE
-- - isbn: variable character string (max 13), unique, not null
-- - published_year: integer, check year between 1000 and 2100
-- - available_copies: integer, default 1, check >= 0
--
-- borrowers table:
-- - id: integer, primary key, auto-increment
-- - name: variable character string (max 100), not null
-- - email: variable character string (max 100), unique, not null
-- - member_since: date, default current date
--
-- loans table:
-- - id: integer, primary key, auto-increment
-- - book_id: integer, foreign key references books(id)
-- - borrower_id: integer, foreign key references borrowers(id)
-- - loan_date: date, not null, default current date
-- - return_date: date
-- - check constraint: return_date must be null or >= loan_date

CREATE TABLE authors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50)
);

CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(200) NOT NULL,
    author_id INTEGER,
    isbn VARCHAR(13) UNIQUE NOT NULL,
    published_year INTEGER CHECK (published_year BETWEEN 1000 AND 2100),
    available_copies INTEGER DEFAULT 1 CHECK (available_copies >= 0),
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE
);

CREATE TABLE borrowers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    member_since DATE DEFAULT CURRENT_DATE
);

CREATE TABLE loans (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER,
    borrower_id INTEGER,
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    return_date DATE,
    CHECK (return_date IS NULL OR return_date >= loan_date),
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (borrower_id) REFERENCES borrowers(id)
);
