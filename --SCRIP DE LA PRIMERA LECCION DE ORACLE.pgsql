--SCRIP DE LA PRIMERA LECCION DE ORACLE 

CREATE TABLE countries (
    country_id VARCHAR(2) PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INTEGER
);

INSERT INTO countries (country_id, country_name, region_id) VALUES
('CA', 'Canada', 2),
('DE', 'Germany', 1),
('UK', 'United Kingdom', 1),
('US', 'United States of America', 2);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary INTEGER
);

INSERT INTO employees (id, first_name, last_name, salary) VALUES
(10, 'John', 'Doe', 4000),
(20, 'Jane', 'Jones', 3000),
(30, 'Sylvia', 'Smith', 5000),
(40, 'Hai', 'Nguyen', 6000);

SELECT salary
FROM employees
WHERE last_name LIKE 'Smith';

CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY,
    city VARCHAR(50),
    state_province VARCHAR(50)
);

INSERT INTO locations (location_id, city, state_province) VALUES
(1800, 'Toronto', 'Ontario'),
(2500, 'Oxford', 'Oxford'),
(1400, 'Southlake', 'Texas'),
(1500, 'South San Francisco', 'California'),
(1700, 'Seattle', 'Washington');

SELECT location_id, city, state_province
FROM locations;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    last_name VARCHAR(50),
    salary INTEGER
);

INSERT INTO employees (last_name, salary) VALUES
('King', 24000),
('Kochhar', 17000),
('De Haan', 17000),
('Whalen', 4400),
('Higgins', 12000),
('Gietz', 8300),
('Zlotkey', 10500),
('Abel', 11000),
('Taylor', 8600),
('Grant', 7000);

-- Consulta para mostrar salario original y salario con aumento de 300
SELECT last_name, salary, salary + 300 AS "SALARY+300"
FROM employees;

SELECT last_name, salary, 12 * salary + 100 AS "12*SALARY+100"
FROM employees;

SELECT last_name, salary, 12 * (salary + 100) AS "12*(SALARY+100)"
FROM employees;

CREATE TABLE employees (
    last_name VARCHAR(50),
    job_id VARCHAR(20),
    salary INTEGER,
    commission_pct NUMERIC(4,2)
);


INSERT INTO employees (last_name, job_id, salary, commission_pct) VALUES
('King', 'AD_PRES', 24000, NULL),
('Kochhar', 'AD_VP', 17000, NULL),
('De Haan', 'AD_VP', 17000, NULL),
('Whalen', 'AD_ASST', 4400, NULL),
('Higgins', 'AC_MGR', 12000, NULL),
('Gietz', 'AC_ACCOUNT', 8300, NULL),
('Zlotkey', 'SA_MAN', 10500, 0.2),
('Abel', 'SA_REP', 11000, 0.3);

--ELIMINAMOS LAS TABLAS EXISTENTE
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    last_name VARCHAR(50),
    job_id VARCHAR(20),
    salary INTEGER,
    commission_pct NUMERIC(4,2)
);

INSERT INTO employees (last_name, job_id, salary, commission_pct) VALUES
('King', 'AD_PRES', 24000, NULL),
('Kochhar', 'AD_VP', 17000, NULL),
('De Haan', 'AD_VP', 17000, NULL),
('Whalen', 'AD_ASST', 4400, NULL),
('Higgins', 'AC_MGR', 12000, NULL),
('Gietz', 'AC_ACCOUNT', 8300, NULL),
('Zlotkey', 'SA_MAN', 10500, 0.2),
('Abel', 'SA_REP', 11000, 0.3),
('Taylor', 'SA_REP', 8600, 0.2);


-- Consulta para ver los valores que hay nulos en la tabla
--y el resultado de multiplicar sueldo por comisión
SELECT last_name, job_id, salary, commission_pct, salary * commission_pct AS "SALARY*COMMISSION_PCT"
FROM employees;

-- Ejemplo 1: Alias usando AS
SELECT last_name AS name, commission_pct AS comm
FROM employees;

-- Ejemplo 2: Alias usando comillas dobles (sin AS)
SELECT last_name "Name", salary * 12 "Annual Salary"
FROM employees;
