--TABLAS DE LA SECCION 11 ORACLE 
--Garantia de Consultas de Calidad 

--AGREGAMOS LA COLUMNA first_name Y QUE SEA TIPO VARCHAR
ALTER TABLE employees ADD COLUMN IF NOT EXISTS first_name VARCHAR(50);

-- AGREGA LA COLUMNA commission_pct SI NO EXISTE
ALTER TABLE employees ADD COLUMN IF NOT EXISTS commission_pct NUMERIC(5,2);

-- INSERTA LOS EMPLEADOS DE LA TABLA
INSERT INTO employees (first_name, last_name, salary, commission_pct) VALUES
('S', 'King', 24000, NULL),
('N', 'Kochhar', 17000, NULL),
('L', 'De Haan', 17000, NULL),
('J', 'Whalen', 4400, NULL),
('S', 'Higgins', 12000, NULL),
('W', 'Gietz', 8300, NULL),
('E', 'Zlotkey', 10500, 0.20),
('E', 'Abel', 11000, 0.30),
('J', 'Taylor', 8600, 0.20),
('K', 'Grant', 7000, 0.15),
('K', 'Mourgos', 5800, NULL),
('T', 'Rajs', 3500, NULL),
('C', 'Davies', 3100, NULL),
('R', 'Matos', 2600, NULL),
('P', 'Vargas', 2500, NULL),
('A', 'Hunold', 9000, NULL),
('B', 'Ernst', 6000, NULL),
('D', 'Lorentz', 4200, NULL),
('M', 'Hartstein', 13000, NULL),
('P', 'Fay', 6000, NULL);


-- CONSULTA QUE MUESTRA EL NOMBRE DEL EMPLEADO, SU SALARIO Y SI TIENE COMISION O NO
-- SE MUESTRA LA PRIMERA LETRA DEL NOMBRE, SEGUIDO DEL APELLIDO COMO NOMBRE FORMATEADO
SELECT 
  SUBSTRING(first_name FROM 1 FOR 1) || ' ' || last_name AS "Employee Name",
  salary AS "Salary",
  CASE 
    WHEN commission_pct IS NULL THEN 'No'
    ELSE 'Yes'
  END AS "Commission"
FROM employees;

