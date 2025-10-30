/* FIND THE AVERAGE SCORE FOR EACH COUNTRY CONSIDERING ONLY CUSTOMERS WITH A SCORE
NOT EQUAL TO ZERO AND RETURN ONLY THOSE COUNTRIES WITH AN AVERAGE SCORE GREATER THAN 430 */



SELECT 
id,
country,
score 
FROM customers

SELECT
id,
country,
score 
FROM customers
WHERE score != 0

SELECT 
country,
AVG(score) AS avg_score 
FROM customers
WHERE score != 0
GROUP BY country

SELECT
country,
AVG(score) AS average_score 
FROM customers 
WHERE score != 0
GROUP BY country 
HAVING AVG(score) > 430