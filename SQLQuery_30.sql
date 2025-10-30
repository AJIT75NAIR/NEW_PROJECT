SELECT 
FirstName,
LastName
FROM Sales.Customers
UNION 
SELECT 
FirstName,
LastName
FROM Sales.Employees

SELECT 
CustomerID,
LastName
FROM Sales.Customers
UNION 
SELECT 
EmployeeID,
LastName
FROM Sales.Employees