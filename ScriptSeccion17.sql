--TABLAS DE LA SECCION 17 ORACLE

--CREACION DE USUARIOS Y ROLES 

--CREAR USUARIO
CREATE USER scott WITH PASSWORD 'ur35scott';
CREATE USER steven_king WITH PASSWORD 'password123';
CREATE USER jennifer_cho WITH PASSWORD 'password123';
CREATE USER scott_king WITH PASSWORD 'password123';

--CAMBIAR CONTRASEÑA DE USUARIO
ALTER USER scott WITH PASSWORD 'imscott35';

--OTORGAR PRIVILEGIOS BASICOS
GRANT CONNECT ON DATABASE pd_oracle TO scott;

--Permitir crear objetos en el esquema public
GRANT USAGE, CREATE ON SCHEMA public TO scott;

--Dar permisos para TEMPORARY tablas temporales
GRANT TEMPORARY ON DATABASE pd_oracle TO scott;

--Crear esquema y tabla de ejemplo para alice
CREATE SCHEMA IF NOT EXISTS alice;
CREATE TABLE IF NOT EXISTS alice.departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50)
);

--Crear esquema y tabla de ejemplo para jason_tsang
CREATE SCHEMA IF NOT EXISTS jason_tsang;
CREATE TABLE IF NOT EXISTS jason_tsang.clients (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

--Crear tabla clients en esquema público si no existe
CREATE TABLE IF NOT EXISTS clients (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary NUMERIC(10,2) DEFAULT 0
);

--OTORGAR SELECT A TODOS LOS USUARIOS
GRANT SELECT ON alice.departments TO PUBLIC;

--CREAR ROLES Y ASIGNARLOS
CREATE ROLE manager;
GRANT CREATE ON SCHEMA public TO manager;

--OTORGAR SELECT A TODOS LOS USUARIOS SOBRE OTRA TABLA
GRANT SELECT ON jason_tsang.clients TO PUBLIC;


--CREAR SCHEMA COMO SIMULACION DE SINONIMOS
CREATE SCHEMA IF NOT EXISTS scott_king;

-- Crear tabla dentro del esquema
CREATE TABLE IF NOT EXISTS scott_king.clients (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

--Insertar datos 
INSERT INTO scott_king.clients (first_name, last_name)
VALUES ('John', 'Doe'), ('Jane', 'Smith');

DROP VIEW IF EXISTS clients_view CASCADE;

CREATE OR REPLACE VIEW clients_view AS
SELECT * FROM scott_king.clients;

SELECT * FROM clients_view;

SELECT * FROM clients;

--CONSULTAS CON EXPRESIONES REGULARES

--BUSCAR NOMBRES SIMILARES A 'Steven' O 'Stephen'
SELECT first_name, last_name
FROM employees
WHERE first_name ~* '^Ste(v|ph)en$';

--REEMPLAZAR INICIALES H CON VARIACIONES DE VOCALES POR **
SELECT last_name, regexp_replace(last_name, '^H(a|e|i|o|u)', '', 'g') AS "Name changed"
FROM employees;

--CONTAR PATRON 'ab' EN NOMBRE DE PAISES
SELECT country_name, regexp_count(country_name, '(ab)') AS "Count of 'ab'"
FROM wf_countries
WHERE regexp_count(country_name, '(ab)') > 0;

--RESTRICCIONES DE COLUMNAS CON EXPRESIONES REGULARES
SELECT *
FROM employees
WHERE email !~ '@';

--CORREGIR DATOS INVALIDOS
UPDATE employees
SET email = LOWER(first_name || '.' || last_name || '@example.com')
WHERE email !~ '@';

--VERIFICAR QUE YA NO EXISTAN DATOS INVALIDOS
SELECT *
FROM employees
WHERE email !~ '@';

--AGREGAR LA RESTRICCION
ALTER TABLE employees
ADD CONSTRAINT email_addr_chk
CHECK (email ~ '@');

--CREAR TABLA CON RESTRICCION DE EMAIL USANDO REGEXP
CREATE TABLE my_contacts (
    first_name VARCHAR(15),
    last_name  VARCHAR(15),
    email      VARCHAR(30)
        CHECK (email ~* '.+@.+\..+')
);