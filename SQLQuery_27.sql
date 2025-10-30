/* RETRIEVE ALL DATA FROM CUSTOMERS AND ORDERS IN TWO DIFFERENT RESULTS */

SELECT *
FROM customers;

SELECT *
FROM orders;

/* GET ALL CUSTOMERS ALONG WITH THEIR ORDERS, BUT ONLY FOR CUSTOMERS WHO HAVE PLACED 
AN ORDER */

SELECT *
FROM customers
INNER JOIN orders
ON id = customer_id

SELECT
id,
first_name,
order_id,
sales 
FROM customers
INNER JOIN orders
ON id = customer_id

SELECT 
customers.id,
customers.first_name, 
orders.order_id, 
orders.sales
FROM customers
INNER JOIN orders
ON id = customer_id

SELECT 
c.id,
c.first_name,
o.order_id, 
o.sales 
FROM customers AS c 
INNER JOIN orders AS o 
ON c.id = o.customer_id

