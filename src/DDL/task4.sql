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

-- TODO: Implement the authors table

-- TODO: Implement the books table with foreign key to authors

-- TODO: Implement the borrowers table

-- TODO: Implement the loans table with foreign keys and check constraint
