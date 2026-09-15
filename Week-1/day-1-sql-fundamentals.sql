-- Week 1 - Day 1: SQL Fundamentals

USE cynaris_sales;

-- 1. Select all records
SELECT * FROM sales;

-- 2. Select specific columns
SELECT customer_name, product, price
FROM sales;

-- 3. WHERE
SELECT *
FROM sales
WHERE city = 'Bangalore';

-- 4. WHERE with comparison
SELECT product, price
FROM sales
WHERE price > 5000;

-- 5. WHERE with AND
SELECT *
FROM sales
WHERE city = 'Bangalore'
AND category = 'Electronics';

-- 6. WHERE with OR
SELECT *
FROM sales
WHERE city = 'Bangalore'
OR city = 'Mysore';

-- 7. WHERE with NOT
SELECT *
FROM sales
WHERE NOT category = 'Electronics';

-- 8. LIKE
SELECT *
FROM sales
WHERE customer_name LIKE 'A%';

-- 9. IN
SELECT *
FROM sales
WHERE city IN ('Bangalore', 'Mysore');

-- 10. BETWEEN
SELECT *
FROM sales
WHERE price BETWEEN 1000 AND 10000;

-- IS NULL
SELECT *
FROM sales
WHERE salesperson IS NULL;