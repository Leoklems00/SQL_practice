-- When to use window functions
-- when you want to measure trends or changes over a ROW
-- when you want to rank a column to use the outreach/prioritization.ADD

-- Windows function is acalculation across rows within a table that are somehow
-- related to the current row. Similar to aggregate functions but retain 
-- the total number of ROWS

-- windows function seats within the select clause.

-- the sum of quantities over time for the top 10 most ordered prodcts recently

WITH tb1 AS (SELECT od.orderDate oda, o.productCode prod, 
    od.orderNumber od_num
    FROM orders od
    JOIN orderdetails o
    ON od.orderNumber = o.orderNumber
    WHERE YEAR(orderDate) = (SELECT MAX(YEAR(orderDate))
        FROM orders) 
        AND 
        MONTH(orderDate) >= (SELECT MAX(MONTH(orderDate))
            FROM orders
            WHERE YEAR(orderDate) = (SELECT MAX(YEAR(orderDate))
                FROM orders)))
SELECT p.productName, tb1.prod, o.quantityOrdered,
    SUM(o.quantityOrdered) OVER(PARTITION BY o.productCode
        ORDER BY od.orderDate) qtty_over_time, tb1.oda
    FROM tb1
    JOIN orderdetails o
    ON tb1.prod = o.productCode
    JOIN products p
    ON tb1.prod = p.productCode
    JOIN orders od
    ON tb1.od_num = od.orderNumber
GROUP BY 2,3,1, tb1.oda, od.orderDate
ORDER BY 4 DESC;


SELECT od.orderDate
FROM orders od
JOIN orderdetails o
ON od.orderNumber = o.orderNumber
WHERE YEAR(orderDate) = (SELECT MAX(YEAR(orderDate))
FROM orders) AND 
MONTH(orderDate) >= (SELECT MAX(MONTH(orderDate))
    FROM orders
    WHERE YEAR(orderDate) = (SELECT MAX(YEAR(orderDate))
    FROM orders));

-- CTE Common Table EXpressions are queries that start with "WITH"
-- Onlike normal subqueries they simplify execution and are more readable
WITH tb1 AS (SELECT od.orderDate oda, o.productCode prod, od.orderNumber od_num
    FROM orders od
    JOIN orderdetails o
    ON od.orderNumber = o.orderNumber
    WHERE YEAR(orderDate) = (SELECT MAX(YEAR(orderDate))
        FROM orders) 
        AND 
        MONTH(orderDate) >= (SELECT MAX(MONTH(orderDate))
            FROM orders
            WHERE YEAR(orderDate) = (SELECT MAX(YEAR(orderDate))
                FROM orders)))
SELECT DISTINCT *
FROM tb1;

-- Correct for top 20 products by order quantity 
-- for most recent month------

WITH tb1 AS (SELECT od.orderDate oda, o.productCode prod, 
        od.orderNumber od_num
    FROM orders od
    JOIN orderdetails o
    ON od.orderNumber = o.orderNumber
    WHERE YEAR(orderDate) = (SELECT MAX(YEAR(orderDate))
        FROM orders) 
        AND 
        MONTH(orderDate) >= (SELECT MAX(MONTH(orderDate))
            FROM orders
            WHERE YEAR(orderDate) = (SELECT MAX(YEAR(orderDate))
                FROM orders)))
SELECT DISTINCT p.productName, SUM(o.quantityOrdered) qtty_sum, t.oda
    FROM tb1 t
    JOIN orderDetails o
        ON t.od_num = o.orderNumber
    JOIN products p
        ON t.prod = p.productCode
GROUP BY 1,3 
ORDER BY 2 DESC
LIMIT 20;

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


SELECT DISTINCT p.paymentDate,
    LAG(p.amount) 
        OVER month_window AS previous_payment, p.amount,
    LEAD(p.amount) 
        OVER month_window AS next_payment,
    p.paymentDate - LAG(p.paymentDate) 
        OVER month_window  AS days_sice_last_payment
FROM payments p
WINDOW month_window AS (ORDER BY p.paymentDate);

SELECT DISTINCT p.productName, 
    SUM(o.quantityOrdered) 
        OVER month_window AS tot_qtty_over_time,
    AVG(o.quantityOrdered) 
        OVER month_window AS avg_qtty_over_time,
    NTILE(100) 
        OVER (ORDER BY o.quantityOrdered) AS parcentile,
    RANK() 
        OVER (ORDER BY o.quantityOrdered) AS position,
    ROW_NUMBER() 
        OVER (ORDER BY o.quantityOrdered) AS position1,
    DENSE_RANK() 
        OVER (ORDER BY o.quantityOrdered) AS position2
FROM orderDetails o
JOIN orders od
    ON od.orderNumber = o.orderNumber
JOIN products p
    ON o.productCode = p.productCode
WINDOW month_window AS (PARTITION BY o.productCode
        ORDER BY od.orderDate);

-- ROW_NUMBER is distinct among records even with TIES
-- RANK is thesame among tied values and rank skips the subsequent VALUES
-- DENSE_RANK rank is thesame amongst tied values and rank does not skip 
-- the subsequent value