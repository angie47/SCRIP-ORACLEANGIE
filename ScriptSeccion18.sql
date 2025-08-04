--TABLAS DE LA SECCION 18 ORACLE

--Primero verificaT si los datos están
SELECT * FROM copy_departments;

--BLOQUE COMPLETO
BEGIN;

--Insertar datos base 
INSERT INTO copy_departments (department_id, department_name, manager_id, location_id)
VALUES (60, 'IT', 100, 1700),
       (90, 'HR', 200, 1800),
       (130, 'Estate Management', 102, 1500);

--Consistencia de lectura y lock
SELECT * FROM copy_departments
WHERE department_id = 60
FOR UPDATE;

--Actualizar manager
UPDATE copy_departments
SET manager_id = 101
WHERE department_id = 60;

--SAVEPOINT
SAVEPOINT uno;

--Simulamos un cambio incorrecto
UPDATE copy_departments
SET department_id = 140;

--ROLLBACK parcial
ROLLBACK TO SAVEPOINT uno;

--Confirmamos la transacción
COMMIT;
