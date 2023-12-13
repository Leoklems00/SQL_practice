-- Active: 1675484766118@@127.0.0.1@3306@classicmodels
SELECT DISTINCT p.productName, 
    SUM(o.quantityOrdered) 
        OVER month_window AS tot_qtty_over_time,
    AVG(o.quantityOrdered) 
        OVER month_window AS avg_qtty_over_time,
    COUNT(o.quantityOrdered) 
        OVER month_window AS count_qtty_over_time
FROM orderDetails o
JOIN orders od
    ON od.orderNumber = o.orderNumber
    AND od.orderDate > '2005-04-30'
JOIN products p
    ON o.productCode = p.productCode
WINDOW month_window AS (PARTITION BY o.productCode
        ORDER BY od.orderDate);

-- SELF JOIN

SELECT o1.orderNumber order_1, o2.orderNumber order_2
FROM orders o1
JOIN orders o2
ON o1.customerNumber = o2.customerNumber
AND o2.orderDate > o1.orderDate
AND o1.status IS NOT NULL;


CREATE VIEW orders_2
AS (SELECT * FROM orders);

SELECT *
FROM orders
-- (SELECT * FROM orders LIMIT 10) sub

UNION

SELECT *
FROM orders_2;

-- UNION is a set operator that combines the  results
--  of two or more sets (select statements) into one 
--  removing duplicates while UNION ALL returns ALLrecords 
--  even with duplicates

-- the columns in the individual queries must be same even if 
-- the tables are different

SELECT *
    FROM orders
    -- WHERE status IS NOT NULL

    UNION ALL

    SELECT *
    FROM orders_2;

SELECT `requiredDate`, COUNT(status), status
FROM (
    SELECT *
    FROM orders
    WHERE status IS NOT NULL

    UNION ALL

    SELECT *
    FROM orders_2) sub
GROUP BY 3,1
ORDER BY 2;

WITH sub AS (SELECT *
    FROM orders
    WHERE status IS NOT NULL


    UNION ALL

    SELECT *
    FROM orders_2)
SELECT `requiredDate`, COUNT(status), status
    FROM sub
    GROUP BY 3,1
    ORDER BY 2;

EXPLAIN
SELECT customerNumber
FROM (SELECT * FROM orders LIMIT 20) sub;

-- LIMITING via subqueries to impeove speed

SELECT customerNumber
FROM orders 
LIMIT 20;

-- Reducing size of table by agregating before join will improve speed

SELECT p.productName, o.orderNumber
    FROM (
        SELECT orderNumber, productCode, COUNT(productCode) AS pro
        FROM orderdetails
        GROUP BY 1,2
        LIMIT 10) o
    JOIN products p
    ON o.productCode = p.productCode;