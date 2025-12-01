import { describe, test, expect, beforeEach, afterEach } from 'bun:test';
import { TestHelper, getSqlFilePath } from './test-helper';

describe('DDL Task 5: Cleanup operations', () => {
  let helper: TestHelper;

  beforeEach(() => {
    helper = new TestHelper();
  });

  afterEach(() => {
    helper.cleanup();
  });

  test('should create all library tables', () => {
    helper.executeSqlFile(getSqlFilePath('DDL', 5));

    expect(helper.tableExists('authors')).toBe(true);
    expect(helper.tableExists('books')).toBe(true);
    expect(helper.tableExists('borrowers')).toBe(true);
    expect(helper.tableExists('loans')).toBe(true);
  });

  test('should drop tables in correct order', () => {
    // First, manually create the tables to verify DROP works
    helper.getDb().run('PRAGMA foreign_keys = ON');

    helper.getDb().run(`CREATE TABLE authors (id INTEGER PRIMARY KEY)`);
    helper.getDb().run(`CREATE TABLE books (id INTEGER PRIMARY KEY, author_id INTEGER, FOREIGN KEY (author_id) REFERENCES authors(id))`);
    helper.getDb().run(`CREATE TABLE borrowers (id INTEGER PRIMARY KEY)`);
    helper.getDb().run(`CREATE TABLE loans (id INTEGER PRIMARY KEY, book_id INTEGER, borrower_id INTEGER, FOREIGN KEY (book_id) REFERENCES books(id), FOREIGN KEY (borrower_id) REFERENCES borrowers(id))`);

    // Verify tables exist
    expect(helper.tableExists('authors')).toBe(true);
    expect(helper.tableExists('books')).toBe(true);
    expect(helper.tableExists('borrowers')).toBe(true);
    expect(helper.tableExists('loans')).toBe(true);

    // Now execute the cleanup SQL
    // The file should contain DROP statements that remove these tables
    helper.executeSqlFile(getSqlFilePath('DDL', 5));

    // After executing the file, tables should be dropped
    expect(helper.tableExists('loans')).toBe(false);
    expect(helper.tableExists('borrowers')).toBe(false);
    expect(helper.tableExists('books')).toBe(false);
    expect(helper.tableExists('authors')).toBe(false);
  });

  test('should handle IF EXISTS cleanup safely', () => {
    // Manually create some tables first
    helper.getDb().run('CREATE TABLE authors (id INTEGER PRIMARY KEY)');
    helper.getDb().run('CREATE TABLE books (id INTEGER PRIMARY KEY)');

    expect(helper.tableExists('authors')).toBe(true);
    expect(helper.tableExists('books')).toBe(true);

    // Execute the cleanup file - should drop tables using IF EXISTS
    helper.executeSqlFile(getSqlFilePath('DDL', 5));

    // Tables should be dropped
    expect(helper.tableExists('authors')).toBe(false);
    expect(helper.tableExists('books')).toBe(false);

    // Create a fresh helper and run again
    const helper2 = new TestHelper();

    // Second execution: should not throw even though tables don't exist
    // (because of IF EXISTS in Part 3 of the task)
    expect(() => {
      helper2.executeSqlFile(getSqlFilePath('DDL', 5));
    }).not.toThrow();
  });

  test('should respect foreign key constraints during drop', () => {
    // Manually create tables in correct order
    helper.getDb().run(`
      CREATE TABLE authors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100) NOT NULL
      )
    `);

    helper.getDb().run(`
      CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title VARCHAR(200) NOT NULL,
        author_id INTEGER,
        FOREIGN KEY (author_id) REFERENCES authors(id)
      )
    `);

    helper.getDb().run('PRAGMA foreign_keys = ON');

    // Trying to drop authors before books should fail
    expect(() => {
      helper.getDb().run('DROP TABLE authors');
    }).toThrow();

    // But dropping books first should work
    helper.getDb().run('DROP TABLE books');
    helper.getDb().run('DROP TABLE authors');

    expect(helper.tableExists('books')).toBe(false);
    expect(helper.tableExists('authors')).toBe(false);
  });
});
