--PROVIDE A VIEW FOR THE EU SALES TEAM THAT COMBINES DETAILS FROM ALL TABLES AND 
--EXCLUDES DATA RELATED TO USA

SELECT
O.OrderID,
P.Product,
P.Category,
COALESCE(C.FirstName,'') + '' + COALESCE(C.LastName,'') AS CUST_NAME,
C.Country AS CUST_COUNTRY,
COALESCE(E.FirstName,'') + '' + COALESCE(E.LastName,'') AS SALES_NAME,
E.Department,
O.OrderDate,
O.Sales,
O.Quantity
FROM Sales.Orders AS O 
LEFT JOIN Sales.Products AS P 
ON P.ProductID = O.ProductID
LEFT JOIN Sales.Customers AS C 
ON C.CustomerID = O.CustomerID
LEFT JOIN Sales.Employees AS E 
ON E.EmployeeID = O.SalesPersonID
WHERE C.COUNTRY != 'USA'

CREATE VIEW Sales.V_ORDER_DETAILS_EU AS 
(
    SELECT
O.OrderID,
P.Product,
P.Category,
COALESCE(C.FirstName,'') + '' + COALESCE(C.LastName,'') AS CUST_NAME,
C.Country AS CUST_COUNTRY,
COALESCE(E.FirstName,'') + '' + COALESCE(E.LastName,'') AS SALES_NAME,
E.Department,
O.OrderDate,
O.Sales,
O.Quantity
FROM Sales.Orders AS O 
LEFT JOIN Sales.Products AS P 
ON P.ProductID = O.ProductID
LEFT JOIN Sales.Customers AS C 
ON C.CustomerID = O.CustomerID
LEFT JOIN Sales.Employees AS E 
ON E.EmployeeID = O.SalesPersonID

)

SELECT 
*
FROM Sales.V_ORDER_DETAILS_EU

DROP VIEW Sales.V_ORDER_DETAILS_EU

CREATE VIEW Sales.V_ORDER_DETAILS_EU AS 
(
    SELECT
O.OrderID,
P.Product,
P.Category,
COALESCE(C.FirstName,'') + '' + COALESCE(C.LastName,'') AS CUST_NAME,
C.Country AS CUST_COUNTRY,
COALESCE(E.FirstName,'') + '' + COALESCE(E.LastName,'') AS SALES_NAME,
E.Department,
O.OrderDate,
O.Sales,
O.Quantity
FROM Sales.Orders AS O 
LEFT JOIN Sales.Products AS P 
ON P.ProductID = O.ProductID
LEFT JOIN Sales.Customers AS C 
ON C.CustomerID = O.CustomerID
LEFT JOIN Sales.Employees AS E 
ON E.EmployeeID = O.SalesPersonID
WHERE C.Country != 'USA'
)

SELECT
*
FROM Sales.V_ORDER_DETAILS_EU

