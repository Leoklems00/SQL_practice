SELECT *
from customers
LIMIT 20;


-- the most sold product
WITH top AS (SELECT productCode, COUNT('prouctCode') as top
from orderdetails
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10)
SELECT p.productName, t.top
from products as p
JOIN top as t
USING(`productCode`);

SELECT productCode, COUNT('prouctCode') as top
from orderdetails
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

SELECT DISTINCT count('orderNumber')FROM orderdetails;

SELECT DISTINCT count(*)FROM orders;

-- state by employee for cities in america
SELECT o.state, o.country, COUNT(e.employeeNumber)
from offices as o
JOIN employees as e
USING(officeCode)
WHERE o.country = 'USA'
GROUP BY 1, 2

ORDER BY 3 DESC;

SELECT `customerNumber`, COUNT(*) as num, RANK() 
        OVER (ORDER BY COUNT(*) DESC) AS position
from orders
GROUP BY 1
ORDER BY 2 DESC;
-- top buying customer(s)
WITH summery AS (SELECT `customerNumber`, COUNT(*) as num, RANK() 
        OVER (ORDER BY COUNT(*) DESC) AS position
from orders
GROUP BY 1
ORDER BY 2 DESC)
SELECT c.customerName, s.num
FROM customers AS c
JOIN summery AS s
USING(`customerNumber`)
WHERE s.position = 1;

SELECT `customerNumber`, COUNT(*) as num, RANK() 
        OVER (ORDER BY COUNT(*) DESC) AS position
from orders
GROUP BY 1
ORDER BY 2 DESC;

SELECT * FROM customers LIMIT 10;

-- number of orders by country
SELECT c.country, count(*), SUM(p.amount)
from orders AS o
JOIN customers AS c
USING(`customerNumber`)
JOIN payments AS p
USING(`customerNumber`)
GROUP BY 1
ORDER BY 3 DESC;

-- total payment by country

SELECT * from orderdetails;

-- top 10 most expensive product

SELECT productName, buyPrice, MSRP
from products
ORDER BY 2 DESC
LIMIT 10;

SELECT * FROM products;