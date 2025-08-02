--TABLAS DE LA SECCION 14 ORACLE

--Añadir una restriccion de clave primaria
ALTER TABLE employees
ADD CONSTRAINT emp_id_pk PRIMARY KEY (employee_id);

--Añadir una restriccion de clave foránea
ALTER TABLE employees
ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id)
REFERENCES departments (department_id) ON DELETE CASCADE;

--Añadir una restriccion NOT NULL (PostgreSQL usa ALTER COLUMN)
ALTER TABLE employees
ALTER COLUMN email SET NOT NULL;

--Eliminar una restriccion
ALTER TABLE copy_departments
DROP CONSTRAINT c_dept_dept_id_pk CASCADE;

--Clave foranea a nivel de columna
CREATE TABLE copy_employees (
  employee_id INTEGER CONSTRAINT copy_emp_pk PRIMARY KEY,
  first_name VARCHAR(20),
  last_name VARCHAR(25),
  department_id INTEGER CONSTRAINT c_emps_dept_id_fk REFERENCES departments(department_id),
  email VARCHAR(25)
);

--Clave foranea a nivel de tabla con distintas acciones de eliminación
CREATE TABLE copy_employees (
  employee_id INTEGER CONSTRAINT copy_emp_pk PRIMARY KEY,
  first_name VARCHAR(20),
  last_name VARCHAR(25),
  department_id INTEGER,
  email VARCHAR(25),
  CONSTRAINT cdept_dept_id_fk FOREIGN KEY (department_id)
  REFERENCES copy_departments(department_id) ON DELETE CASCADE
);

CREATE TABLE copy_employees (
  employee_id INTEGER CONSTRAINT copy_emp_pk PRIMARY KEY,
  first_name VARCHAR(20),
  last_name VARCHAR(25),
  department_id INTEGER,
  email VARCHAR(25),
  CONSTRAINT cdept_dept_id_fk FOREIGN KEY (department_id)
  REFERENCES copy_departments(department_id) ON DELETE SET NULL
);

SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'jobs'
ORDER BY ordinal_position;

DROP TABLE IF EXISTS my_cd_collection CASCADE;
CREATE TABLE my_cd_collection
(cd_number NUMERIC(9),
title VARCHAR(20),
artist VARCHAR(20),
purchase_date DATE DEFAULT CURRENT_DATE);

DROP TABLE IF EXISTS my_friends CASCADE;
CREATE TABLE my_friends
(first_name VARCHAR(20),
last_name VARCHAR(30),
email VARCHAR(30),
phone_num VARCHAR(12),
birth_date DATE);

--Obtiene los nombres de las tablas en el esquema público.
SELECT table_name, 'VALID' as status
FROM information_schema.tables
WHERE table_schema = 'public';

--Obtiene los nombres de los indices y las tablas a las que pertenecen.
SELECT indexname as index_name, tablename as table_name
FROM pg_indexes
WHERE schemaname = CURRENT_SCHEMA();

-- Obtiene los nombres de las secuencias en el esquema actual.
SELECT sequence_name
FROM information_schema.sequences
WHERE sequence_schema = CURRENT_SCHEMA();

--Elimina la tabla si existe y la vuelve a crear con una columna de tipo TIMESTAMP.
DROP TABLE IF EXISTS time_ex1 CASCADE;
CREATE TABLE time_ex1
(exact_time TIMESTAMP);

-- Inserta un valor de fecha y hora con microsegundos.
INSERT INTO time_ex1
VALUES ('2020-11-02 11:29:29.123456');

--Elimina la tabla si existe y la vuelve a crear con una columna de tipo TIMESTAMP WITH TIME ZONE.
DROP TABLE IF EXISTS time_ex3 CASCADE;
CREATE TABLE time_ex3
(first_column TIMESTAMP WITH TIME ZONE,
second_column TIMESTAMP WITH TIME ZONE);

--Inserta valores de fecha y hora con zona horaria.
INSERT INTO time_ex3
(first_column, second_column)
VALUES
('2017-07-15 08:00:00-07:00', '2007-11-15 08:00:00');

--Muestra un titulo de ejemplo para la sintaxis de ALTER TABLE.
SELECT 'Example ALTER TABLE syntax:' AS info;

--Muestra la sintaxis de ejemplo para agregar una columna con un valor por defecto.
SELECT 'ALTER TABLE tablename ADD COLUMN column_name data_type DEFAULT expression;' AS syntax_example;