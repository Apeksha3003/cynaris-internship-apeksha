-- Week 1 - Day 4
-- SQL Subqueries & CTEs
-- Cynaris Solutions Internship

CREATE DATABASE cynaris_cte;

USE cynaris_cte;


-- =====================================================
-- TABLE CREATION
-- =====================================================

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    region VARCHAR(50),
    salesperson VARCHAR(100),
    product VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2)
);


-- =====================================================
-- SAMPLE DATA
-- =====================================================

INSERT INTO sales
(sale_id, sale_date, region, salesperson, product, quantity, price)
VALUES
(1, '2026-01-05', 'North', 'Anita', 'Laptop', 2, 55000.00),
(2, '2026-01-10', 'North', 'Rahul', 'Mouse', 10, 800.00),
(3, '2026-01-15', 'South', 'Priya', 'Monitor', 4, 12000.00),
(4, '2026-02-03', 'South', 'Kiran', 'Laptop', 1, 55000.00),
(5, '2026-02-12', 'East', 'Sneha', 'Keyboard', 6, 1500.00),
(6, '2026-02-20', 'East', 'Arjun', 'Monitor', 3, 12000.00),
(7, '2026-03-02', 'North', 'Anita', 'Headphones', 8, 2500.00),
(8, '2026-03-11', 'South', 'Priya', 'Laptop', 2, 55000.00),
(9, '2026-03-18', 'East', 'Sneha', 'Mouse', 15, 800.00),
(10, '2026-03-25', 'North', 'Rahul', 'Keyboard', 5, 1500.00),
(11, '2026-04-05', 'South', 'Kiran', 'Monitor', 5, 12000.00),
(12, '2026-04-15', 'East', 'Arjun', 'Laptop', 1, 55000.00);


-- =====================================================
-- TASK 1
-- Non-correlated subquery:
-- Find sales above the average sale amount
-- =====================================================

SELECT
    sale_id,
    salesperson,
    region,
    product,
    quantity,
    price,
    quantity * price AS sale_amount
FROM sales
WHERE quantity * price > (
    SELECT AVG(quantity * price)
    FROM sales
);


-- =====================================================
-- TASK 2
-- Correlated subquery:
-- Find the top performer per region
-- =====================================================

SELECT
    s1.region,
    s1.salesperson,
    SUM(s1.quantity * s1.price) AS total_sales
FROM sales AS s1
GROUP BY s1.region, s1.salesperson
HAVING SUM(s1.quantity * s1.price) = (
    SELECT MAX(person_total)
    FROM (
        SELECT
            s2.salesperson,
            SUM(s2.quantity * s2.price) AS person_total
        FROM sales AS s2
        WHERE s2.region = s1.region
        GROUP BY s2.salesperson
    ) AS regional_totals
);


-- =====================================================
-- TASK 3
-- Rewrite nested subquery as a CTE
-- =====================================================

WITH average_sales AS (
    SELECT AVG(quantity * price) AS avg_sale_amount
    FROM sales
)
SELECT
    s.sale_id,
    s.salesperson,
    s.region,
    s.product,
    s.quantity,
    s.price,
    s.quantity * s.price AS sale_amount
FROM sales AS s
CROSS JOIN average_sales AS a
WHERE s.quantity * s.price > a.avg_sale_amount;


-- =====================================================
-- TASK 4
-- Chain 2 CTEs in a single query
-- =====================================================

WITH sales_by_person AS (
    SELECT
        region,
        salesperson,
        SUM(quantity * price) AS total_sales
    FROM sales
    GROUP BY region, salesperson
),
regional_average AS (
    SELECT
        region,
        AVG(total_sales) AS avg_sales
    FROM sales_by_person
    GROUP BY region
)
SELECT
    s.region,
    s.salesperson,
    s.total_sales,
    r.avg_sales
FROM sales_by_person AS s
JOIN regional_average AS r
    ON s.region = r.region
WHERE s.total_sales > r.avg_sales
ORDER BY s.region, s.total_sales DESC;