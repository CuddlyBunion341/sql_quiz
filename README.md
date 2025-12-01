# SQL Quiz

A comprehensive collection of SQL practice tasks covering both DDL (Data Definition Language) and DML (Data Manipulation Language) with automated tests.

## Overview

This project provides progressive SQL exercises organized into DDL and DML tasks, each increasing in complexity. Tests verify that all SQL scripts work correctly using Bun's native SQLite implementation.

## Quick Start

1. Install dependencies:
   ```bash
   bun install
   ```

2. Check your progress (simple output):
   ```bash
   bun test:summary
   ```

3. Start with DDL Task 1 (`src/DDL/task1.sql`), implement the solution, then check:
   ```bash
   bun test:ddl
   ```

4. Continue through all tasks, checking progress as you go!

## Project Structure

```
sql_quiz/
├── src/
│   ├── DDL/                 # Data Definition Language tasks
│   │   ├── task1.sql       # Basic table creation
│   │   ├── task2.sql       # Check constraints
│   │   ├── task3.sql       # Foreign key relationships
│   │   ├── task4.sql       # Complex schema with multiple tables
│   │   └── task5.sql       # Database cleanup (DROP statements)
│   └── DML/                # Data Manipulation Language tasks
│       ├── task1.sql       # Basic SELECT, WHERE, LIKE, ORDER BY
│       ├── task2.sql       # Aggregate functions and GROUP BY
│       ├── task3.sql       # JOINs (INNER, LEFT, CROSS)
│       └── task4.sql       # Advanced queries with subqueries and UNION
├── spec/                   # Test files
│   ├── test-helper.ts     # Test utilities
│   ├── ddl.test.ts        # DDL tests (tasks 1-4)
│   ├── ddl-cleanup.test.ts # DDL cleanup tests (task 5)
│   └── dml.test.ts        # DML tests
└── README.md
```

## DDL Tasks

### Task 1: Basic Table Creation
- Create simple tables with various data types
- Define PRIMARY KEY, NOT NULL, UNIQUE constraints
- Use DEFAULT values and TIMESTAMP

### Task 2: Check Constraints
- Implement CHECK constraints for data validation
- Use AUTOINCREMENT for primary keys
- Create complex CHECK constraints involving multiple columns

### Task 3: Foreign Key Relationships
- Define foreign keys between tables
- Implement ON DELETE actions (SET NULL, CASCADE)
- Create normalized database schemas

### Task 4: Complex Schema
- Build a multi-table system (library management)
- Combine all constraint types
- Design relationships between multiple entities

### Task 5: Database Cleanup
- Learn to DROP tables in correct order
- Handle foreign key dependencies during cleanup
- Use DROP TABLE IF EXISTS for safe cleanup
- Understand the importance of cleanup order

## DML Tasks

### Task 1: Basic Queries
- SELECT statements with WHERE clauses
- Pattern matching with LIKE
- Sorting results with ORDER BY
- Filtering with multiple conditions

### Task 2: Aggregate Functions
- COUNT, AVG, SUM, MIN, MAX
- GROUP BY clause
- HAVING clause for filtered aggregations
- Calculate statistics from data

### Task 3: JOINs
- CROSS JOIN for Cartesian products
- INNER JOIN for matching records
- LEFT JOIN to include all records from left table
- Complex join conditions

### Task 4: Advanced Queries
- Subqueries in WHERE clauses
- UNION to combine result sets
- Finding records above/below averages
- Complex filtering and grouping combinations

## Installation

```bash
bun install
```

## Running Tests

### Quick Summary (Recommended)

Get a concise summary of your progress:

```bash
bun test:summary
# or
bun test 2>&1 | tail -3
```

Output example:
```
 15 pass
 16 fail
Ran 31 tests across 2 files.
```

### Test Specific Tasks

Test only DDL tasks (table creation):
```bash
bun test:ddl
```

Test only DML tasks (queries):
```bash
bun test:dml
```

Test a specific task by name:
```bash
bun test --test-name-pattern "Task 1"
bun test --test-name-pattern "Basic table creation"
```

### See Which Tests Pass/Fail

Show only passing tests:
```bash
bun test:pass
```

Show only failing tests:
```bash
bun test:fail
```

### Full Output

See all test details (verbose):
```bash
bun test
```

## Test Coverage

The test suite includes 35 tests covering:
- Table creation and schema validation
- Constraint enforcement (NOT NULL, UNIQUE, CHECK, FOREIGN KEY)
- Database cleanup with DROP statements
- Foreign key dependency handling during cleanup
- Data insertion and validation
- Query result verification
- Aggregate function accuracy
- JOIN operations
- Subquery functionality

All tests use an in-memory SQLite database for fast, isolated testing.

**Automatic Cleanup:** Tables are automatically dropped after each test using the `cleanup()` method, which:
- Disables foreign key constraints temporarily
- Drops all user tables (excluding SQLite system tables)
- Re-enables foreign key constraints
- Ensures each test starts with a clean database

## Learning Path

1. Start with **DDL Task 1** to learn basic table creation
2. Progress through DDL tasks 2-5 to master constraints, relationships, and cleanup
3. Move to **DML Task 1** for basic query operations
4. Advance through DML tasks 2-4 for complex queries

Each task builds on concepts from previous tasks, creating a progressive learning experience.

**Note:** DDL Task 5 (cleanup) teaches you how to properly drop tables and handle dependencies. This is important for database maintenance and testing!

## Technologies

- **Bun**: Fast JavaScript runtime with native SQLite support
- **TypeScript**: Type-safe test implementation
- **SQLite**: Lightweight, file-based SQL database

## Requirements

- Bun 1.0.0 or higher

## License

This project is for educational purposes.
