
with cust_count AS (
    SELECT c.customer_unique_id, COUNT(customer_id) as customer_count
    FROM orders as o
    LEFT JOIN customers as c
    USING(customer_id)
    WHERE YEAR(DATE(order_purchase_timestamp)) between 2017 and 2018
    GROUP BY 1
)
SELECT count(*)
FROM cust_count
where customer_count > 1;

with cust_count AS (
    SELECT c.customer_unique_id, COUNT(order_id) as purchase_count
    FROM orders as o
    LEFT JOIN customers as c
    USING(customer_id)
    WHERE YEAR(DATE(order_purchase_timestamp)) between 2017 and 2018
    GROUP BY 1
),
repeats AS(
    SELECT *
    FROM cust_count
    where purchase_count > 1
),
repeat_customers AS (
    SELECT customer_id
    from customers
    JOIN repeats
    USING(customer_unique_id)
)
SELECT count(order_id) as "Percentage of sales volumn for repeted custommers"
FROM orders
JOIN repeat_customers
USING(customer_id)
WHERE YEAR(DATE(order_purchase_timestamp)) between 2017 and 2018;
