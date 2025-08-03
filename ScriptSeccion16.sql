--TABLAS DE LA SECCION 16 ORACLE

--CREAR SECUENCIA
CREATE SEQUENCE IF NOT EXISTS runner_id_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 50000
    CACHE 1
    NO CYCLE;

--CREAR TABLA CON CLAVE PRIMARIA
CREATE TABLE IF NOT EXISTS runners (
    runner_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30)
);

--INSERTAR REGISTROS USANDO LA SECUENCIA
INSERT INTO runners (runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Joanne', 'Everely');

INSERT INTO runners (runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Adam', 'Curtis');

--CONSULTAR DATOS DE LA TABLA
SELECT runner_id, first_name, last_name FROM runners;

--INICIALIZAR SECUENCIA EN SESION Y OBTENER ULTIMO VALOR USADO
SELECT nextval('runner_id_seq');  -- NECESARIO ANTES DE CURRVAL
SELECT currval('runner_id_seq');

ALTER TABLE wf_countries ADD COLUMN region_id INT;
--CREAR INDICE DE EJEMPLO
CREATE INDEX IF NOT EXISTS wf_cont_reg_id_idx
ON wf_countries (region_id);

--CONSULTAR DATOS DE LA TABLA
SELECT runner_id, first_name, last_name
FROM runners;

SELECT nextval('runner_id_seq');  
SELECT currval('runner_id_seq'); --CONSULTAR ULTIMO VALOR USADO DE LA SECUENCIA

--INSERTAR REGISTROS USANDO LA SECUENCIA
INSERT INTO runners (runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Joanne', 'Everely');

INSERT INTO runners (runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Adam', 'Curtis');

--CONSULTAR DATOS DE LA TABLA
SELECT runner_id, first_name, last_name
FROM runners;

--CONSULTAR ULTIMO VALOR USADO DE LA SECUENCIA
SELECT currval('runner_id_seq');

--CREAR INDICES
CREATE INDEX wf_cont_reg_id_idx
ON wf_countries(region_id);

CREATE INDEX emps_name_idx
ON employees(first_name, last_name);

CREATE INDEX upper_last_name_idx
ON employees (upper(last_name));

CREATE INDEX emp_hire_year_idx
ON employees ((to_char(hire_date, 'YYYY')));

-- CONSULTAR INDICES DE UNA TABLA
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'employees';

-- CONSULTAS USANDO INDICES
SELECT *
FROM employees
WHERE upper(last_name) = 'KING';

SELECT *
FROM employees
WHERE upper(last_name) LIKE 'KIN%';

SELECT *
FROM employees
WHERE upper(last_name) IS NOT NULL
ORDER BY upper(last_name);

-- ELIMINAR INDICES
DROP INDEX IF EXISTS upper_last_name_idx;
DROP INDEX IF EXISTS emps_name_idx;
DROP INDEX IF EXISTS emp_hire_year_idx;

--SIMULAR SINONIMOS USANDO VISTAS (POSTGRES NO TIENE SINONIMOS)
CREATE TABLE amy_copy_employees AS
SELECT * FROM employees;

CREATE OR REPLACE VIEW amy_emps AS
SELECT * FROM amy_copy_employees;

DROP VIEW IF EXISTS amy_emps;