-- TABLAS DE LA SECCIÓN 3 ORACLE

SELECT last_name, department_id, salary
FROM employees
WHERE department_id > 50 AND salary > 12000;

 tabla employees
SELECT last_name, hire_date
FROM employees
WHERE hire_date > DATE '1998-01-01';

-- Se elimina location_id porque no existe en la tabla departments
SELECT department_name
FROM departments;

SELECT department_name
FROM departments;

SELECT last_name || ' ' || ROUND(salary * 1.05, 2)::numeric(10,2) AS "Employee Raise"
FROM employees
WHERE department_id IN (50, 80) AND first_name LIKE 'C%'
   OR last_name ILIKE '%s%';

SELECT last_name || ' ' || ROUND(salary * 1.05, 2)::numeric(10,2) AS "Employee Raise",
       department_id,
       first_name
FROM employees
WHERE department_id IN (50, 80)
  AND first_name LIKE 'C%'
   OR last_name ILIKE '%s%';

SELECT last_name || ' ' || ROUND(salary * 1.05, 2)::numeric(10,2) AS "Employee Raise",
       department_id,
       first_name
FROM employees
WHERE department_id IN (50, 80)
  AND first_name LIKE 'C%'
   OR last_name ILIKE '%s%';

SELECT last_name || ' ' || ROUND(salary * 1.05, 2)::numeric(10,2) AS "Employee Raise",
       department_id,
       first_name
FROM employees
WHERE (department_id IN (50, 80) OR first_name LIKE 'C%')
  AND last_name ILIKE '%s%';

SELECT last_name, hire_date
FROM employees
ORDER BY hire_date;

SELECT last_name, hire_date
FROM employees
ORDER BY hire_date DESC;

SELECT last_name, hire_date AS "Date Started"
FROM employees
ORDER BY "Date Started";

SELECT employee_id,
       first_name
FROM employees
WHERE employee_id < 105
ORDER BY last_name;

SELECT department_id, last_name
FROM employees
WHERE department_id <= 50
ORDER BY department_id,
         last_name;

SELECT department_id,
       last_name
FROM employees
WHERE department_id <= 50
ORDER BY department_id DESC,
        last_name;