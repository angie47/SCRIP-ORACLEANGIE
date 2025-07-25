--TABLAS DE LA SECCION 5 ORACLE SQL A POSTGRESQL

--Creamos la tabla employees
--Creamos una versión simplificada para este ejemplo.
DROP TABLE IF EXISTS employees; 
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(20),
    salary NUMERIC(10, 2),
    commission_pct NUMERIC(4, 2), 
    manager_id INT,
    department_id INT
);

--Insertar datos 
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES
(100, 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17', 'AD_PRES', 24000.00, NULL, NULL, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000.00, NULL, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '1993-01-13', 'AD_VP', 17000.00, NULL, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '1990-01-03', 'IT_PROG', 9000.00, NULL, 102, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '1991-05-21', 'IT_PROG', 6000.00, NULL, 103, 60),
(105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', '1997-06-25', 'IT_PROG', 4800.00, NULL, 103, 60),
(106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '1998-02-05', 'IT_PROG', 4800.00, NULL, 103, 60),
(107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '1999-02-07', 'IT_PROG', 4200.00, NULL, 103, 60),
(145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', '1996-10-01', 'SA_MAN', 14000.00, 0.40, 100, 80),
(146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', '1997-01-05', 'SA_MAN', 13500.00, 0.30, 100, 80),
(147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', '1997-03-10', 'SA_MAN', 12000.00, 0.30, 100, 80);


--Crear la tabla wf_countries
DROP TABLE IF EXISTS wf_countries; 
CREATE TABLE wf_countries (
    country_name VARCHAR(100) PRIMARY KEY,
    internet_extension VARCHAR(10),
    location VARCHAR(50)
);

--Insertar datos de ejemplo en wf_countries
INSERT INTO wf_countries (country_name, internet_extension, location) VALUES
('South Africa', '.za', 'Southern Africa'),
('Namibia', '.na', 'Southern Africa'),
('Botswana', '.bw', 'Southern Africa'),
('Zimbabwe', '.zw', 'Southern Africa'),
('Lesotho', '.ls', 'Southern Africa'),
('Egypt', '.eg', 'Northern Africa'),
('Kenya', '.ke', 'Eastern Africa');

--Conversion de fecha y numero a texto (TO_CHAR)
SELECT TO_CHAR(salary, '$99,999') AS "Salary"
FROM employees;

SELECT REPLACE('5,320', ',', '.')::NUMERIC AS "Number";

--Hacemos una conversion de texto a fecha (TO_DATE)
SELECT TO_DATE('November 3, 2001', 'Month DD, YYYY') AS "Date";

SELECT TO_DATE('May10,1989', 'MonDD,YYYY') AS "Convert";

SELECT TO_DATE('27-Oct-95', 'DD-Mon-YY') AS "Date";
SELECT TO_DATE('27-Oct-95', 'DD-Mon-RR') AS "Date";

--Filtrar empleados por fecha de contratacion
SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YY')
FROM employees
WHERE hire_date < TO_DATE('01-Jan-90', 'DD-Mon-YY');

SELECT TO_CHAR(DATE_TRUNC('week', hire_date + INTERVAL '6 months') + INTERVAL '4 days',
    'Day, Month DDth, YYYY') AS "Next Evaluation"
FROM employees
WHERE employee_id = 100;


--Manejo de valores nulos (NVL y NVL2)
--NVL se reemplaza por COALESCE para manejar nulos
SELECT country_name, COALESCE(internet_extension, 'None') AS "Internet extn"
FROM wf_countries
WHERE location = 'Southern Africa'
ORDER BY internet_extension DESC;

SELECT last_name, COALESCE(commission_pct, 0) * 250 AS "Commission"
FROM employees
WHERE department_id IN (80, 90);

SELECT last_name, salary,
    CASE
        WHEN commission_pct IS NOT NULL THEN salary + (salary * commission_pct)
        ELSE salary
    END AS income
FROM employees
WHERE department_id IN (80, 90);

SELECT first_name, LENGTH(first_name) AS "Length FN", last_name,
    LENGTH(last_name) AS "Length LN", NULLIF(LENGTH(first_name), LENGTH(last_name)) AS "Compare Them"
FROM employees;

SELECT last_name,
    COALESCE(commission_pct, salary, 10) AS "Comm"
FROM employees
ORDER BY commission_pct;

SELECT last_name,
    CASE department_id
        WHEN 90 THEN 'Management'
        WHEN 80 THEN 'Sales'
        WHEN 60 THEN 'It'
        ELSE 'Other dept.'
    END AS "Department"
FROM employees;

SELECT last_name,
    CASE department_id
        WHEN 90 THEN 'Management'
        WHEN 80 THEN 'Sales'
        WHEN 60 THEN 'It'
        ELSE 'Other dept.'
    END AS "Department"
FROM employees;