-- Find the total number of employees in every country

SELECT o.country,
    COUNT(e.employeeNumber) num_of_employees
FROM employees e
JOIN offices o
ON e.officeCode = o.officeCode
GROUP BY 1;

-- Find the top ten products with the highest demands recently?

SELECT p.productName, od.quantityOrdered, o.orderDate
    FROM orderdetails od
    JOIN products p
    on p.productCode = od.productCode
    JOIN orders o
    ON o.orderNumber = od.orderNumber
    GROUP BY 2,1,3
    ORDER BY 2 DESC, 3 DESC
    LIMIT 10;


WITH d_data AS  (
    SELECT p.productName prod, od.quantityOrdered qtty, 
    o.orderDate o_date
    FROM orderdetails od
    JOIN products p
    on p.productCode = od.productCode
    JOIN orders o
    ON o.orderNumber = od.orderNumber
    AND YEAR(o.orderDate) = (SELECT MAX(YEAR(orderDate))
        FROM orders) 
    GROUP BY 2,1,3
    ORDER BY 2 DESC, 3 DESC
)
SELECT d.prod, d.qtty,
    SUM(d.qtty) OVER(PARTITION BY d.prod ORDER BY d.o_date) qtty_o_time, 
    d.o_date
    FROM d_data d
    -- JOIN products p
    -- on p.productCode = od.productCode
    -- JOIN orders o
    -- ON o.orderNumber = od.orderNumber
    GROUP BY 2,1,4
    ORDER BY 2 DESC, 4 DESC
    LIMIT 10;

    select *
    from customers
    limit 10;
