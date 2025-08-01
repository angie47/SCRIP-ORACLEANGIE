--TABLAS DE LA SECCION 13 ORACLE 

--CONSULTA LA ESTRUCTURA DE LA TABLA 'jobs'
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'jobs';

--CREA EL ESQUEMA 'mary' SI NO EXISTE
CREATE SCHEMA IF NOT EXISTS mary;

--CREA LA TABLA 'students' DENTRO DEL ESQUEMA 'mary'
CREATE TABLE mary.students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);

--INSERTA ALGUNOS DATOS DE EJEMPLO EN LA TABLA 'students'
INSERT INTO mary.students (name, email)
VALUES 
    ('Ana López', 'ana@example.com'),
    ('Luis Gómez', 'luis@example.com'),
    ('Carlos Méndez', 'carlos@example.com');

-- CONSULTA TODO EL CONTENIDO DE LA TABLA 'students' EN EL ESQUEMA 'mary'
SELECT * FROM mary.students;
SELECT * FROM mary.students;


--CREA UNA TABLA PARA UNA COLECCIÓN DE DISCOS COMPACTOS
CREATE TABLE my_cd_collection (
    cd_number INTEGER,
    title VARCHAR(20),
    artist VARCHAR(20),
    purchase_date DATE DEFAULT CURRENT_DATE
);

--CREA UNA TABLA PARA GUARDAR INFORMACIÓN DE AMIGOS
CREATE TABLE my_friends (
    first_name VARCHAR(20),
    last_name VARCHAR(30),
    email VARCHAR(30),
    phone_num VARCHAR(12),
    birth_date DATE
);

--CONSULTA LOS NOMBRES DE LAS TABLAS DEL ESQUEMA 'public'
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

--CONSULTA LOS ÍNDICES DEL ESQUEMA 'public'
SELECT * FROM pg_indexes WHERE schemaname = 'public';

--CONSULTA LOS OBJETOS DE TIPO SEQUENCE EN LA BASE DE DATOS
SELECT * 
FROM pg_class 
WHERE relkind = 'S';

--CREA UNA TABLA PARA GUARDAR FECHAS Y HORAS PRECISAS (TIMESTAMP)
CREATE TABLE time_ex1 (
    exact_time TIMESTAMP
);

--INSERTA DISTINTOS VALORES DE TIEMPO EN LA TABLA time_ex1
INSERT INTO time_ex1 VALUES ('2017-06-10 10:52:29.123456');
INSERT INTO time_ex1 VALUES (CURRENT_DATE);
INSERT INTO time_ex1 VALUES (CURRENT_TIMESTAMP);

--CONSULTA TODO EL CONTENIDO DE time_ex1
SELECT * FROM time_ex1;

--CREA UNA TABLA CON COLUMNA TIMESTAMP CON ZONA HORARIA
CREATE TABLE time_ex2 (
    time_with_offset TIMESTAMP WITH TIME ZONE
);

--INSERTA FECHAS CON ZONA HORARIA EN time_ex2
INSERT INTO time_ex2 VALUES (CURRENT_TIMESTAMP);
INSERT INTO time_ex2 VALUES ('2017-06-10 10:52:29.123456+02:00');

--CONSULTA TODO EL CONTENIDO DE time_ex2
SELECT * FROM time_ex2;

--CREA UNA TABLA CON DOS FORMATOS DE TIMESTAMP
CREATE TABLE time_ex3 (
    first_column TIMESTAMP WITH TIME ZONE,
    second_column TIMESTAMP
);

--INSERTA VALORES DE TIMESTAMP EN time_ex3
INSERT INTO time_ex3 (first_column, second_column)
VALUES ('2017-07-15 08:00:00-07:00', '2007-11-15 08:00:00');

--CONSULTA TODO EL CONTENIDO DE time_ex3
SELECT * FROM time_ex3;

-- CREA UNA TABLA CON INTERVALOS DE AÑOS Y MESES
CREATE TABLE time_ex4 (
    loan_duration1 INTERVAL,
    loan_duration2 INTERVAL
);

--INSERTA INTERVALOS EN LA TABLA time_ex4
INSERT INTO time_ex4 (loan_duration1, loan_duration2)
VALUES (INTERVAL '120 months', INTERVAL '3 years 6 months');

--MUESTRA FECHAS CALCULADAS A PARTIR DE INTERVALOS
SELECT CURRENT_DATE + loan_duration1 AS "120 months from now",
       CURRENT_DATE + loan_duration2 AS "3 years 6 months from now"
FROM time_ex4;


--CREA UNA TABLA CON INTERVALOS DE TIEMPO
CREATE TABLE time_ex5 (
    day_duration1 INTERVAL,
    day_duration2 INTERVAL
);


--CONSULTA QUE MUESTRA RESULTADOS CON INTERVALOS DE DÍAS
SELECT CURRENT_DATE + day_duration1 AS "25 Days from now",
       TO_CHAR(CURRENT_DATE + day_duration2, 'DD-Mon-YYYY HH24:MI:SS')
       AS "precise days and time from now"
FROM time_ex5;

--AGREGA UNA NUEVA COLUMNA A UNA TABLA EXISTENTE
ALTER TABLE my_cd_collection ADD COLUMN release_date DATE DEFAULT CURRENT_DATE;
ALTER TABLE my_friends ADD COLUMN favorite_game VARCHAR(30);

--CREA LA TABLA 'mod_emp' PARA LUEGO MODIFICARLA
CREATE TABLE mod_emp (
    last_name VARCHAR(20),
    salary NUMERIC(8,2)
);

-- MODIFICA LA LONGITUD Y EL TIPO DE COLUMNAS EXISTENTES
ALTER TABLE mod_emp ALTER COLUMN last_name TYPE VARCHAR(30);
ALTER TABLE mod_emp ALTER COLUMN last_name TYPE VARCHAR(10);
ALTER TABLE mod_emp ALTER COLUMN salary TYPE NUMERIC(10,2);
ALTER TABLE mod_emp ALTER COLUMN salary SET DEFAULT 50;

--ELIMINA COLUMNAS DE UNA TABLA
ALTER TABLE my_cd_collection DROP COLUMN release_date;
ALTER TABLE my_friends DROP COLUMN favorite_game;

--ELIMINA UNA TABLA SI EXISTE
DROP TABLE IF EXISTS copy_employees;
DROP TABLE IF EXISTS tablename;

--CAMBIA EL NOMBRE DE UNA TABLA
ALTER TABLE my_cd_collection RENAME TO my_music;

--ELIMINA TODO EL CONTENIDO DE UNA TABLA SIN BORRARLA
TRUNCATE TABLE tablename;

--AGREGA UN COMENTARIO A UNA TABLA
COMMENT ON TABLE employees IS 'Western Region only';

--CONSULTA LOS COMENTARIOS DE LAS TABLAS EN EL ESQUEMA 'public'
SELECT 
  c.relname AS table_name,
  obj_description(c.oid) AS comment
FROM 
  pg_class c
JOIN 
  pg_namespace n ON n.oid = c.relnamespace
WHERE 
  c.relkind = 'r'  -- SOLO TABLAS
  AND n.nspname = 'public';  -- ESQUEMA 'public'

--CONSULTA LOS COMENTARIOS DE LAS TABLAS
SELECT table_name, obj_description(oid) AS comment
FROM pg_class
WHERE relkind = 'r';

--INSERTA UN REGISTRO EN LA TABLA copy_employees
INSERT INTO copy_employees (
    employee_id, first_name, last_name, email, phone_number,
    hire_date, job_id, salary, commission_pct,
    manager_id, department_id
) VALUES (
    1, 'Natacha', 'Hansen', 'NHANSEN', '4412312341234',
    '1998-09-07', 'AD_VP', 12000, NULL, 100, 90
);

--CONCATENA NOMBRE COMPLETO Y MUESTRA SALARIO DE UN EMPLEADO
SELECT employee_id,
       first_name || ' ' || last_name AS name,
       salary
FROM copy_employees
WHERE employee_id = 1;
