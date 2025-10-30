--SHOW ALL CUSTOMER DETAILS AND FIND THE TOTAL ORDERS OF EACH CUSTOMER

USE SalesDB
--MAIN QUERY
SELECT
C.*,
O.TotalOrders_CUST
FROM Sales.Customers AS C 
LEFT JOIN
--SUBQUERY
(
    SELECT
    CustomerID,
    COUNT(1) AS TotalOrders_CUST
    FROM Sales.Orders
    GROUP BY CustomerID
) O 
ON C.CustomerID = O.CustomerID 

--FIND THE PRODUCTS THAT HAVE A PRICE HIGHER THAN THE AVERAGE PRICE OF ALL 
--PRODUCTS

--MAIN QUERY
SELECT
ProductID,
Product,
Price,
(SELECT AVG(Price) FROM Sales.Products) AS AVG_PRICE
FROM Sales.Products
WHERE Price > 
--SUBQUERY
(SELECT AVG(Price) FROM Sales.Products AS AVG_PRICE )

--SHOW THE DETAILS OF ORDERS MADE BY CUSTOMERS IN GERMANY

SELECT
*
FROM Sales.Orders;

SELECT
*
FROM Sales.Customers

SELECT
CustomerID
FROM Sales.Customers
WHERE Country = 'Germany'
 
--MAIN QUERY
SELECT
*
FROM Sales.Orders
WHERE CustomerID IN 
--SUBQUERY
    (SELECT
    CustomerID
    FROM Sales.Customers
    WHERE Country = 'Germany')

--SHOW THE DETAILS OF ORDERS MADE BY CUSTOMERS NOT FROM GERMANY    


--MAIN QUERY
SELECT
*
FROM Sales.Orders
WHERE CustomerID IN 
--SUBQUERY
    (SELECT
    CustomerID
    FROM Sales.Customers
    WHERE Country != 'Germany')

    --MAIN QUERY
SELECT
*
FROM Sales.Orders
WHERE CustomerID NOT IN 
--SUBQUERY
    (SELECT
    CustomerID
    FROM Sales.Customers
    WHERE Country = 'Germany')

--FIND FEMALE EMPLOYEES WHOSE SALARIES ARE GREATER THAN THE SALARIES OF ANY
--MALE EMPPLOYEES

SELECT
EmployeeID,
FirstName,
Salary
FROM Sales.Employees
WHERE Gender = 'F';

SELECT
EmployeeID,
FirstName,
Salary
FROM Sales.Employees
WHERE Gender = 'M'

--MAIN QUERY

SELECT
EmployeeID,
FirstName,
Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ANY 
--SUBQUERY
(SELECT Salary FROM Sales.Employees WHERE Gender = 'M')

--FIND FEMALE EMPLOYEES WHOSE SALARIES ARE GREATER THAN THE SALARIES OF ALL
--MALE EMPPLOYEES

--MAIN QUERY
SELECT
    EmployeeID,
    FirstName,
    Salary 
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ALL 
--SUBQUERY 
(SELECT Salary FROM Sales.Employees WHERE Gender = 'M')

--SHOW ALL CUSTOMER DETAILS AND FIND THE TOTAL ORDERS FOR EACH CUSTOMER

--MAIN QUERY
SELECT
*,
--SUBQUERY
(SELECT COUNT(1) FROM Sales.Orders AS o WHERE o.CustomerID = c.CustomerID) 
AS Total_Sales
FROM Sales.Customers AS c 

--SHOW THE DETAILS OF ORDERS MADE BY CUSTOMERS IN GERMANY

--MAIN QUERY
SELECT
*
FROM Sales.Orders AS O 
WHERE EXISTS
--SUBQUERY
(
SELECT
*
FROM Sales.Customers AS C 
WHERE Country = 'Germany'
AND O.CustomerID = C.CustomerID)   

--MAIN QUERY
SELECT
*
FROM Sales.Orders AS O 
WHERE NOT EXISTS
--SUBQUERY
(
SELECT
*
FROM Sales.Customers AS C 
WHERE Country = 'Germany'
AND O.CustomerID = C.CustomerID)   

--STEP 1 - FIND THE TOTAL SALES PER CUSTOMER

SELECT
    CustomerID,
    SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID