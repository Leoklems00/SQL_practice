-- SUBQUERIES are used when an aggrigate of one table is needed 
-- as part of the query of another table 

SELECT 
    AVG(num_of_orders) AS avg_order, day
    FROM (SELECT customerNumber, DAYOFWEEK(orderDate) AS day,
        COUNT(customerNumber) num_of_orders
    FROM orders
    GROUP BY 1,2) sub
GROUP BY 2
ORDER BY day;

SELECT customerNumber, DAYOFWEEK(orderDate) AS day,
        COUNT(customerNumber) num_of_orders
    FROM orders
    GROUP BY 1,2;
-- IN is used when conditional querry contains multiple results
-- nested(conditional) and scaler(in SELECT) queries do not require aliases

-- The top ten products based on quantity ordered in all the months 
-- equal to the month of the first order?

-- The WITH subquerry approacch liverages a scoped psudo-created table 
-- to interact with an actual table. You can psudo-create more than one 
-- table with the in one WITH claus

-- CTE = Common Table Expressions

SELECT p.productName, od.quantityOrdered
    FROM products p
    JOIN orderdetails od
    ON p.productCode = od.productCode
    JOIN orders o
    ON od.orderNumber = o.orderNumber
    WHERE MONTH(o.orderDate) = (SELECT MONTH(MIN(o.orderDate))
    FROM orders)
    GROUP BY 1,2
    ORDER BY 2 DESC
    LIMIT 10;


SELECT * 
    FROM orderdetails
    WHERE `priceEach` in (SELECT MAX(priceEach)
    FROM orderdetails
    GROUP BY productCode
    ORDER BY 1 DESC) ;


-- To count the number of columns
SELECT COUNT(*)
FROM information_schema.columns
WHERE TABLE_NAME = 'orderdetails';

SELECT *
FROM products
WHERE productCode = 'S10_1678';