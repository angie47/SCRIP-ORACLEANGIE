--TABLAS DE LA SECCION 9 ORACLE

--AGRUPACIONES Y AGREGACIONES 

--PROMEDIO DE SALARIOS POR DEPARTAMENTO
SELECT department_id, AVG(salary) AS salario_promedio
FROM employees
GROUP BY department_id
ORDER BY department_id;

--SALARIO MAXIMO POR DEPARTAMENTO 
SELECT MAX(salary) AS salario_maximo
FROM employees
GROUP BY department_id
ORDER BY MAX(salary) DESC;

--SALARIO MAXIMO POR DEPARTAMENTO
SELECT department_id, MAX(salary) AS salario_maximo
FROM employees
GROUP BY department_id
ORDER BY department_id;

--UBICACIONES 

--EMPLEADOS QUE HAY POR CIUDAD
SELECT l.city, COUNT(e.employee_id) AS total_empleados
FROM locations l
LEFT JOIN departments d ON l.location_id = d.location_id
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city
ORDER BY l.city;

--DEPARTAMENTOS POR CIUDAD
SELECT l.city, COUNT(d.department_id) AS total_departamentos
FROM locations l
LEFT JOIN departments d ON l.location_id = d.location_id
GROUP BY l.city
ORDER BY l.city;

--TIPOS DE TRABAJO POR CIUDAD
SELECT l.city, COUNT(DISTINCT e.job_id) AS "Tipos de trabajo"
FROM locations l
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city
ORDER BY l.city;

--EMPLEADOS POR DEPARTAMENTO Y TRABAJO
SELECT department_id, job_id, COUNT(*) AS total_empleados
FROM employees
WHERE department_id > 5
GROUP BY department_id, job_id
ORDER BY department_id, job_id;

--HAVING 

--DEPARTAMENTOS CON MAS DE 1 EMPLEADO
SELECT department_id, COUNT(*) AS total_empleados
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING COUNT(*) > 1
ORDER BY department_id;

--DEPARTAMENTOS CON SALARIO PROMEDIO MAYOR A 8000
SELECT department_id, AVG(salary) AS salario_promedio
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING AVG(salary) > 8000
ORDER BY salario_promedio DESC;

--MUESTRA CANTIDAD DE EMPLEADOS, SALARIO PROMEDIO, MAXIMO, MINIMO Y MASA SALARIAL
--SOLO INCLUYE DEPARTAMENTOS CON AL MENOS 2 EMPLEADOS
SELECT department_id,
       COUNT(*) AS total_empleados,
       AVG(salary) AS salario_promedio,
       MAX(salary) AS salario_maximo,
       MIN(salary) AS salario_minimo,
       SUM(salary) AS masa_salarial
FROM employees
WHERE department_id IS NOT NULL AND salary IS NOT NULL
GROUP BY department_id
HAVING COUNT(*) >= 2
ORDER BY salario_promedio DESC;

--TIPOS DE TRABAJO
--MUESTRA CANTIDAD DE EMPLEADOS, SALARIO PROMEDIO Y SALARIO MAXIMO
--SOLO INCLUYE TRABAJOS CON MAS DE 1 EMPLEADO Y SALARIO MAYOR A 5000
SELECT job_id,
       COUNT(*) AS cantidad_empleados,
       ROUND(AVG(salary), 2) AS salario_promedio,
       MAX(salary) AS salario_maximo
FROM employees
WHERE job_id IS NOT NULL AND salary > 5000
GROUP BY job_id
HAVING COUNT(*) > 1
ORDER BY salario_promedio DESC;

--SUBCONSULTA CON GROUP BY 
SELECT department_id, AVG(salary) AS salario_promedio_depto
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees)
ORDER BY salario_promedio_depto DESC;


SELECT CASE 
         WHEN salary < 5000 THEN 'BAJO (< 5000)'
         WHEN salary BETWEEN 5000 AND 10000 THEN 'MEDIO (5000-10000)'
         WHEN salary > 10000 THEN 'ALTO (> 10000)'
         ELSE 'SIN DATOS'
       END AS rango_salarial,
       COUNT(*) AS cantidad_empleados,
       AVG(salary) AS promedio_en_rango
FROM employees
WHERE salary IS NOT NULL
GROUP BY CASE 
            WHEN salary < 5000 THEN 'BAJO (< 5000)'
            WHEN salary BETWEEN 5000 AND 10000 THEN 'MEDIO (5000-10000)'
            WHEN salary > 10000 THEN 'ALTO (> 10000)'
            ELSE 'SIN DATOS'
         END
ORDER BY promedio_en_rango;

SELECT 
    COUNT(*) AS total_empleados,
    COUNT(DISTINCT department_id) AS departamentos_activos,
    COUNT(DISTINCT job_id) AS tipos_trabajo,
    ROUND(AVG(salary), 2) AS salario_promedio_empresa,
    MAX(salary) AS salario_maximo_empresa,
    MIN(salary) AS salario_minimo_empresa
FROM employees;

SELECT 
    department_id,
    COUNT(*) AS empleados,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees), 2) AS porcentaje
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY empleados DESC;


