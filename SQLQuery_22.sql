--RETRIEVE ALL CUSTOMERS FROM GERMANY

SELECT *
FROM customers

SELECT *
FROM customers
WHERE country = 'Germany'

/* RETRIEVE ALL CUSTOMERS WHO ARE NOT FROM GERMANY */

SELECT *
FROM customers

SELECT *
FROM customers
WHERE country != 'Germany'

SELECT *
FROM customers
WHERE country <> 'Germany'