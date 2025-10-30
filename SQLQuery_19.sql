--INSERT DATA FROM CUSTOMERS INTO PERSONS

CREATE TABLE persons
(id INT NOT NULL,
person_name VARCHAR(50) NOT NULL,
birth_date DATE,
phone VARCHAR(15) NOT NULL, 
CONSTRAINT pk_persons PRIMARY KEY (id)
)

SELECT *
FROM customers

INSERT INTO persons
(id, person_name, birth_date, phone)


SELECT 
id,
first_name,
NULL,
'Unknown'
FROM customers

SELECT *
FROM persons