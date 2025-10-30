/* 
USE SalesDB

--FIND THE TOTAL NUMBER OF ORDERS AND TOTAL SALES

SELECT
COUNT(OrderID) AS TotalOrders,
SUM(Sales) AS TotalSales
FROM Sales.Orders o 
JOIN Sales.Customers c 
ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'



USE SalesDB

*/

/*
--DEFINE STORED PROCEDURE

ALTER PROCEDURE USCUSTOMER_SUMMARY @Country NVARCHAR(50) = 'USA' 
AS 
BEGIN
SELECT
    COUNT(*) AS TotalCustomers,
    AVG(Score) AS AVG_SCORE
FROM Sales.Customers
WHERE Country = @Country;

--FIND THE TOTAL NUMBER OF ORDERS AND TOTAL SALES
SELECT
    COUNT(OrderID) AS TotalOrders,
    SUM(Sales) AS TotalSales
FROM Sales.Orders o 
JOIN Sales.Customers c 
ON c.CustomerID = o.CustomerID
WHERE c.Country = @Country;

END 

--EXECUTE THE STORED PROCEDURE
EXEC USCUSTOMER_SUMMARY
EXEC USCUSTOMER_SUMMARY @Country = 'Germany'  

*/

--TOTAL CUSTOMERS FROM GERMANY:2
--AVERAGE SCORE FROM GERMANY: 425

ALTER PROCEDURE USCUSTOMER_SUMMARY @Country NVARCHAR(50) = 'USA' 
AS 
BEGIN

    BEGIN TRY 

    DECLARE @TotalCustomers INT, @AVG_SCORE FLOAT;
    --=================================
    --STEP 1: PREPARE & CLEANUP DATA
    --=================================
    SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = 'Germany'

    IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
    BEGIN
    PRINT ('UPDATING NULL SCORES TO 0');
    UPDATE Sales.Customers
    SET Score = 0
    WHERE Score IS NULL AND Country = @Country;
    END

    ELSE
    BEGIN
        PRINT('NO NULL SCORES FOUND')
    END;

      --===================================
    --STEP 2: GENERATING SUMMARY REPORTS
    --=====================================
    --CALCULATE TOTAL CUSTOMERS AND AVERAGE SCORES FOR SPECIFIC COUNTRIES

    SELECT
        @TotalCustomers = COUNT(*),
        @AVG_SCORE = AVG(Score)
    FROM Sales.Customers
    WHERE Country = @Country;

    PRINT 'TOTAL CUSTOMERS FROM ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
    PRINT 'AVERAGE SCORE FROM ' + @Country + ':' + CAST(@AVG_SCORE AS NVARCHAR);

    --CALCULATE TOTAL NUMBER OF ORDERS AND TOTAL SALES FOR SPECIFIC COUNTRIES
    SELECT
        COUNT(OrderID) AS TotalOrders,
        SUM(Sales) AS TotalSales
    FROM Sales.Orders o 
    JOIN Sales.Customers c 
    ON c.CustomerID = o.CustomerID
    WHERE c.Country = @Country;

    END TRY 
    BEGIN CATCH
        --============================
        --ERROR HANDLING
        --============================
        PRINT('AN ERROR OCCURED.');
        PRINT('ERROR MESSAGE:' + ERROR_MESSAGE());
        PRINT('ERROR NUMBER:' + CAST(ERROR_NUMBER() AS NVARCHAR));
        PRINT('ERROR LINE:' + CAST(ERROR_LINE() AS NVARCHAR));
        PRINT('ERROR PROCEDURE' + ERROR_PROCEDURE()); 
    END CATCH

END 
GO 

--EXECUTE THE STORED PROCEDURE
EXEC USCUSTOMER_SUMMARY
EXEC USCUSTOMER_SUMMARY @Country = 'Germany'  

SELECT * FROM Sales.Customers

