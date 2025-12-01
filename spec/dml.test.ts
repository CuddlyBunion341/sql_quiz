import { describe, test, expect, beforeEach } from 'bun:test';
import { TestHelper, getSqlFilePath } from './test-helper';

describe('DML Task 1: Basic SELECT queries', () => {
  let helper: TestHelper;

  beforeEach(() => {
    helper = new TestHelper();
    helper.executeSqlFile(getSqlFilePath('DML', 1));
  });

  test('should have populated books table', () => {
    const books = helper.query('SELECT * FROM books');
    expect(books.length).toBeGreaterThan(0);
  });

  test('should find books published after 1950', () => {
    const books = helper.query('SELECT * FROM books WHERE publication_year > 1950');
    expect(books.length).toBeGreaterThan(0);
    books.forEach((book: any) => {
      expect(book.publication_year).toBeGreaterThan(1950);
    });
  });

  test('should find books with "The" in title', () => {
    const books = helper.query("SELECT title FROM books WHERE title LIKE '%The%' OR title LIKE '%the%'");
    expect(books.length).toBeGreaterThan(0);
  });

  test('should find books by specific author', () => {
    const books = helper.query("SELECT * FROM books WHERE author = 'George Orwell'");
    expect(books.length).toBe(2);
  });
});

describe('DML Task 2: Aggregate functions', () => {
  let helper: TestHelper;

  beforeEach(() => {
    helper = new TestHelper();
    helper.executeSqlFile(getSqlFilePath('DML', 2));
  });

  test('should calculate average soup price', () => {
    const result = helper.queryOne('SELECT AVG(soup_price) AS avg_price FROM restaurants');
    expect(result.avg_price).toBeGreaterThan(0);
  });

  test('should group restaurants by street', () => {
    const results = helper.query('SELECT street, COUNT(*) AS count FROM restaurants GROUP BY street');
    expect(results.length).toBeGreaterThan(0);
  });

  test('should find streets with multiple restaurants using HAVING', () => {
    const results = helper.query(
      'SELECT street, COUNT(*) AS count FROM restaurants GROUP BY street HAVING COUNT(*) >= 2'
    );
    expect(results.length).toBeGreaterThan(0);
    results.forEach((row: any) => {
      expect(row.count).toBeGreaterThanOrEqual(2);
    });
  });

  test('should calculate min and max prices', () => {
    const result = helper.queryOne('SELECT MIN(soup_price) AS min_price, MAX(soup_price) AS max_price FROM restaurants');
    expect(result.min_price).toBeLessThanOrEqual(result.max_price);
  });
});

describe('DML Task 3: JOINs', () => {
  let helper: TestHelper;

  beforeEach(() => {
    helper = new TestHelper();
    // Need to load restaurants from task 2 first
    helper.executeSqlFile(getSqlFilePath('DML', 2));
    helper.executeSqlFile(getSqlFilePath('DML', 3));
  });

  test('should have visitors and guests tables', () => {
    expect(helper.tableExists('visitors')).toBe(true);
    expect(helper.tableExists('guests')).toBe(true);
  });

  test('should perform CROSS JOIN', () => {
    const results = helper.query('SELECT * FROM restaurants CROSS JOIN visitors LIMIT 5');
    expect(results.length).toBe(5);
  });

  test('should find visitors on streets with "bach"', () => {
    const results = helper.query(
      "SELECT name, first_name, street FROM visitors WHERE street LIKE '%bach%' OR street LIKE '%Bach%'"
    );
    expect(results.length).toBeGreaterThan(0);
    results.forEach((row: any) => {
      expect(row.street.toLowerCase()).toContain('bach');
    });
  });

  test('should perform LEFT JOIN to include all visitors', () => {
    const results = helper.query(
      'SELECT v.name, v.first_name, COALESCE(g.frequency, 0) AS frequency FROM visitors v LEFT JOIN guests g ON v.name = g.guest_name AND v.first_name = g.guest_first_name'
    );
    expect(results.length).toBeGreaterThanOrEqual(helper.query('SELECT * FROM visitors').length);
  });

  test('should perform INNER JOIN', () => {
    const results = helper.query(
      'SELECT DISTINCT v.name, v.first_name FROM visitors v INNER JOIN guests g ON v.name = g.guest_name AND v.first_name = g.guest_first_name'
    );
    expect(results.length).toBeGreaterThan(0);
  });
});

describe('DML Task 4: Advanced queries', () => {
  let helper: TestHelper;

  beforeEach(() => {
    helper = new TestHelper();
    helper.executeSqlFile(getSqlFilePath('DML', 4));
  });

  test('should calculate average stock', () => {
    const result = helper.queryOne('SELECT AVG(stock) AS average_stock FROM beers');
    expect(result.average_stock).toBeGreaterThan(0);
  });

  test('should find beers with consistent ratings', () => {
    const results = helper.query(
      'SELECT b.name, MIN(br.rating) AS consistent_rating FROM beers b INNER JOIN beer_ratings br ON b.id = br.beer_id GROUP BY b.name HAVING MIN(br.rating) = MAX(br.rating)'
    );
    expect(results.length).toBeGreaterThan(0);
  });

  test('should group by brewery', () => {
    const results = helper.query(
      'SELECT br.name, COUNT(DISTINCT b.type) AS beer_types, SUM(b.stock) AS total_stock FROM breweries br LEFT JOIN beers b ON br.id = b.brewery_id GROUP BY br.name'
    );
    expect(results.length).toBeGreaterThan(0);
  });

  test('should use subquery to find above-average stock', () => {
    const results = helper.query(
      'SELECT name, stock FROM beers WHERE stock > (SELECT AVG(stock) FROM beers)'
    );
    expect(results.length).toBeGreaterThan(0);
  });

  test('should perform UNION', () => {
    const results = helper.query(
      "SELECT b.name, br.country FROM beers b INNER JOIN breweries br ON b.brewery_id = br.id WHERE br.country = 'Switzerland' UNION SELECT b.name, br.country FROM beers b INNER JOIN breweries br ON b.brewery_id = br.id WHERE br.country = 'Ireland'"
    );
    expect(results.length).toBeGreaterThan(0);
  });

  test('should find highest rated beer', () => {
    const result = helper.queryOne(
      'SELECT b.name, AVG(br.rating) AS avg_rating FROM beers b INNER JOIN beer_ratings br ON b.id = br.beer_id GROUP BY b.name ORDER BY avg_rating DESC LIMIT 1'
    );
    expect(result).toBeDefined();
    expect(result.avg_rating).toBeGreaterThan(0);
  });
});
