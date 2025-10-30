--TIP 1: SELECT ONLY WHAT YOU NEED

--BAD PRACTICE

SELECT
*
FROM Sales.Customers

--GOOD PRACTICE

SELECT
    CustomerID,
    FirstName,
    LastName
FROM Sales.Customers

--TIP 2: AVOID UNNECESSARY DISTINCT & ORDER BY

--BAD PRACTIVE

SELECT DISTINCT  
    FirstName
FROM Sales.Customers
ORDER BY FirstName

--GOOD PRACTICE

SELECT
    FirstName
FROM Sales.Customers

--TIP 3: FOR EXPLORATION PURPOSE, LIMIT ROWS!

--BAD PRACTICE

SELECT
    OrderId,
    Sales
FROM Sales.Orders

--GOOD PRACTICE

SELECT TOP 10
    OrderId,
    Sales
FROM Sales.Orders

--TIP 4: CREATE NONCLUSTERED INDEX ON FREQUENTLY USED COLUMNS IN WHERE CLAUSE

SELECT
*
FROM Sales.Orders 
WHERE OrderStatus = 'Delivered'

CREATE NONCLUSTERED INDEX IDX_ORDERS_ORDERSTATUS 
ON Sales.Orders (OrderStatus)

--TIP 5: AVOID APPLYING FUNCTIONS TO COLUMNS IN WHERE CLAUSES

--BAD PRACTICE

SELECT * FROM Sales.Orders
WHERE LOWER(OrderStatus) = 'delivered'

--GOOD PRACTICE

SELECT * FROM Sales.Orders
WHERE OrderStatus = 'Delivered'

--BAD PRACTICE

SELECT *
FROM Sales.Customers 
WHERE SUBSTRING(FirstName, 1, 1) = 'A'

--GOOD PRACTICE

SELECT *
FROM Sales.Customers 
WHERE FirstName LIKE 'A%'

--BAD PRACTICE

SELECT *
FROM Sales.Orders
WHERE YEAR(OrderDate) = 2025

--GOOD PRACTICE

SELECT *
FROM Sales.Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31'

--TIP 6: AVOID LEADING WILDCARDS AS THEY PREVENT INDEX USAGE

--BAD PRACTICE

SELECT *
FROM Sales.Customers
WHERE LastName LIKE '%Gold%'

--GOOD PRACTICE

SELECT *
FROM Sales.Customers
WHERE LastName LIKE 'Gold%'

--TIP 7: USE IN INSTEAD OF MULTIPLE OR

--BAD PRACTICE

SELECT *
FROM Sales.Orders
WHERE CustomerID = 1 OR CustomerID = 2 OR CustomerID = 3

--GOOD PRACTICE

SELECT *
FROM Sales.Orders 
WHERE CustomerID IN (1, 2, 3)

--TIP 8: UNDERSTAND THE SPEED OF JOINS AND USE INNER JOIN WHERE POSSIBLE

--BEST PERFORMANCE

SELECT
    C.FirstName,
    O.OrderId
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O 
ON C.CustomerID = O.CustomerID

--SLIGHTLY SLOWER PERFORMANCE

SELECT
    C.FirstName,
    O.OrderId
FROM Sales.Customers AS C 
RIGHT JOIN Sales.Orders AS O 
ON C.CustomerID = O.CustomerID

SELECT
    C.FirstName,
    O.OrderId
FROM Sales.Customers AS C 
LEFT JOIN Sales.Orders AS O 
ON C.CustomerID = O.CustomerID

USE SalesDB

--WORST PERFORMANCE

SELECT
    C.FirstName,
    O.OrderId
FROM Sales.Customers AS C 
LEFT OUTER JOIN Sales.Orders AS O 
ON C.CustomerID = O.CustomerID


--TIP 9: USE EXPLICIT JOIN (ANSI JOIN) INSTEAD OF IMPLICIT JOIN
--(NON-ANSI JOIN)

--BAD PRACTICE

SELECT 
    O.OrderId,
    C.FirstName
FROM Sales.Customers AS C, Sales.Orders AS O 
WHERE C.CustomerID = O.CustomerID

--GOOD PRACTICE

SELECT
    O.OrderId,
    C.FirstName
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O 
ON C.CustomerID = O.CustomerID

--TIP 10: MAKE SURE TO INDEX THE COLUMNS USED IN THE ON CLAUSE

SELECT 
    C.FirstName,
    O.OrderId
FROM Sales.Orders AS O 
INNER JOIN Sales.Customers AS C 
ON C.CustomerID = O.CustomerID

CREATE NONCLUSTERED INDEX IDX_ORDERS_CUSTOMERID 
ON Sales.Orders (CustomerID)

--TIP 12: FILTER BEFORE JOINING (BIG TABLES)

--FILTER AFTER JOIN (WHERE)

SELECT
    C.FirstName,
    O.OrderId
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O 
ON C.CustomerID = O.CustomerID
WHERE O.OrderStatus = 'Delivered'

--FILTER DURING JOIN (ON)

SELECT
    C.FirstName,
    O.OrderId
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O 
ON C.CustomerID = O.CustomerID
AND O.OrderStatus = 'Delivered'

--FILTER BEFORE JOIN (SUBSQUERY)

SELECT
    C.FirstName,
    O.OrderId
FROM Sales.Customers AS C 
INNER JOIN (SELECT OrderId, CustomerID FROM Sales.Orders 
WHERE OrderStatus = 'Delivered') AS O 
ON C.CustomerID = O.CustomerID

--TIP 12: AGGREGATE BEFORE JOINING (BIG TABLES)

--BEST PRACTICE FOR SMALL MEDIUM TABLES

--GROUPING & JOINING

SELECT 
    C.CustomerID,
    C.FirstName,
    COUNT(O.OrderId) AS OrderCount
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O 
ON C.CustomerID = O.CustomerID
GROUP BY 
    C.CustomerID,
    C.FirstName

--BEST PRACTICE FOR BIG TABLES

--PRE-AGGREGATED SUBQUERY

SELECT
    C.CustomerID,
    C.FirstName,
    O.OrderCount
FROM Sales.Customers AS C 
INNER JOIN (SELECT 
    CustomerID,
    COUNT(OrderId) AS OrderCount
    FROM Sales.Orders
    GROUP BY CustomerID) AS O 
ON C.CustomerID = O.CustomerID

--BAD PRACTICE

--CORRELATED SUBQUERY

SELECT
    C.CustomerID,
    c.FirstName,
    (SELECT 
    COUNT(O.OrderId)
FROM Sales.Orders AS O
WHERE O.CustomerID = C.CustomerID) AS OrderCount
FROM Sales.Customers AS C 

USE SalesDB

--TIP 13: USE UNION INSTEAD OF OR IN JOINS

--BAD PRACTICE

SELECT
    O.OrderId,
    C.FirstName
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O 
ON C.CustomerID = O.CustomerID
OR C.CustomerID = O.SalesPersonID

--BEST PRACITCE

SELECT 
    O.OrderId,
    C.FirstName
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O 
ON C.CustomerID = O.CustomerID
UNION
SELECT
    O.OrderId,
    C.FirstName
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O 
ON C.CustomerID = O.SalesPersonID

--TIP 14: CHECK FOR NESTED LOOPS AND USE SQL HINTS

SELECT
    O.OrderId,
    C.FirstName 
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O 
ON C.CustomerID = O.CustomerID

--GOOD PRACTICE FOR BIG & SMALL TABLES

SELECT
    O.OrderId,
    C.FirstName
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O 
ON C.CustomerID = O.CustomerID
OPTION (HASH JOIN)

--TIP 15: USE UNION ALL INSTEAD OF USING UNION, DUPLICATES ARE ACCEPTABLE

--BAD PRACTICE

SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive

--BEST PRACTICE

SELECT CustomerID FROM Sales.Orders
UNION ALL
SELECT CustomerID FROM Sales.OrdersArchive

--TIP 16: USE UNION ALL + DISTINCT INSTEAD OF UNION IF DUPLICATES
--ARE NOT ACCEPTABLE

--BAD PRACTICE

SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive

--BEST PRACTICE

SELECT DISTINCT CustomerID
FROM 
( 
    SELECT CustomerID FROM Sales.Orders
    UNION ALL 
    SELECT CustomerID FROM Sales.OrdersArchive
) AS COMBINEDDATA

--TIP 17: USE COLUMNSTORE INDEX FOR AGGREGATIONS ON LARGE TABLE

SELECT
    CustomerID,
    COUNT(OrderId) AS OrderCount
FROM Sales.Orders
GROUP BY CustomerID

CREATE CLUSTERED COLUMNSTORE INDEX IDX_ORDERS_COLUMNSTORE ON 
Sales.Orders

--TIP 18: PRE-AGGREGATE DATA AND STORE IT IN NEW DATA FOR REPORTING

SELECT 
    MONTH(OrderDate) AS OrderYear, 
    SUM(Sales) AS TotalSales
INTO Sales.SalesSummary  
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

SELECT 
    OrderYear,
    TotalSales
FROM Sales.SalesSummary

--JOIN (BEST PRACTICE: IF THE PERFORMANCE EQUALS TO EXISTS)

SELECT 
    O.OrderId,
    O.Sales
FROM Sales.Orders AS O 
INNER JOIN Sales.Customers AS C 
ON O.CustomerID = C.CustomerID
WHERE C.Country = 'USA'

--EXISTS (BEST PRACTICE: USE IT FOR LARGE TABLES)

SELECT 
    O.OrderId,
    O.Sales 
FROM Sales.Orders AS O 
WHERE EXISTS (
    SELECT 1
    FROM Sales.Customers AS C 
    WHERE C.CustomerID = O.CustomerID
    AND C.Country = 'USA'
)

--IN (BAD PRACTICE)

SELECT
    O.OrderId,
    O.Sales
FROM Sales.Orders AS O 
WHERE O.CustomerID IN (
    SELECT 
    CustomerID
    FROM Sales.Customers
    WHERE Country = 'USA'
)

--TIP 20: AVOID REDUNDANT LOGIC IN YOUR QUERY

--BAD PRACTICE 

SELECT
    EmployeeID,
    FirstName,
    'Above Average' Status 
FROM Sales.Employees
WHERE Salary > (SELECT AVG(Salary) FROM Sales.Employees)
UNION ALL
SELECT 
    EmployeeID,
    FirstName,
    'Below Average' Status 
FROM Sales.Employees
WHERE Salary < (SELECT AVG(Salary) FROM Sales.Employees)

--GOOD PRACTICE

SELECT
    EmployeeID,
    FirstName,
    CASE 
        WHEN Salary > AVG(Salary) OVER() THEN 'Above Average'
        WHEN Salary < AVG(Salary) OVER() THEN 'Below Average'
        ELSE 'Average'
    END AS Status 
FROM Sales.Employees

--TIP 21: AVOID VARCHAR AND TEXT DATA TYPES WHERE POSSIBLE

CREATE TABLE CustomersInfo (
    CustomerID INT,
    FirstName VARCHAR(MAX),
    LastName TEXT,
    Country VARCHAR(255),
    TotalPurchases FLOAT,
    Score VARCHAR(255),
    BirthDate VARCHAR(255),
    EmployeeID INT,
    CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES Sales.Employees (EmployeeID)
)

--BEST PRACTICE

CREATE TABLE CustomersInfo (
    CustomerID INT PRIMARY KEY CLUSTERED,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    TotalPurchases FLOAT,
    Score INT,
    BirthDate DATE,
    EmployeeID INT,
    CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES Sales.Employees(EmployeeID)
)

--TIP 22:AVOID (MAX) UNNCESSARILY LARGE LENGTHS IN DATA TYPES

--TIP 23:USE THE NOT NULL CONSTRAINT WHERE POSSIBLE

--TIP 24: ENSURE ALL YOUR TABLES HAVE A CLUSTERED PRIMARY KEY

--TIP 25: CREATE A NON-CLUSTERED INDEX FOR FOREIGN KEYS THAT ARE USED
--FREQUENTLY

CREATE NONCLUSTERED INDEX IDX_CustomersInfo_EmployeeID
ON CustomersInfo (EmployeeID)

--BEST PRACTICES ON INDEXING

--TIP 26: AVOID OVER INDEXING

--TIP 27: DROP UNUSED INDEXES

--TIP 28: UPDATE STATISTICS (WEEKLY)

--TIP 29: REORGANIZE AND REBUILD INDEXES (WEEKLY)

--TIP 30: PARTITION LARGE TABLES (FACTS) TO IMPROVE PERFORMANCE

--NEXT, APPLY A COLUMNSTORE INDEX FOR THE BEST RESULTS





