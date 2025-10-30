--FIND THE RUNNING TOTAL OF SALES FOR EACH MONTH

WITH CTE_MONTHLY_SUMMARY AS 

(

    --SUBQUERY
     SELECT
    DATETRUNC(MONTH,OrderDate) AS ORDER_MONTH,
    SUM(Sales) AS TotalSales,
    COUNT(OrderID) AS TotalOrders,
    SUM(Quantity) AS TotalQuantity
    FROM Sales.Orders
    GROUP BY DATETRUNC(MONTH,OrderDate)

)

--MAIN QUERY

SELECT
ORDER_MONTH,
TotalSales,
SUM(TotalSales) OVER(ORDER BY ORDER_MONTH)AS RUNNING_TOTAL,
TotalOrders,
TotalQuantity 
FROM CTE_MONTHLY_SUMMARY 

/*

WITH CTE_MONTHLY_SUMMARY AS 

(

    --SUBQUERY
    SELECT
    DATETRUNC(MONTH,OrderDate) AS ORDER_MONTH,
    SUM(Sales) AS TotalSales,
    COUNT(OrderID) AS TotalOrders,
    SUM(Quantity) AS TotalQuantity
    FROM Sales.Orders
    GROUP BY DATETRUNC(MONTH,OrderDate)

)

*/

