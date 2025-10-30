/* GET ALL CUSTOMERS ALONG WITH THEIR ORDERS INCLUDING THOSE WITHOUT ORDERS */

SELECT *
FROM customers
LEFT JOIN orders
ON id = customer_id

SELECT *
FROM orders

SELECT 
c.id,
c.first_name,
o.order_id,
o.sales 
FROM customers AS c 
LEFT JOIN orders AS o 
ON id = customer_id

/* GET ALL CUSTOMERS ALONG WITH THEIR ORDERS, INCLUDING ORDERS WITHOUT MATCHING 
CUSTOMERS */

SELECT *
FROM customers;

SELECT *
FROM orders;

SELECT 
c.id, 
c.first_name, 
o.order_id, 
o.sales   
FROM customers AS c 
RIGHT JOIN orders AS o
ON id = customer_id 

/* GET ALL CUSTOMERS ALONG WITH THEIR ORDERS, INCLUDING ORDERS WITHOUT MATCHING 
CUSTOMERS USING LEFT JOIN */

SELECT 
c.id, 
c.first_name,
o.order_id,
o.sales
FROM orders AS o 
LEFT JOIN customers AS c 
ON id = customer_id

--GET ALL CUSTOMERS AND ORDERS EVEN IF THERE IS NO MATCH

SELECT *
FROM customers;

SELECT *
FROM orders;

SELECT 
c.id, 
c.first_name,
o.order_id,
o.sales  
FROM customers AS c 
FULL JOIN orders AS o 
on id = customer_id

--GET ALL CUSTOMERS WHO HAVEN'T PLACED ANY ORDER

SELECT *
FROM customers AS c 
LEFT JOIN orders AS o 
ON c.id = o.customer_id
WHERE order_id IS NULL  

--GET ALL ORDERS WITHOUT MATCHING CUSTOMERS

SELECT *
FROM customers;

SELECT *
FROM orders;

SELECT *
FROM customers AS c 
RIGHT JOIN orders AS o 
ON id = customer_id
WHERE id IS NULL

SELECT *
FROM orders AS o 
LEFT JOIN customers AS c  
ON customer_id = id 
WHERE id IS NULL 

--FIND CUSTOMERS WITHOUT ORDERS AND ORDERS WITHOUT CUSTOMERS

SELECT *
FROM customers AS c 
FULL JOIN orders AS o
ON id = customer_id
WHERE id IS NULL
OR 
customer_id IS NULL 


/* GET ALL CUSTOMERS ALONG WITH THEIR ORDERS BUT ONLY FOR CUSTOMERS WHO HAVE PLACED
AN ORDER WITHOUT USING INNER JOIN */

SELECT *
FROM customers AS c 
FULL JOIN orders AS o
ON id = customer_id
WHERE id != 0
AND
customer_id != 0 

--GENERATE ALL POSSIBLE COMBINMATIONS OF CUSTOMERS AND ORDERS

SELECT *
FROM customers;

SELECT *
FROM orders;

SELECT *
FROM customers AS c 
CROSS JOIN orders AS o  


