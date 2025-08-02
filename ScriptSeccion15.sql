--TABLAS DE LA SECCION 15 ORACLE 

--1.Vista de empleados (empleados del 100 al 124)
CREATE OR REPLACE VIEW view_employees AS
SELECT employee_id, first_name, last_name, email
FROM employees
WHERE employee_id BETWEEN 100 AND 124;

SELECT * FROM view_employees;

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'wf_countries';

--2.Vista de países europeos con alias
CREATE OR REPLACE VIEW view_euro_countries AS 
SELECT country_name, internet_extension, location
FROM wf_countries
WHERE location ILIKE '%Europe%';

SELECT * FROM view_euro_countries
ORDER BY country_name;

CREATE TABLE wf_world_regions(
    region_id SERIAL PRIMARY KEY,
    region_name VARCHAR(100)
);

DROP VIEW IF EXISTS view_euro_countries;

CREATE VIEW view_euro_countries AS 
SELECT country_name AS "Country",
       internet_extension AS "Internet",
       location AS "Location"
FROM wf_countries
WHERE location ILIKE '%Europe%';

SELECT * FROM view_euro_countries;

CREATE OR REPLACE VIEW view_high_pop AS
SELECT region_id       AS "Region ID",
       MAX(population) AS "Highest population"
FROM wf_countries
GROUP BY region_id;

SELECT * FROM view_high_pop;

CREATE OR REPLACE VIEW view_dept50 AS
SELECT department_id, employee_id, first_name, last_name, salary
FROM copy_employees
WHERE department_id = 50;

SELECT * FROM view_dept50;

--Ejemplo de actualizacion sobre la vista (permitido)
UPDATE view_dept50
SET department_id = 90
WHERE employee_id = 1;

CREATE OR REPLACE VIEW view_dept50 AS
SELECT department_id, employee_id, first_name, last_name, salary
FROM employees
WHERE department_id = 50
WITH CHECK OPTION;

--Intento de actualizar fuera del dept 50 generara error
UPDATE view_dept50
SET department_id = 90
WHERE employee_id = 124;

CREATE OR REPLACE VIEW view_dept50_readonly AS
SELECT department_id, employee_id, first_name, last_name, salary
FROM employees
WHERE department_id = 50;

CREATE OR REPLACE RULE view_dept50_readonly_protect AS
ON UPDATE TO view_dept50_readonly DO INSTEAD NOTHING;

CREATE OR REPLACE RULE view_dept50_readonly_protect_insert AS
ON INSERT TO view_dept50_readonly DO INSTEAD NOTHING;

CREATE OR REPLACE RULE view_dept50_readonly_protect_delete AS
ON DELETE TO view_dept50_readonly DO INSTEAD NOTHING;

DROP VIEW IF EXISTS viewname;

SELECT e.last_name,
       e.salary,
       e.department_id,
       d.maxsal
FROM employees e
JOIN (
    SELECT department_id, MAX(salary) AS maxsal
    FROM employees
    GROUP BY department_id
) d ON e.department_id = d.department_id
AND e.salary = d.maxsal;

SELECT last_name, hire_date
FROM employees
ORDER BY hire_date
LIMIT 5;

--OPCION CON NUMERACION EXPLICITA 
SELECT row_number() OVER (ORDER BY hire_date) AS "Longest employed",
       last_name,
       hire_date
FROM employees
ORDER BY hire_date
LIMIT 5;