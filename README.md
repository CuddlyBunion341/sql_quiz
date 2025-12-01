# SQL Quiz

A comprehensive collection of SQL practice tasks covering both DDL (Data Definition Language) and DML (Data Manipulation Language) with automated tests.

## Overview

This project provides progressive SQL exercises organized into DDL and DML tasks, each increasing in complexity. Tests verify that all SQL scripts work correctly using Bun's native SQLite implementation.

## Project Structure

```
sql_quiz/
├── src/
│   ├── DDL/                 # Data Definition Language tasks
│   │   ├── task1.sql       # Basic table creation
│   │   ├── task2.sql       # Check constraints
│   │   ├── task3.sql       # Foreign key relationships
│   │   └── task4.sql       # Complex schema with multiple tables
│   └── DML/                # Data Manipulation Language tasks
│       ├── task1.sql       # Basic SELECT, WHERE, LIKE, ORDER BY
│       ├── task2.sql       # Aggregate functions and GROUP BY
│       ├── task3.sql       # JOINs (INNER, LEFT, CROSS)
│       └── task4.sql       # Advanced queries with subqueries and UNION
├── spec/                   # Test files
│   ├── test-helper.ts     # Test utilities
│   ├── ddl.test.ts        # DDL tests
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

Run all tests:

```bash
bun test
```

Run specific test file:

```bash
bun test spec/ddl.test.ts
bun test spec/dml.test.ts
```

## Test Coverage

The test suite includes 31 tests covering:
- Table creation and schema validation
- Constraint enforcement (NOT NULL, UNIQUE, CHECK, FOREIGN KEY)
- Data insertion and validation
- Query result verification
- Aggregate function accuracy
- JOIN operations
- Subquery functionality

All tests use an in-memory SQLite database for fast, isolated testing.

## Learning Path

1. Start with **DDL Task 1** to learn basic table creation
2. Progress through DDL tasks 2-4 to master constraints and relationships
3. Move to **DML Task 1** for basic query operations
4. Advance through DML tasks 2-4 for complex queries

Each task builds on concepts from previous tasks, creating a progressive learning experience.

## Technologies

- **Bun**: Fast JavaScript runtime with native SQLite support
- **TypeScript**: Type-safe test implementation
- **SQLite**: Lightweight, file-based SQL database

## Requirements

- Bun 1.0.0 or higher

## License

This project is for educational purposes.
