--CONCAT FIRST NAME AND COUNTRY INTO ONE COLUMN. SHOW A LIST OF CUSTOMERS FIRST 
--NAMES TOGETHER WITH THEIR COUNTRY IN ONE COLUMN

SELECT
first_name,
country,
CONCAT (first_name, ' ', country) AS name_country  
FROM customers

--TRANSFORM THE CUSTOMERS FIRST NAME TO LOWER CASE

SELECT
first_name,
country,
CONCAT (first_name, ' ', country) AS name_country,
LOWER (first_name) AS lower_name 
FROM customers

SELECT
first_name,
country,
CONCAT (first_name, ' ', country) AS name_country,
LOWER (first_name) AS lower_name, 
UPPER (first_name) AS upper_name
FROM customers

--FIND CUSTOMERS WHOSE FIRST NAME HAS LEADING OR TRAILING SPACES

SELECT 
first_name
FROM customers

SELECT
first_name
FROM customers
WHERE first_name != TRIM(first_name)

SELECT
first_name,
LEN(first_name) AS length_firstname
FROM customers

SELECT
first_name,
LEN(first_name) AS length_firstname,
LEN(TRIM(first_name)) AS length_trim_firstname
FROM customers

SELECT
first_name,
LEN(first_name) AS length_firstname,
LEN(TRIM(first_name)) AS length_trim_firstname,
LEN(first_name) - LEN(TRIM(first_name)) AS flag 
FROM customers
WHERE LEN(first_name) != LEN(TRIM(first_name))

--REMOVE DASHES (-) FROM A PHONE NUMBER

SELECT 
'123-456-7890' 

SELECT
'123-456-7890' AS phone,
REPLACE('123-456-7890', '-', '') AS clean_phone

SELECT
'123-456-7890' AS phone,
REPLACE('123-456-7890', '-', '/') AS clean_phone

--REPLACE FILE EXTENSION FROM TXT TO CSV

SELECT
'report.txt' AS old_filename,
REPLACE('report.txt', '.txt', '.csv') AS new_filename

--CALCULATE THE LENGTH OF EACH CUSTOMERS FIRST NAME

SELECT
first_name,
LEN(first_name) AS length_firstname
FROM customers

--RETRIEVE THE FIRST TWO CHARACTERS OF EACH FIRST NAME

SELECT
first_name,
LEFT(first_name, 2) AS extract_firstname
FROM customers

SELECT
first_name,
LEFT(TRIM(first_name), 2) AS extract_firstname
FROM customers

--RETRIEVE THE LAST TWO CHARACTERS OF EACH FIRST NAME

SELECT
first_name,
LEFT(TRIM(first_name), 2) AS leftextact_firstname,
RIGHT(first_name, 2) AS extract_firstname
FROM customers

/* RETRIEVE A LIST OF CUSTOMERS FIRST NAMES REMOVING THEIR FIRST CHARACTER */

SELECT
first_name,
SUBSTRING(TRIM(first_name), 2, LEN(first_name))
FROM customers