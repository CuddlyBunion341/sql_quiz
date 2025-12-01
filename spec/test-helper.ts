import { Database } from 'bun:sqlite';
import { readFileSync } from 'fs';
import { join } from 'path';

export class TestHelper {
  private db: Database;

  constructor() {
    // Create in-memory database for testing
    this.db = new Database(':memory:');
  }

  /**
   * Execute SQL statements from a file
   */
  executeSqlFile(filePath: string): void {
    const sql = readFileSync(filePath, 'utf-8');

    // Remove comments and split by semicolons more carefully
    const lines = sql.split('\n');
    let currentStatement = '';
    const statements: string[] = [];

    for (const line of lines) {
      const trimmed = line.trim();

      // Skip comment-only lines
      if (trimmed.startsWith('--') || trimmed.length === 0) {
        continue;
      }

      // Remove inline comments
      const cleanedLine = line.split('--')[0];
      currentStatement += cleanedLine + '\n';

      // If line ends with semicolon, it's the end of a statement
      if (cleanedLine.trim().endsWith(';')) {
        statements.push(currentStatement.trim().slice(0, -1)); // Remove trailing semicolon
        currentStatement = '';
      }
    }

    // Add any remaining statement
    if (currentStatement.trim().length > 0) {
      statements.push(currentStatement.trim());
    }

    for (const statement of statements) {
      if (statement.length > 0) {
        try {
          this.db.run(statement);
        } catch (error) {
          console.error(`Error executing statement: ${statement.substring(0, 100)}...`);
          throw error;
        }
      }
    }
  }

  /**
   * Execute a query and return results
   */
  query(sql: string): any[] {
    return this.db.query(sql).all();
  }

  /**
   * Execute a query and return a single row
   */
  queryOne(sql: string): any {
    return this.db.query(sql).get();
  }

  /**
   * Check if a table exists
   */
  tableExists(tableName: string): boolean {
    const result = this.db.query(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?"
    ).get(tableName);
    return result !== undefined;
  }

  /**
   * Get table schema information
   */
  getTableInfo(tableName: string): any[] {
    return this.db.query(`PRAGMA table_info(${tableName})`).all();
  }

  /**
   * Get foreign keys for a table
   */
  getForeignKeys(tableName: string): any[] {
    return this.db.query(`PRAGMA foreign_key_list(${tableName})`).all();
  }

  /**
   * Close database connection
   */
  close(): void {
    this.db.close();
  }

  /**
   * Get the database instance (for advanced usage)
   */
  getDb(): Database {
    return this.db;
  }
}

export function getSqlFilePath(type: 'DDL' | 'DML', taskNumber: number): string {
  return join(process.cwd(), 'src', type, `task${taskNumber}.sql`);
}
