SELECT
FORMAT(OrderDate, 'MMM yy') AS OrderDate,  
Count(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM yy') 

/* ==============================================================================
   DATE FORMAT SPECIFIERS
===============================================================================*/

SELECT 
    'D' AS FormatType, 
    FORMAT(GETDATE(), 'D') AS FormattedValue,
    'Full date pattern' AS Description
UNION ALL
SELECT 
    'd', 
    FORMAT(GETDATE(), 'd'), 
    'Short date pattern'
UNION ALL
SELECT 
    'dd', 
    FORMAT(GETDATE(), 'dd'), 
    'Day of month with leading zero'
UNION ALL
SELECT 
    'ddd', 
    FORMAT(GETDATE(), 'ddd'), 
    'Abbreviated name of day'
UNION ALL
SELECT 
    'dddd', 
    FORMAT(GETDATE(), 'dddd'), 
    'Full name of day'
UNION ALL
SELECT 
    'M', 
    FORMAT(GETDATE(), 'M'), 
    'Month without leading zero'
UNION ALL
SELECT 
    'MM', 
    FORMAT(GETDATE(), 'MM'), 
    'Month with leading zero'
UNION ALL
SELECT 
    'MMM', 
    FORMAT(GETDATE(), 'MMM'), 
    'Abbreviated name of month'
UNION ALL
SELECT 
    'MMMM', 
    FORMAT(GETDATE(), 'MMMM'), 
    'Full name of month'
UNION ALL
SELECT 
    'yy', 
    FORMAT(GETDATE(), 'yy'), 
    'Two-digit year'
UNION ALL
SELECT 
    'yyyy', 
    FORMAT(GETDATE(), 'yyyy'), 
    'Four-digit year'
UNION ALL
SELECT 
    'hh', 
    FORMAT(GETDATE(), 'hh'), 
    'Hour in 12-hour clock with leading zero'
UNION ALL
SELECT 
    'HH', 
    FORMAT(GETDATE(), 'HH'), 
    'Hour in 24-hour clock with leading zero'
UNION ALL
SELECT 
    'm', 
    FORMAT(GETDATE(), 'm'), 
    'Minutes without leading zero'
UNION ALL
SELECT 
    'mm', 
    FORMAT(GETDATE(), 'mm'), 
    'Minutes with leading zero'
UNION ALL
SELECT 
    's', 
    FORMAT(GETDATE(), 's'), 
    'Seconds without leading zero'
UNION ALL
SELECT 
    'ss', 
    FORMAT(GETDATE(), 'ss'), 
    'Seconds with leading zero'
UNION ALL
SELECT 
    'f', 
    FORMAT(GETDATE(), 'f'), 
    'Tenths of a second'
UNION ALL
SELECT 
    'ff', 
    FORMAT(GETDATE(), 'ff'), 
    'Hundredths of a second'
UNION ALL
SELECT 
    'fff', 
    FORMAT(GETDATE(), 'fff'), 
    'Milliseconds'
UNION ALL
SELECT 
    'T', 
    FORMAT(GETDATE(), 'T'), 
    'Full AM/PM designator'
UNION ALL
SELECT 
    't', 
    FORMAT(GETDATE(), 't'), 
    'Single character AM/PM designator'
UNION ALL
SELECT 
    'tt', 
    FORMAT(GETDATE(), 'tt'), 
    'Two character AM/PM designator';
/* ==============================================================================
   NUMERIC FORMAT SPECIFIERS
===============================================================================*/

SELECT 'N' AS FormatType, FORMAT(1234.56, 'N') AS FormattedValue
UNION ALL
SELECT 'P' AS FormatType, FORMAT(1234.56, 'P') AS FormattedValue
UNION ALL
SELECT 'C' AS FormatType, FORMAT(1234.56, 'C') AS FormattedValue
UNION ALL
SELECT 'E' AS FormatType, FORMAT(1234.56, 'E') AS FormattedValue
UNION ALL
SELECT 'F' AS FormatType, FORMAT(1234.56, 'F') AS FormattedValue
UNION ALL
SELECT 'N0' AS FormatType, FORMAT(1234.56, 'N0') AS FormattedValue
UNION ALL
SELECT 'N1' AS FormatType, FORMAT(1234.56, 'N1') AS FormattedValue
UNION ALL
SELECT 'N2' AS FormatType, FORMAT(1234.56, 'N2') AS FormattedValue
UNION ALL
SELECT 'N_de-DE' AS FormatType, FORMAT(1234.56, 'N', 'de-DE') AS FormattedValue
UNION ALL
SELECT 'N_en-US' AS FormatType, FORMAT(1234.56, 'N', 'en-US') AS FormattedValue;

SELECT
FORMAT(GETDATE(), 'T')

SELECT
CONVERT(INT, '123') AS STRING_VALUETOINTCONV,  
CONVERT(DATE, '2025-08-20') AS STRING_VALUETODATECONV,
CreationTime,
CONVERT(DATE, CreationTime) AS DATETIMETODATECONV
FROM Sales.Orders

SELECT
CreationTime,
CONVERT(DATE, CreationTime) AS DATETIMETODATECONV,
CONVERT(VARCHAR, CreationTime, 32) AS USASTDSTYLE32,
CONVERT(VARCHAR, CreationTime, 34) AS EUROSTDSTYLE34  
FROM Sales.Orders

/* ==============================================================================
   CULTURE CODE FORMATTING USING FORMAT()
===============================================================================*/

SELECT 
    'en-US' AS CultureCode,
    FORMAT(1234567.89, 'N', 'en-US') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'en-US') AS FormattedDate
UNION ALL
SELECT 
    'en-GB' AS CultureCode,
    FORMAT(1234567.89, 'N', 'en-GB') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'en-GB') AS FormattedDate
UNION ALL
SELECT 
    'fr-FR' AS CultureCode,
    FORMAT(1234567.89, 'N', 'fr-FR') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'fr-FR') AS FormattedDate
UNION ALL
SELECT 
    'de-DE' AS CultureCode,
    FORMAT(1234567.89, 'N', 'de-DE') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'de-DE') AS FormattedDate
UNION ALL
SELECT 
    'es-ES' AS CultureCode,
    FORMAT(1234567.89, 'N', 'es-ES') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'es-ES') AS FormattedDate
UNION ALL
SELECT 
    'zh-CN' AS CultureCode,
    FORMAT(1234567.89, 'N', 'zh-CN') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'zh-CN') AS FormattedDate
UNION ALL
SELECT 
    'ja-JP' AS CultureCode,
    FORMAT(1234567.89, 'N', 'ja-JP') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'ja-JP') AS FormattedDate
UNION ALL
SELECT 
    'ko-KR' AS CultureCode,
    FORMAT(1234567.89, 'N', 'ko-KR') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'ko-KR') AS FormattedDate
UNION ALL
SELECT 
    'pt-BR' AS CultureCode,
    FORMAT(1234567.89, 'N', 'pt-BR') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'pt-BR') AS FormattedDate
UNION ALL
SELECT 
    'it-IT' AS CultureCode,
    FORMAT(1234567.89, 'N', 'it-IT') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'it-IT') AS FormattedDate
UNION ALL
SELECT 
    'nl-NL' AS CultureCode,
    FORMAT(1234567.89, 'N', 'nl-NL') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'nl-NL') AS FormattedDate
UNION ALL
SELECT 
    'ru-RU' AS CultureCode,
    FORMAT(1234567.89, 'N', 'ru-RU') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'ru-RU') AS FormattedDate
UNION ALL
SELECT 
    'ar-SA' AS CultureCode,
    FORMAT(1234567.89, 'N', 'ar-SA') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'ar-SA') AS FormattedDate
UNION ALL
SELECT 
    'el-GR' AS CultureCode,
    FORMAT(1234567.89, 'N', 'el-GR') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'el-GR') AS FormattedDate
UNION ALL
SELECT 
    'tr-TR' AS CultureCode,
    FORMAT(1234567.89, 'N', 'tr-TR') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'tr-TR') AS FormattedDate
UNION ALL
SELECT 
    'he-IL' AS CultureCode,
    FORMAT(1234567.89, 'N', 'he-IL') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'he-IL') AS FormattedDate
UNION ALL
SELECT 
    'hi-IN' AS CultureCode,
    FORMAT(1234567.89, 'N', 'hi-IN') AS FormattedNumber,
    FORMAT(GETDATE(), 'D', 'hi-IN') AS FormattedDate;

SELECT
CAST('123' AS INT) AS STRINGTOINT,
CAST(123 AS VARCHAR) AS INTTOSTRING,
CAST('2025-08-20' AS DATE) AS STRINGTODATE,
CAST('2025-08-20' AS DATETIME) AS STRINGTODATETIME,
CreationTime,
CAST(CreationTime AS DATE) AS DATETIMETODATE 
FROM Sales.Orders 