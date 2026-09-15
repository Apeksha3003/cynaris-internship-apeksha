-- Week 1 - Day 3: SQL Aggregations

CREATE DATABASE cynaris_aggregations;

USE cynaris_aggregations;


-- =========================================
-- 1. Create Sales Table
-- =========================================

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    region VARCHAR(50),
    category VARCHAR(50),
    product VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2)
);


-- =========================================
-- 2. Insert Sample Sales Data
-- =========================================

INSERT INTO sales
(sale_id, sale_date, region, category, product, quantity, price)
VALUES
(1, '2026-01-05', 'North', 'Electronics', 'Laptop', 2, 55000.00),
(2, '2026-01-10', 'South', 'Furniture', 'Chair', 5, 4500.00),
(3, '2026-01-15', 'East', 'Electronics', 'Mouse', 10, 800.00),
(4, '2026-02-03', 'North', 'Furniture', 'Desk', 3, 7000.00),
(5, '2026-02-12', 'South', 'Electronics', 'Monitor', 4, 12000.00),
(6, '2026-02-20', 'East', 'Stationery', 'Notebook', 20, 120.00),
(7, '2026-03-02', 'North', 'Electronics', 'Keyboard', 6, 1500.00),
(8, '2026-03-11', 'South', 'Furniture', 'Table', 2, 9000.00),
(9, '2026-03-18', 'East', 'Stationery', 'Pen', 50, 20.00),
(10, '2026-03-25', 'North', 'Electronics', 'Headphones', 8, 2500.00),
(11, '2026-04-05', 'South', 'Electronics', 'Laptop', 1, 55000.00),
(12, '2026-04-15', 'East', 'Furniture', 'Chair', 4, 4500.00);


-- =========================================
-- 3. Aggregate Queries
-- =========================================

-- 3.1 COUNT
SELECT COUNT(*) AS total_sales
FROM sales;

-- 3.2 SUM
SELECT SUM(quantity * price) AS total_sales_amount
FROM sales;

-- 3.3 AVG
SELECT AVG(price) AS average_price
FROM sales;

-- 3.4 MAX
SELECT MAX(price) AS highest_price
FROM sales;

-- 3.5 MIN
SELECT MIN(price) AS lowest_price
FROM sales;

-- 3.6 COUNT with WHERE
SELECT COUNT(*) AS electronics_sales
FROM sales
WHERE category = 'Electronics';

-- 3.7 SUM of quantity
SELECT SUM(quantity) AS total_quantity_sold
FROM sales;

-- 3.8 Multiple aggregate functions
SELECT
    COUNT(*) AS total_sales,
    SUM(quantity * price) AS total_revenue,
    AVG(quantity * price) AS average_sale_value,
    MAX(quantity * price) AS highest_sale_value,
    MIN(quantity * price) AS lowest_sale_value
FROM sales;


-- =========================================
-- 4. GROUP BY Region
-- =========================================

SELECT
    region,
    COUNT(*) AS total_sales,
    SUM(quantity * price) AS total_revenue,
    AVG(quantity * price) AS average_sale_value
FROM sales
GROUP BY region;


-- =========================================
-- 5. GROUP BY Category
-- =========================================

SELECT
    category,
    COUNT(*) AS total_sales,
    SUM(quantity * price) AS total_revenue,
    AVG(quantity * price) AS average_sale_value
FROM sales
GROUP BY category;


-- =========================================
-- 6. GROUP BY Month
-- =========================================

SELECT
    DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
    COUNT(*) AS total_sales,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY sales_month;


-- =========================================
-- 7. HAVING
-- =========================================

SELECT
    region,
    COUNT(*) AS total_sales,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY region
HAVING SUM(quantity * price) > 50000;


-- =========================================
-- 8. HAVING with COUNT
-- =========================================

SELECT
    category,
    COUNT(*) AS total_sales,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY category
HAVING COUNT(*) >= 3;


-- =========================================
-- 9. Window Function: SUM OVER()
-- =========================================

SELECT
    sale_id,
    region,
    category,
    quantity,
    price,
    quantity * price AS sale_amount,
    SUM(quantity * price) OVER () AS total_revenue
FROM sales;