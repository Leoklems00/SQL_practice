-- select *
-- FROM customers;
-- WHERE addressLine2 LIKE 'Suite%'
-- ORDER BY salesRepEmployeeNumber;

-- SELECT *, (amount/ 2 )AS half_amt
-- FROM payments
-- WHERE paymentDate LIKE '2003%' AND customerNumber NOT IN ('103', '128', 141);

-- SELECT *
-- FROM payments
-- WHERE paymentDate BETWEEN '2003-11-25' AND '2004-05-13'
-- ORDER BY paymentDate DESC;

-- JOINS

-- SELECT customers.customerName, 
-- payments.customerNumber, payments.amount,
-- orders.status
-- FROM customers
-- JOIN payments
-- ON payments.customerNumber = customers.customerNumber
-- JOIN orders
-- ON customers.customerNumber = orders.customerNumber;

-- USING ALIAS

-- SELECT c.customerName, 
-- p.customerNumber, p.amount,
-- o.status
-- FROM customers c
-- JOIN payments p
-- ON p.customerNumber = c.customerNumber
-- JOIN orders o
-- ON c.customerNumber = o.customerNumber
-- WHERE p.amount >= '5000';

-- SELECT c.customerName, 
-- p.customerNumber, p.amount,
-- o.status
-- FROM customers c
-- LEFT JOIN payments p
-- ON p.customerNumber = c.customerNumber
-- JOIN orders o
-- ON c.customerNumber = o.customerNumber
-- WHERE p.amount >= '5000';

-- SELECT DISTINCT c.customerName, 
-- p.customerNumber, p.amount,
-- o.status
-- FROM customers c
-- LEFT JOIN payments p
-- ON p.customerNumber = c.customerNumber
-- JOIN orders o
-- ON c.customerNumber = o.customerNumber
-- AND p.amount >= '5000';

-- SELECT *
-- FROM orders
-- -- WHERE comments IS NULL;
-- WHERE comments IS NOT NULL;

-- COUNT counts the number of non NULL rows in a column

-- SELECT COUNT(status) AS status_count
-- FROM orders
-- -- WHERE comments IS NULL;
-- WHERE comments IS NOT NULL;


-- SELECT MIN(quantityInStock) AS min_qty_stk,
--     MAX(quantityInStock) AS max_qty_stk,
--     MIN(buyPrice) AS min_price,
--     MAX(buyPrice) AS max_price
-- FROM products;

-- AVG calculates average ignoring null rows 
-- completely both in numerator and denominator

-- Find median in sql IS AN INTERVIEW QUESTION 

-- SELECT AVG(quantityInStock) AS avg_qty_stk,
--     AVG(buyPrice) AS avg_price
-- FROM products;

-- GROUP BY any column in the select ststement that
-- is not within an aggrigator must be in the GROUP BY 
-- clause if not it will result in an error

-- GROUP BY always goes between WHETE and ORDER BY

-- SELECT productName,
--     AVG(quantityInStock) AS avg_qty_stk,
--     AVG(buyPrice) AS avg_price
-- FROM products
-- GROUP BY productName
-- ORDER BY avg_price;

-- SELECT DISTINCT o.customerNumber, c.customerName,
--     MIN(o.orderDate) AS earliest_order,
--     COUNT(o.customerNumber) AS number_of_orders
-- FROM orders o
-- JOIN customers c
-- ON o.customerNumber = c.customerNumber
-- GROUP BY o.customerNumber, c.customerName
-- ORDER BY earliest_order;

-- HAVING is used in place of WHERE 
-- to filter for agrigate columns

-- SELECT DISTINCT o.customerNumber, c.customerName,
--     MIN(o.orderDate) AS earliest_order,
--     COUNT(o.customerNumber) AS number_of_orders
-- FROM orders o
-- JOIN customers c
-- ON o.customerNumber = c.customerNumber
-- GROUP BY o.customerNumber, c.customerName
-- HAVING COUNT(o.customerNumber) > 3
-- ORDER BY earliest_order;

-- DATE_TRUNC allows you to truncate your date into a 
-- particular part of datetime column eg DATE_TRUNC("day", column_name)

-- DATE_PART()  puls specific portion of the date and 
-- discarding the rest onlike DATE_TRUNC.

-- SELECT DATE_PART('dat', orderDate) as dy_of_the_week,
--     SUM(customerNumber)
--     FROM orders
-- GROUP BY 2;

-- CASE is used together with WHEN, THEN, ELSE and END to
--  check conditionals then assign alias. Multiple when can be

-- SELECT orderNumber,
--     CASE WHEN shippedDate <= requiredDate THEN 'Good'
--     ELSE 'Bad'
--     END AS review,
--     comments
-- FROM orders;


-- SELECT CASE WHEN shippedDate <= requiredDate THEN 'Good'
--     ELSE 'Bad'
--     END AS review,
--     COUNT(*) AS counts,
--     EXTRACT(DAY FROM requiredDate) AS d
-- FROM orders
-- GROUP BY 1, d;

SELECT MONTH(orderDate) AS dy_of_the_week,
    SUM(customerNumber)
    FROM orders
GROUP BY 1;



