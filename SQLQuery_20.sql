/* CHANGE THE SCORE OF CUSTOMER 6 TO 0 */

SELECT *
FROM customers

UPDATE customers
SET score = 0
WHERE id = 6

SELECT *
FROM customers
WHERE id = 6 

/* CHANGE THE SCORE OF CUSTOMER 10 TO 0 AND UPDATE THE COUNTRY TO UK */

SELECT *
FROM customers

UPDATE customers
SET score = 0,
country = 'UK'
WHERE id = 10

SELECT *
FROM customers
WHERE id = 10

SELECT *
FROM customers
WHERE score IS NULL

UPDATE customers
SET score = 0
WHERE score IS NULL 

SELECT *
FROM customers