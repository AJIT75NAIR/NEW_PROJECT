--STEP 1: CREATE A NEW TABLE

SELECT 
*
INTO Sales.DBCustomers
FROM Sales.Customers

SELECT
*
FROM Sales.DBCustomers
WHERE CustomerID = 1

CREATE CLUSTERED INDEX IDX_DBCUSTOMERS_CustomerID 
ON
Sales.DBCustomers (CustomerID)

CREATE CLUSTERED INDEX IDX_DBCUSTOMERS_FirstName 
ON
Sales.DBCustomers (FirstName)

DROP INDEX IDX_DBCUSTOMERS_CustomerID ON Sales.DBCustomers

SELECT
*
FROM Sales.DBCustomers
WHERE LastName = 'Brown'

SELECT
*
FROM Sales.DBCustomers
WHERE FirstName = 'Anna'

SELECT
*
FROM Sales.DBCustomers
WHERE Country = 'USA' AND Score > 500

SELECT
*
FROM Sales.DBCustomers
WHERE Score > 500 AND Country = 'USA'

SELECT
*
FROM Sales.DBCustomers
WHERE Country = 'USA' 

CREATE NONCLUSTERED INDEX IDX_DBCUSTOMERS_LastName ON Sales.DBCustomers (LastName)

CREATE INDEX IDX_DBCUSTOMERS_FirstName ON Sales.DBCustomers (FirstName)

CREATE INDEX IDX_DBCUSTOMERS_CountryScore ON Sales.DBCustomers (Country, Score) 

DROP INDEX IDX_DBCUSTOMERS_CustomerID ON Sales.DBCustomers 

CREATE CLUSTERED COLUMNSTORE INDEX IDX_DBCUSTOMERS_CS ON Sales.DBCustomers

CREATE NONCLUSTERED COLUMNSTORE INDEX IDX_DBCUSTOMERS_CS_FirstName 
ON Sales.DBCustomers (FirstName)

DROP INDEX IDX_DBCUSTOMERS_CS ON Sales.DBCustomers

USE AdventureWorksDW2019

--HEAP

--STEP 1: CREATE NEW TABLE 

SELECT
*
INTO FactInternetSales_HP
FROM FactInternetSales

--STEP 2: CREATE CLUSTERED ROW STORE INDEX

SELECT
*
INTO FactInternetSales_RS
FROM FactInternetSales

CREATE CLUSTERED INDEX IDX_FactInternetSales_RS_PK
ON FactInternetSales_RS (SalesOrderNumber, SalesOrderLineNumber)

--STEP 3: CREATE CLUSTERED COLUMNSTORE INDEX

SELECT
*
INTO FactInternetSales_CS
FROM FactInternetSales

CREATE CLUSTERED COLUMNSTORE INDEX IDX_FactInternetSales_CS_PK
ON FactInternetSales_CS

EXEC sp_spaceused 'FactInternetSales_HP'

EXEC sp_spaceused 'FactInternetSales_RS'

EXEC sp_spaceused 'FactInternetSales_CS'

USE SalesDB

SELECT 
*
FROM Sales.Products

CREATE UNIQUE NONCLUSTERED INDEX IDX_Products_Product
ON Sales.Products (Product)

INSERT INTO Sales.Products (ProductID, Product) VALUES (106, 'Caps')    

SELECT
*
FROM Sales.Customers
WHERE Country = 'USA'

CREATE NONCLUSTERED INDEX IDX_Customers_Country
ON Sales.Customers (Country)
WHERE Country = 'USA'

sp_helpindex 'Sales.DBCustomers'

SELECT * FROM sys.indexes 

SELECT
    TBL.name AS TableName,
    IDX.name AS INDEXNAME,
    IDX.type_desc AS INDEXTYPE,
    IDX.is_primary_key AS ISPRIMARYKEY,
    IDX.is_unique AS ISUNIQUE,
    IDX.is_disabled AS ISDISABLED,
    S.user_seeks AS UserSeeks,
    S.user_scans AS UserScans,
    S.user_lookups AS UserLookups,
    S.user_updates AS UserUpdates,
    COALESCE(S.last_user_seek, S.last_user_scan) AS LastUpdate
FROM sys.indexes AS IDX 
JOIN sys.Tables AS TBL  
ON IDX.object_id = TBL.object_id
LEFT JOIN sys.dm_db_index_usage_stats AS S 
ON S.object_id = IDX.object_id
AND S.index_id = IDX.index_id 
ORDER BY TBL.name, IDX.name

SELECT * FROM sys.tables

SELECT * FROM sys.dm_db_index_usage_stats

SELECT * FROM Sales.Products
WHERE Product = 'Caps'

USE AdventureWorksDW2019

SELECT
    FS.SalesOrderNumber,
    DP.EnglishProductName,
    DP.Color 
FROM FactInternetSales AS FS 
INNER JOIN DimProduct AS DP 
ON FS.ProductKey = DP.ProductKey
WHERE DP.Color = 'Black'
AND FS.OrderDateKey BETWEEN 20101229 AND 20101231

SELECT
*
FROM DimProduct

SELECT
*
FROM FactInternetSales

SELECT * FROM sys.dm_db_missing_index_details

SELECT
    TBL.name AS TableName,
    COL.name AS IndexColumn,
    IDX.name AS IndexName,
    IDX.type_desc AS IndexType, 
    COUNT(*) OVER (PARTITION BY TBL.name, COL.name) AS ColumnCount 
FROM sys.indexes AS IDX 
JOIN sys.tables AS TBL 
ON IDX.object_id = TBL.object_id
JOIN sys.index_columns AS IC 
ON IDX.object_id = IC.object_id 
AND IDX.index_id = IC.index_id
JOIN sys.columns AS COL 
ON IC.object_id = COL.object_id
AND IC.column_id = COL.column_id
ORDER BY ColumnCount DESC 

USE SalesDB;

SELECT
    SCHEMA_NAME (T.schema_id) AS SchemaName,
    T.name AS TableName,
    S.name AS StatisticName, 
    SP.last_updated AS LastUpdate,
    DATEDIFF(day, SP.last_updated, GETDATE()) AS LastUpdateDay,
    SP.rows AS 'Rows',
    SP.modification_counter AS ModificationsSinceLastUpdate 
FROM sys.stats AS S 
JOIN sys.tables AS T 
ON S.object_id = T.object_id
CROSS APPLY sys.dm_db_stats_properties(S.object_id, S.object_id) AS SP 
ORDER BY SP.modification_counter DESC;

UPDATE STATISTICS Sales.DBCustomers;

SELECT name AS statistics_name, stats_id, auto_created, user_created
FROM sys.stats
WHERE object_id = OBJECT_ID('Sales.DBCustomers')

EXEC sp_updatestats

SELECT *
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, 'LIMITED')

SELECT
    TBL.name AS TableName,
    IDX.name AS IndexName,
    S.avg_fragmentation_in_percent,
    S.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED')
AS S 
INNER JOIN sys.tables AS TBL 
ON S.object_id = TBL.object_id
INNER JOIN sys.indexes AS IDX 
ON IDX.object_id = S.object_id
ORDER BY S.avg_fragmentation_in_percent DESC 

ALTER INDEX IDX_Customers_Country ON Sales.Customers REORGANIZE

ALTER INDEX IDX_DBCUSTOMERS_LastName ON Sales.DBCustomers REBUILD