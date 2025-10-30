/* USING SALESDB, RETRIEVE A LIST OF ALL ORDERS, ALONG WITH THE RELATED CUSTOMER,
PRODUCT AND EMPLOYEE DETAILS.

FOR EACH ORDER, DISPLAY:

-ORDER ID
-CUSTOMER'S NAME
-PRODUCT NAME
-SALES AMOUNT 
-PRODUCT PRICE
-SALES PERSON'S NAME
*/

USE SalesDB

SELECT 
o.OrderID, 
o.Sales
FROM Sales.Orders AS o  

SELECT *
FROM Sales.Customers;

SELECT *
FROM Sales.Employees;

SELECT *
FROM Sales.Orders;

SELECT *
FROM Sales.OrdersArchive;

SELECT *
FROM Sales.Products;

SELECT 
o.OrderID,
o.Sales AS SalesAmount, 
c.FirstName AS CustomerFirstName,
c.LastName AS CustomerLastName,
p.Product AS ProductName,
p.Price, 
e.FirstName AS SalesPersonFirstName,
e.LastName AS SalesPersonLastName
FROM Sales.Orders AS o 
LEFT JOIN Sales.Customers AS c 
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p 
ON o.ProductID = p.ProductID 
LEFT JOIN Sales.Employees AS e 
ON o.SalesPersonID = e.EmployeeID

