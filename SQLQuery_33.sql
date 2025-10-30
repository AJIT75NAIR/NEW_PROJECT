SELECT
OrderDate,
ShipDate,
CreationTime,
'2025-08-20' AS HardCoded,
GETDATE () AS Today
FROM Sales.Orders

SELECT
OrderId,
CreationTime,
YEAR(CreationTime) AS YEAR
FROM Sales.Orders

SELECT
OrderId,
CreationTime,
--DATETRUNC EXAMPLES
DATETRUNC(Minute, CreationTime) AS Minute_DT,
DATETRUNC(Hour, CreationTime) AS Hour_DT,
DATETRUNC(Day, CreationTime) AS Day_DT,
DATETRUNC(Month, CreationTime) AS Month_DT,
DATETRUNC(Year, CreationTime) AS Year_DT,
--DATENAME EXAMPLES
DATENAME(Month, CreationTime) AS Month_DN,
DATENAME(Weekday, CreationTime) AS Weekday_DN, 
DATENAME(Day, CreationTime) AS Day_DN, 
DATENAME(Year, CreationTime) AS Year_DN, 
--DATEPART EXAMPLES
DATEPART(Year, CreationTime) AS Year_DP,
DATEPART(Month, CreationTime) AS Month_DP,
DATEPART(Day, CreationTime) AS Day_DP,
DATEPART(Hour, CreationTime) AS Hour_DP,
DATEPART(Quarter, CreationTime) AS Quarter_DP,
DATEPART(Week, CreationTime) AS Week_DP,
DATEPART(Weekday, CreationTime) AS Weekday_DP,
YEAR(CreationTime) AS Year, 
MONTH(CreationTime) AS Month,
DAY(CreationTime) AS Day 
FROM Sales.Orders

SELECT
DATETRUNC(Month, CreationTime) AS Month_DT,
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(Month, CreationTime)

SELECT
DATETRUNC(Year, CreationTime) AS Year_DT, 
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(Year, CreationTime)

SELECT
*
FRom Sales.Orders

SELECT
OrderID,
CreationTime,
EOMONTH(CreationTime) AS EndOfMonth
FROM Sales.Orders

SELECT
OrderID,
CreationTime,
EOMONTH(CreationTime) AS EndOfMonth,
DATETRUNC(Month, CreationTime) AS StartOfMonth
FROM Sales.Orders

SELECT
OrderID,
CreationTime,
EOMONTH(CreationTime) AS EndOfMonth,
CAST(DATETRUNC(Month, CreationTime) AS DATE) AS StartOfMonth
FROM Sales.Orders

--HOW MANY ORDERS WERE PLACED EACH YEAR?

SELECT
YEAR(OrderDate),
Count(*) AS NoOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate) 

--HOW MANY ORDERS WERE PLACED EACH MONTH?

SELECT
MONTH(OrderDate),
Count(*) AS NoOfOrders
FROM Sales.Orders
GROUP BY Month(OrderDate) 

--HOW MANY ORDERS WERE PLACED EACH MONTH WITH MONTH IN WORDS

SELECT
DATENAME(Month, OrderDate) AS OrderMonth,
Count(*) AS NoOfOrders
FROM Sales.Orders
GROUP BY DATENAME(Month, OrderDate)

