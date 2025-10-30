/* RETRIEVE ALL CUSTOMERS FORM EITHER GERMANY OR USA */

SELECT  *
FROM customers

SELECT * 
FROM customers
WHERE country = 'Germany'
OR country = 'USA'

SELECT *
FROM customers
WHERE country IN ('Germany', 'USA')