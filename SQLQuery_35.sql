SELECT
OrderID,
CreationTime,
FORMAT(CreationTime, 'MM-dd-yyyy') AS USA_FORMAT,
FORMAT(CreationTime, 'dd-MM-yyyy') AS EURO_FORMAT,
FORMAT(CreationTime, 'dd') AS DD,
FORMAT(CreationTime, 'ddd') AS DDD,
FORMAT(CreationTime, 'dddd') AS DDDD, 
FORMAT(CreationTime, 'MM') AS MM,
FORMAT(CreationTime, 'MMM') AS MMM,
FORMAT(CreationTime, 'MMMM') AS MMMM  
FROM Sales.Orders

/*SHOW CREATION TIME USING THE FOLLOWING FORMAT:
---DAY WED JAN Q1 2025 12:34:56 PM
*/

SELECT
OrderID,
CreationTime, 
'Day ' + FORMAT(CreationTime, 'ddd MMM') +
' Q' + DATENAME(quarter, CreationTime) + ' ' +
FORMAT(CreationTime, 'yyyy hh:mm:ss tt') AS CUSTOMFORMAT 
FROM Sales.Orders