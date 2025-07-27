--TABLAS DE LA SECCION 8 ORACLE 

--CONSULTAS ADAPTADAS A POSTGRES 
--EL SALARIO MAXIMO DE TODOS LOS EMPLEADOS 
SELECT MAX(salary)
FROM employees;

--EMPLEADOS CON EL SALARIO MINIMO
SELECT last_name
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

--MAXIMO SALARIO, MINIMO SALARIO Y EL MENOR SALARIO Y EL MENOR employee_id EN EL DEPARTAMENTO 60
SELECT MAX(salary), MIN(salary), MIN(employee_id)
FROM employees
WHERE department_id = 60;

--CONTAR TODOS LOS job_id 
SELECT COUNT(job_id)
FROM employees;

--LISTAR TODOS LOS job_id
SELECT job_id
FROM employees;

--Job_id UNICOS
SELECT DISTINCT job_id
FROM employees;

--COMBINACION UNICA DE job_id y department_id
SELECT DISTINCT job_id, department_id
FROM employees;

--SUMA DE SALARIOS PARA EL DEPARTAMENTI 90 
SELECT SUM(salary)
FROM employees
WHERE department_id = 90;

--SUMA DE SALARIOS DISTINTOS EN EL DEPARTAMENTO 90 
SELECT SUM(DISTINCT salary)
FROM employees
WHERE department_id = 90;

--CONTAR job_id UNICOS
SELECT COUNT(DISTINCT job_id)
FROM employees;

--CONTAR SALARIOS UNICOS
SELECT COUNT(DISTINCT salary)
FROM employees;


--CONSULTAS SQL QUE ADAPTAMOS DE LA SECCION 8 ORACLE

SELECT MAX(salary)
FROM employees;

SELECT MAX(salary)
FROM employees;

SELECT column,
group_function(column),
..
FROM table
WHERE condition
GROUP BY column;

SELECT last_name, first_name
FROM employees
WHERE salary = MIN(salary);

SELECT AVG(commission_pct)
FROM employees;

SELECT MAX(salary), MIN(salary), MIN(employee_id)
FROM employees
WHERE department_id = 60;

SELECT COUNT(job_id)
FROM employees;

SELECT commission_pct
FROM employees;

SELECT COUNT(commission_pct)
FROM employees;

SELECT COUNT(*)
FROM employees
WHERE hire_date < '01-Jan-1996';

SELECT COUNT(*)
FROM employees
WHERE hire_date < '01-Jan-1996';

SELECT job_id
FROM employees;

SELECT DISTINCT job_id
FROM employees;

SELECT DISTINCT job_id,
department_id
FROM employees;

SELECT DISTINCT job_id,
department_id
FROM employees;

SELECT SUM(salary)
FROM employees
WHERE department_id = 90;

SELECT SUM(DISTINCT salary)
FROM employees
WHERE department_id = 90;

SELECT COUNT (DISTINCT
job_id)
FROM employees;

SELECT COUNT (DISTINCT salary)
FROM employees;

SELECT AVG(NVL(customer_orders, 0))

SELECT AVG(commission_pct)
FROM employees;

SELECT AVG(NVL(commission_pct, 0))
FROM employees;

SELECT AVG(commission_pct)
FROM employees;

SELECT AVG(NVL(commission_pct, 0))
FROM employees;


