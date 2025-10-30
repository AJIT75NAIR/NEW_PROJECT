SELECT *
INTO FactResellerSales_HP
FROM FactResellerSales

SELECT
*
FROM FactResellerSales_HP
ORDER BY SalesOrderNumber

SELECT
*
FROM FactResellerSales
ORDER BY SalesOrderNumber


SELECT
*
FROM FactResellerSales_HP
WHERE CarrierTrackingNumber = '60CF-4768-AF' 


SELECT
*
FROM FactResellerSales
WHERE CarrierTrackingNumber = '60CF-4768-AF' 

CREATE NONCLUSTERED INDEX IDX_FactResellerSales_CTN
ON FactResellerSales (CarrierTrackingNumber)

SELECT CarrierTrackingNumber
FROM FactResellerSales
WHERE CarrierTrackingNumber = '60CF-4768-AF'

SELECT 
    P.EnglishProductName AS ProductName,
    SUM(F.SalesAmount) AS TotalSales
FROM FactResellerSales AS F
JOIN DimProduct AS P 
ON P.ProductKey = F.ProductKey
GROUP BY P.EnglishProductName

SELECT
    P.EnglishProductName AS ProductName,
    SUM (R.SalesAmount) AS TotalSales
FROM FactResellerSales_HP AS R 
JOIN DimProduct AS P 
ON P.ProductKey = R.ProductKey
GROUP BY P.EnglishProductName

CREATE CLUSTERED COLUMNSTORE INDEX IDX_FactResellerSalesHP
ON FactResellerSales_HP 

USE SalesDB

SELECT
    O.Sales,
    C.Country
FROM Sales.Orders AS O 
LEFT JOIN Sales.Customers AS C WITH (FORCESEEK)
ON O.CustomerID = C.CustomerID
OPTION (HASH JOIN)
