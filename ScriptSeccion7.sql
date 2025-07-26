--TABLAS DE LA SECCION 7 ORACLE

--CODIGO PARA RE-CREAR LAS TABLAS EN POSTGRESQL CON NOMBRES DE COLUMNA CORREGIDOS 
--PARA EVITAR EL ERROR DE SINTAXIS, RENNOMBRE , 'column' A 'descripcion_columna'

DROP TABLE IF EXISTS table1 CASCADE;
DROP TABLE IF EXISTS table2 CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS jobs CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS locations CASCADE;
DROP TABLE IF EXISTS job_grades CASCADE;

--CREACION CON LA TABLA CON LA NUEVA COLUMNA
CREATE TABLE table1 (
    id_t1 SERIAL PRIMARY KEY,
    column1 INT,
    descripcion_columna TEXT 
);

--CREACION DE LA TABLE2 CON LA COLUMNA RENOMBRADA 
CREATE TABLE table2 (
    id_t2 SERIAL PRIMARY KEY,
    column2 INT,
    descripcion_columna TEXT 
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    job_id INT,
    department_id INT,
    salary NUMERIC(10, 2)
);

CREATE TABLE jobs (
    job_id SERIAL PRIMARY KEY,
    job_title VARCHAR(50) NOT NULL
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location_id INT
);

CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE job_grades (
    grade_level VARCHAR(10) PRIMARY KEY,
    lowest_sal NUMERIC(10, 2),
    highest_sal NUMERIC(10, 2)
);


INSERT INTO table1 (column1, descripcion_columna) VALUES 
(1, 'Dato A de T1'),
(2, 'Dato B de T1'),
(3, 'Dato C de T1'),
(5, 'Dato E de T1');

INSERT INTO table2 (column2, descripcion_columna) VALUES
(1, 'Dato X de T2'),
(2, 'Dato Y de T2'),
(4, 'Dato Z de T2'),
(6, 'Dato W de T2');

INSERT INTO employees (last_name, job_id, department_id, salary) VALUES
('Gomez', 1, 10, 50000),
('Perez', 2, 20, 60000),
('Lopez', 1, 10, 55000),
('Diaz', 3, NULL, 45000),
('Rodriguez', 1, 80, 70000),
('Sanchez', 4, 10, 80000);

INSERT INTO departments (department_id, department_name, location_id) VALUES
(10, 'Ventas', 100),
(20, 'Marketing', 200),
(30, 'IT', 100),
(40, 'Recursos Humanos', NULL),
(50, 'Finanzas', 300);

INSERT INTO jobs (job_id, job_title) VALUES
(1, 'Gerente'),
(2, 'Analista'),
(3, 'Asistente');

INSERT INTO locations (location_id, city) VALUES
(100, 'Tegucigalpa'),
(200, 'San Pedro Sula'),
(300, 'La Ceiba');

INSERT INTO job_grades (grade_level, lowest_sal, highest_sal) VALUES
('A', 40000, 55000),
('B', 55001, 70000),
('C', 70001, 90000);

--CONSULTAS SQL ADAPTADAS A POSTGREST

--CONSULTA:INNER JOIN BASICO
SELECT t1.descripcion_columna, t2.descripcion_columna 
FROM table1 t1
INNER JOIN table2 t2 ON t1.column1 = t2.column2;

--CONSULTA INNER JOIN BASICO
SELECT t1.descripcion_columna, t2.descripcion_columna 
FROM table1 t1
INNER JOIN table2 t2 ON t1.column1 = t2.column2;

--CONSULTA INNER JOIN BASICO
SELECT t1.descripcion_columna, t2.descripcion_columna 
FROM table1 t1
INNER JOIN table2 t2 ON t1.column1 = t2.column2;

--CONSULTA NUMERO 4
SELECT e.last_name, e.job_id, j.job_title
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id;

--CONSULTA NUMERO 5
SELECT e.last_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

--CONSULTA NUMERO 6
SELECT e.last_name, e.job_id, j.job_title
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
WHERE e.department_id = 80;

--CONSULTA NUMERO 7
SELECT e.last_name, e.job_id, j.job_title
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
WHERE e.department_id = 80;

--CONSULTA NUMERO 8
SELECT e.last_name, d.department_name
FROM employees e
CROSS JOIN departments d;

--CONSULTA NUMERO 9
SELECT e.last_name, e.job_id, j.job_title
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
WHERE e.department_id = 80;

--CONSULTA NUMERO 10 INNER JOIN MULTIPLE
SELECT e.last_name, l.city
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id;

--CONSULTA NUMER0 11: INNER JOIN CON CONDITION
SELECT e.last_name, e.salary, jg.grade_level, jg.lowest_sal,
jg.highest_sal
FROM employees e
INNER JOIN job_grades jg ON e.salary BETWEEN jg.lowest_sal AND jg.highest_sal;

--CONSULTA NUMERO 12 SELECT e.last_name,
d.department_id,
d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

--CONSULTA NUMERO 13 RIGHT JOIN 
SELECT e.last_name,
d.department_id,
d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

--CONSULTA NUMERO 14 FULL OUTER JOIN 
SELECT e.last_name, d.department_id, d.department_name
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.department_id;

--CONSULTA NUMERO 15
SELECT t1.descripcion_columna, t2.descripcion_columna 
FROM table1 t1
LEFT JOIN table2 t2 ON t1.descripcion_columna = t2.descripcion_columna; 

--CONSULTA NUMERO 16
SELECT t1.descripcion_columna, t2.descripcion_columna 
FROM table1 t1
RIGHT JOIN table2 t2 ON t1.descripcion_columna = t2.descripcion_columna; 

--CONSULTA NUMERO 17 FULL OUTER JOIN 
SELECT t1.descripcion_columna, t2.descripcion_columna 
FROM table1 t1
FULL OUTER JOIN table2 t2 ON t1.descripcion_columna = t2.descripcion_columna; 