--FIND THE TOTAL SCORE FOR EACH COUNTRY
SELECT 
country,
score 
FROM customers
SELECT 
country,
SUM(score)  
FROM customers
GROUP BY country
SELECT 
country, 
SUM(score) AS total_score
FROM customers
GROUP BY country
SELECT
country AS customer_country,
SUM(score) AS total_score
FROM customers
GROUP BY country
SELECT 
country,
first_name,
SUM(score) AS total_score 
FROM customers
GROUP BY country, first_name
--FIND THE TOTAL SCORE AND TOTAL NUMBER OF CUSTOMERS FOR EACH COUNTRY
SELECT
country,
SUM(score) AS total_score,
COUNT(id) AS total_customers
FROM customers
GROUP BY country