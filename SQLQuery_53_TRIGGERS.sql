--==============================================
--STEP 1: CREATE TABLE 
--==============================================

CREATE TABLE Sales.EmployeeLogs 
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EMPLOYEEID INT,
    LOGMESSAGE VARCHAR(255),
    LOGDATE DATE 
)

--================================================
STEP 2: CREATE TRIGGER
--================================================

CREATE TRIGGER TRG_AFTERINSERTEMP ON Sales.Employees 
AFTER INSERT
AS 
BEGIN
    INSERT INTO Sales.EmployeeLogs (EMPLOYEEID, LOGMESSAGE, LOGDATE)
    SELECT
        EMPLOYEEID,
        'NEW EMPLOYEE ADDED =' + CAST(EMPLOYEEID AS VARCHAR),
        GETDATE()
FROM INSERTED 
END 

SELECT
*
FROM Sales.EmployeeLogs

SELECT
*
FROM Sales.Employees

--=========================================
--STEP 3: INSERT NEW DATA INTO EMPLOYEES
--=========================================

INSERT INTO Sales.Employees
VALUES
(6, 'Maria', 'Does', 'HR', '1988-01-12', 'F', 80000, 3)

INSERT INTO Sales.Employees
VALUES
(7, 'Stella', 'Does', 'HR', '1987-01-12', 'F', 70000, 3)
