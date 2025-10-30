SELECT 123 

SELECT 123 AS static_number

SELECT 'Hello'

SELECT 'Hello' AS static_string

SELECT
id,
first_name
FROM customers

SELECT 
id,
first_name,
'New Customer' AS customer_type
FROM customers

SELECT *
FROM customers
WHERE country = 'Germany'

SELECT *
FROM orders