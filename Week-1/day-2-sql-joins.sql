-- Week 1 - Day 2: SQL Joins

CREATE DATABASE cynaris_joins;

USE cynaris_joins;


-- =========================================
-- 1. Create Customers Table
-- =========================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);


-- =========================================
-- 2. Create Orders Table
-- =========================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(100),
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- =========================================
-- 3. Insert Customer Data
-- =========================================

INSERT INTO customers (customer_id, customer_name, city)
VALUES
(1, 'Asha', 'Bangalore'),
(2, 'Rahul', 'Mysore'),
(3, 'Sneha', 'Chennai'),
(4, 'Arjun', 'Mangalore'),
(5, 'Priya', 'Bangalore');


-- =========================================
-- 4. Insert Order Data
-- =========================================

INSERT INTO orders (order_id, customer_id, product, amount)
VALUES
(101, 1, 'Laptop', 55000.00),
(102, 1, 'Mouse', 800.00),
(103, 2, 'Keyboard', 1500.00),
(104, 3, 'Monitor', 12000.00),
(105, 2, 'Headphones', 2500.00);


-- =========================================
-- 5. INNER JOIN
-- =========================================

SELECT
    c.customer_name,
    c.city,
    o.product,
    o.amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;


-- =========================================
-- 6. LEFT JOIN
-- =========================================

SELECT
    c.customer_name,
    c.city,
    o.product,
    o.amount
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;


-- =========================================
-- 7. RIGHT JOIN
-- =========================================

SELECT
    c.customer_name,
    c.city,
    o.product,
    o.amount
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customer_id = o.customer_id;


-- =========================================
-- 8. FULL OUTER JOIN Equivalent in MySQL
-- =========================================

SELECT
    c.customer_name,
    c.city,
    o.product,
    o.amount
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id

UNION

SELECT
    c.customer_name,
    c.city,
    o.product,
    o.amount
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customer_id = o.customer_id;


-- =========================================
-- 9. Duplicate Rows Caused by JOIN
-- =========================================

SELECT
    c.customer_name,
    o.product,
    o.amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;


-- =========================================
-- 10. Fix Duplicate Customer Rows Using DISTINCT
-- =========================================

SELECT DISTINCT
    c.customer_id,
    c.customer_name,
    c.city
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;


-- =========================================
-- 11. Fix Using Aggregation
-- =========================================

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;


-- =========================================
-- 12. Create Employees Table for Self JOIN
-- =========================================

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT,
    department VARCHAR(50)
);


-- =========================================
-- 13. Insert Employee Data
-- =========================================

INSERT INTO employees (employee_id, employee_name, manager_id, department)
VALUES
(1, 'Anita', NULL, 'Management'),
(2, 'Rahul', 1, 'Sales'),
(3, 'Priya', 1, 'Sales'),
(4, 'Arjun', 2, 'Sales'),
(5, 'Sneha', 2, 'Sales');


-- =========================================
-- 14. SELF JOIN
-- =========================================

SELECT
    e.employee_name AS employee,
    m.employee_name AS manager,
    e.department
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;