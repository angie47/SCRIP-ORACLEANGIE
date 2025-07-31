--TABLAS DE LA SECCION 12 ORACLE


--ELIMINAMOS LAS TABLAS TEMPORALES SI EXISTÍAN
DROP TABLE IF EXISTS copy_employees CASCADE;
DROP TABLE IF EXISTS copy_departments CASCADE;

--CREAMOS TABLAS TEMPORALES COPIANDO LOS DATOS DE EMPLOYEES Y DEPARTMENTS
CREATE TABLE copy_employees
AS (SELECT * FROM employees);

CREATE TABLE copy_departments
AS (SELECT * FROM departments);

--CONSULTAMOS LA ESTRUCTURA DE LA TABLA COPY_EMPLOYEES
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'copy_employees'
ORDER BY ordinal_position;

--MOSTRAMOS LOS DATOS DE COPY_EMPLOYEES
SELECT * FROM copy_employees;

-- CONSULTAMOS LA ESTRUCTURA DE LA TABLA COPY_DEPARTMENTS
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'copy_departments'
ORDER BY ordinal_position;

--MOSTRAMOS LOS DATOS DE COPY_DEPARTMENTS
SELECT * FROM copy_departments;

--INSERTAMOS NUEVOS REGISTROS EN COPY_DEPARTMENTS
INSERT INTO copy_departments
(department_id, department_name, manager_id, location_id)
VALUES (200, 'Human Resources', 205, 1500);

INSERT INTO copy_departments
VALUES (210, 'Estate Management', 102, 1700);

--INSERTAMOS NUEVOS REGISTROS EN COPY_EMPLOYEES (ALGUNOS CON CAMPOS OMITIDOS)
INSERT INTO copy_employees
(employee_id, first_name, last_name, phone_number, hire_date, job_id, salary)
VALUES
(302, 'Grigorz', 'Polanski', '8586667641', '2017-06-15', 'IT_PROG', 4200);

INSERT INTO copy_employees
(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary)
VALUES
(303, 'Grigorz', 'Polanski', 'gpolanski', NULL, '2017-06-15', 'IT_PROG', 4200);

INSERT INTO copy_employees
(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary)
VALUES
(304, 'Test', CURRENT_USER, 't_user', '4159982010', CURRENT_DATE, 'ST_CLERK', 2500);

--FORMATEAMOS Y MOSTRAMOS FECHAS DE CONTRATACIÓN PARA CIERTOS EMPLEADOS
SELECT 
    first_name, 
    TO_CHAR(hire_date, 'Month, FMDD, YYYY') AS formatted_hire_date
FROM employees
WHERE employee_id = 1;

SELECT 
    first_name,
    TO_CHAR(hire_date, 'Month DD, YYYY') AS formato1,
    TO_CHAR(hire_date, 'FMMonth FMDD, YYYY') AS formato2,
    TO_CHAR(hire_date, 'Day, Month DD, YYYY') AS formato3
FROM employees
WHERE employee_id <= 3;

--MOSTRAMOS LOS DEPARTAMENTOS AGREGADOS
SELECT 'Departamentos agregados:' AS info;
SELECT * FROM copy_departments WHERE department_id >= 200;

--MOSTRAMOS LOS EMPLEADOS AGREGADOS
SELECT 'Empleados agregados:' AS info;
SELECT * FROM copy_employees WHERE employee_id >= 302;

--MOSTRAMOS INFORMACIÓN DEL USUARIO ACTUAL, FECHA Y HORA ACTUAL
SELECT 
    CURRENT_USER AS usuario_actual,
    CURRENT_DATE AS fecha_actual,
    CURRENT_TIMESTAMP AS timestamp_actual,
    NOW() AS now_postgresql;

--CONSULTAMOS LA ESTRUCTURA COMPLETA DE LA TABLA COPY_EMPLOYEES
SELECT 
    column_name,
    data_type,
    character_maximum_length,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'copy_employees'
ORDER BY ordinal_position;

--CONSULTAMOS LAS RESTRICCIONES Y CLAVES DEFINIDAS EN LAS TABLAS TEMPORALES
SELECT
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type,
    kcu.column_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu 
    ON tc.constraint_name = kcu.constraint_name
WHERE tc.table_name IN ('copy_employees', 'copy_departments')
ORDER BY tc.table_name, tc.constraint_name;
