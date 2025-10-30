--COMBINE THE DATA FROM EMPLOYEES AND CUSTOMERS INTO ONE TABLE

SELECT *
FROM sales.Employees;

SELECT *
FROM sales.Customers;


SELECT 
FirstName,
LastName 
FROM Sales.Employees 
UNION 
SELECT 
FirstName,
LastName
FROM Sales.Customers  

/* COMBINE THE DATA FROM EMPLOYEES AND CUSTOMERS INTO ONE TABLE, INCLUDING DUPLICATES
*/

SELECT 
FirstName,
LastName
FROM Sales.Employees
UNION ALL 
SELECT 
FirstName,
LastName
FROM Sales.Customers

--FIND EMPLOYEES WHO ARE NOT CUSTOMERS AT THE SAME TIME

SELECT 
FirstName,
LastName
FROM Sales.Employees
EXCEPT
SELECT
FirstName,
LastName
FROM Sales.Customers

--FIND THE EMPLOYEES WHO ARE ALSO THE CUSTOMERS

SELECT
FirstName,
LastName
FROM Sales.Employees
INTERSECT
SELECT 
FirstName,
LastName
FROM Sales.Customers

/* ORDERS DATA ARE STORED IN SEPARATE TABLES (ORDERS AND ORDERS ARCHIVE).
COMBINE ALL ORDERS DATA INTO ONE REPORT WITHOUT DUPLICATES */

SELECT *
FROM Sales.Orders;

SELECT *
FROM Sales.OrdersArchive;

SELECT 
'Orders' AS SourceTable,
OrderID
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION
SELECT 
'OrdersArchive' AS SourceTable,
OrderID
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive

