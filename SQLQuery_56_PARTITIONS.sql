--STEP 1: CREATE A PARTITION FUNCTION

CREATE PARTITION FUNCTION PARTITION_BY_YEAR (DATE)
AS RANGE LEFT FOR VALUES ('2023-12-31', '2024-12-31', '2025-12-31')



--QUERY LISTS ALL EXISTING PARTITION FUNCTIONS

SELECT
    name,
    function_id,
    type,
    type_desc,
    boundary_value_on_right
FROM sys.partition_functions

--STEP 2: CREATE FILE GROUPS

USE SalesDB

ALTER DATABASE SalesDB  ADD FILEGROUP FG_2023;
ALTER DATABASE SalesDB  ADD FILEGROUP FG_2024;
ALTER DATABASE SalesDB  ADD FILEGROUP FG_2025;
ALTER DATABASE SalesDB  ADD FILEGROUP FG_2026;

ALTER DATABASE SalesDB  REMOVE FILEGROUP FG_2023;

--QUERY LISTS ALL EXISTING FILEGROUPS

SELECT
*
FROM sys.filegroups
WHERE type = 'FG'

--STEP 3: ADD .NDF FILES TO EACH FILEGROUP

ALTER DATABASE SalesDB ADD FILE
(
    NAME = P_2023, --LOGICAL NAME
    FILENAME = '/Users/ajitnair/Documents/BARAA SELKINI/P_2023.ndf'
 ) TO FILEGROUP FG_2023;

 ALTER DATABASE SalesDB ADD FILE
(
    NAME = P_2024, --LOGICAL NAME
    FILENAME = '/Users/ajitnair/Documents/BARAA SELKINI/P_2024.ndf'
 ) TO FILEGROUP FG_2024;

 ALTER DATABASE SalesDB ADD FILE
(
    NAME = P_2025, --LOGICAL NAME
    FILENAME = '/Users/ajitnair/Documents/BARAA SELKINI/P_2025.ndf'
 ) TO FILEGROUP FG_2025;

 ALTER DATABASE SalesDB ADD FILE
(
    NAME = P_2026, --LOGICAL NAME
    FILENAME = '/Users/ajitnair/Documents/BARAA SELKINI/P_2026.ndf'
 ) TO FILEGROUP FG_2026;

 SELECT
    fg.name AS FilegroupName,
    mf.name AS LogicalFileName,
    mf.physical_name AS PhysicalFilePath,
    mf.size / 128 AS SizeInMB
FROM 
    sys.filegroups AS fg 
JOIN 
    sys.master_files AS mf ON fg.data_space_id = mf.data_space_id
WHERE
    mf.database_id = DB_ID('SalesDB');

Use AdventureWorksDW2019
Use SalesDB

--STEP 4: CREATE PARTITION SCHEME


CREATE PARTITION SCHEME SchemePartitionByYear
AS PARTITION PARTITION_BY_YEAR
TO (FG_2023, FG_2024, FG_2025, FG_2026) 

SELECT * FROM sys.partition_functions

--QUERY LISTS ALL PARTITION SCHEMES

SELECT
    PS.NAME AS PARTITION_SCHEME_NAME,
    PF.NAME AS PARTITION_FUNCTION_NAME,
    DS.DESTINATION_ID AS PARTITION_NUMBER,
    FG.NAME AS FILE_GROUP_NAME
FROM sys.partition_schemes AS PS 
JOIN sys.partition_functions AS PF ON PS.function_id = PF.function_id
JOIN sys.destination_data_spaces AS DS ON PS.data_space_id = 
DS.partition_scheme_id
JOIN sys.filegroups AS FG ON DS.data_space_id = FG.data_space_id

--STEP 5: CREATE PARTITIONED TABLE

CREATE TABLE Sales.Orders_Partitioned
(
    OrderID INT, 
    OrderDate DATE,
    Sales INT 
) ON SchemePartitionByYear(OrderDate)

--STEP 6: INSERT DATA INTO THE PARTITIONED TABLE

INSERT INTO Sales.Orders_Partitioned VALUES 
(1, '2023-05-15', 100);

SELECT * FROM Sales.Orders_Partitioned

SELECT 
    p.partition_number AS PartitionNumber, 
    f.name AS PartitionFilegroup,
    p.rows AS NumberOfRows
FROM sys.partitions p  
JOIN sys.destination_data_spaces dds ON p.partition_number = 
dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(p.object_id) = 'Orders_Partitioned';

INSERT INTO Sales.Orders_Partitioned VALUES 
(2, '2024-07-25', 50);

INSERT INTO Sales.Orders_Partitioned VALUES 
(3, '2025-12-31', 20);

INSERT INTO Sales.Orders_Partitioned VALUES 
(4, '2026-01-01', 100);

SELECT *
INTO Sales.Orders_NoPartition   
FROM Sales.Orders_Partitioned

SELECT *
FROM Sales.Orders_NoPartition   
WHERE OrderDate = '2026-01-01'


SELECT *
FROM Sales.Orders_Partitioned  
WHERE OrderDate = '2026-01-01'


SELECT *
FROM Sales.Orders_Partitioned  
WHERE OrderDate IN ('2026-01-01', '2025-12-31') 

SELECT *
FROM Sales.Orders_NoPartition
WHERE OrderDate IN ('2026-01-01', '2025-12-31') 