import { describe, test, expect, beforeEach, afterEach } from 'bun:test';
import { TestHelper, getSqlFilePath } from './test-helper';

describe('DDL Task 1: Basic table creation', () => {
  let helper: TestHelper;

  beforeEach(() => {
    helper = new TestHelper();
  });

  afterEach(() => {
    helper.cleanup();
  });

  test('should create students table with correct schema', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 1));

    expect(helper.tableExists('students')).toBe(true);

    const info = helper.getTableInfo('students');
    const columnNames = info.map((col: any) => col.name);

    expect(columnNames).toContain('id');
    expect(columnNames).toContain('first_name');
    expect(columnNames).toContain('last_name');
    expect(columnNames).toContain('email');
    expect(columnNames).toContain('birth_date');
    expect(columnNames).toContain('created_at');
  });

  test('should enforce NOT NULL constraints', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 1));

    expect(helper.tableExists('students')).toBe(true);

    expect(() => {
      helper.getDb().run('INSERT INTO students (id) VALUES (1)');
    }).toThrow();
  });

  test('should enforce UNIQUE constraint on email', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 1));

    helper.getDb().run(
      "INSERT INTO students (id, first_name, last_name, email) VALUES (1, 'John', 'Doe', 'john@test.com')"
    );

    expect(() => {
      helper.getDb().run(
        "INSERT INTO students (id, first_name, last_name, email) VALUES (2, 'Jane', 'Doe', 'john@test.com')"
      );
    }).toThrow();
  });
});

describe('DDL Task 2: Check constraints', () => {
  let helper: TestHelper;

  beforeEach(() => {
    helper = new TestHelper();
  });

  afterEach(() => {
    helper.cleanup();
  });

  test('should create products table', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 2));

    expect(helper.tableExists('products')).toBe(true);
  });

  test('should enforce price > 0 constraint', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 2));

    expect(helper.tableExists('products')).toBe(true);

    expect(() => {
      helper.getDb().run(
        "INSERT INTO products (name, price, quantity) VALUES ('Test', -5.00, 10)"
      );
    }).toThrow();
  });

  test('should enforce quantity >= 0 constraint', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 2));

    expect(helper.tableExists('products')).toBe(true);

    expect(() => {
      helper.getDb().run(
        "INSERT INTO products (name, price, quantity) VALUES ('Test', 10.00, -1)"
      );
    }).toThrow();
  });
});

describe('DDL Task 3: Foreign key relationships', () => {
  let helper: TestHelper;

  beforeEach(() => {
    helper = new TestHelper();
    helper.getDb().run('PRAGMA foreign_keys = ON');
  });

  afterEach(() => {
    helper.cleanup();
  });

  test('should create departments and employees tables', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 3));

    expect(helper.tableExists('departments')).toBe(true);
    expect(helper.tableExists('employees')).toBe(true);
  });

  test('should enforce foreign key constraint', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 3));

    expect(helper.tableExists('departments')).toBe(true);
    expect(helper.tableExists('employees')).toBe(true);

    expect(() => {
      helper.getDb().run(
        "INSERT INTO employees (name, department_id, salary, hire_date) VALUES ('John Doe', 999, 50000, '2024-01-01')"
      );
    }).toThrow();
  });

  test('should allow valid foreign key reference', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 3));

    helper.getDb().run(
      "INSERT INTO departments (name, location) VALUES ('Engineering', 'Building A')"
    );

    helper.getDb().run(
      "INSERT INTO employees (name, department_id, salary, hire_date) VALUES ('John Doe', 1, 50000, '2024-01-01')"
    );

    const employees = helper.query('SELECT * FROM employees');
    expect(employees.length).toBe(1);
  });
});

describe('DDL Task 4: Complex schema', () => {
  let helper: TestHelper;

  beforeEach(() => {
    helper = new TestHelper();
    helper.getDb().run('PRAGMA foreign_keys = ON');
  });

  afterEach(() => {
    helper.cleanup();
  });

  test('should create all library tables', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 4));

    expect(helper.tableExists('authors')).toBe(true);
    expect(helper.tableExists('books')).toBe(true);
    expect(helper.tableExists('borrowers')).toBe(true);
    expect(helper.tableExists('loans')).toBe(true);
  });

  test('should enforce published_year constraint', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 4));

    helper.getDb().run(
      "INSERT INTO authors (name, country) VALUES ('Test Author', 'USA')"
    );

    expect(() => {
      helper.getDb().run(
        "INSERT INTO books (title, author_id, isbn, published_year, available_copies) VALUES ('Test Book', 1, '1234567890123', 999, 1)"
      );
    }).toThrow();
  });

  test('should enforce unique ISBN', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 4));

    helper.getDb().run(
      "INSERT INTO authors (name, country) VALUES ('Test Author', 'USA')"
    );

    helper.getDb().run(
      "INSERT INTO books (title, author_id, isbn, published_year) VALUES ('Book 1', 1, '1234567890123', 2020)"
    );

    expect(() => {
      helper.getDb().run(
        "INSERT INTO books (title, author_id, isbn, published_year) VALUES ('Book 2', 1, '1234567890123', 2021)"
      );
    }).toThrow();
  });
});
