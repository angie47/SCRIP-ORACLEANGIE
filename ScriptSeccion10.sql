--TABLAS DE LA SECCION 10 0RACLE

--COMANDOS ADAPTADOS A POSTGREST

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > (
    SELECT hire_date
    FROM employees
    WHERE last_name = 'Vargas'
);

--EMPLEADOS EN EL MISMO DEPARTAMENTO QUE 'Grant'
SELECT last_name
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    WHERE last_name = 'Grant'
);

--EMPLEADOS EN EL DEPARTAMENTO DE MARKETING
SELECT last_name, job_id, department_id
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM departments
    WHERE department_name = 'Marketing'
)
ORDER BY job_id;

--EMPLEADOS CON MISMO job_id Y DEPARTAMENTO UBICADO EN LOCATION 1500
SELECT last_name, job_id, salary, department_id
FROM employees
WHERE job_id = (
    SELECT job_id
    FROM employees
    WHERE employee_id = 141
)
AND department_id = (
    SELECT department_id
    FROM departments
    WHERE location_id = 1500
);

--EMPLEADOS QUE TIENEN MENOS SALARIO AL PROMEDIO
SELECT last_name, salary
FROM employees
WHERE salary < (
    SELECT AVG(salary)
    FROM employees
);

--DEPARTAMENTOS DONDE EL SALARIO MINIMO ES MAYOR AL DEPTO 50
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
    SELECT MIN(salary)
    FROM employees
    WHERE department_id = 50
);

--EMPLEADOS CON SALARIO IGUAL AL ALGUNO DEL DEPTO 20
SELECT first_name, last_name
FROM employees
WHERE salary = (
    SELECT salary
    FROM employees
    WHERE department_id = 20
    LIMIT 1
);

--LOS CONTRATADOS EN EL MISMO AÑO QUE LOS DEL DEPTO 90 
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN (
    SELECT EXTRACT(YEAR FROM hire_date)
    FROM employees
    WHERE department_id = 90
);

--EMPLEADOS CONTRATADOS ANTES QUE CUALQUIERA DEL DEPARTAMENTO 90
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ANY (
    SELECT EXTRACT(YEAR FROM hire_date)
    FROM employees
    WHERE department_id = 90
);

--SOLO MUESTRA EMPLEADOS CUYO ANO DE CONTRATACION ES MENOR AL DE TODOS LOS DEL DEPARTAMENTO 90
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ALL (
    SELECT EXTRACT(YEAR FROM hire_date)
    FROM employees
    WHERE department_id = 90
);

--EMPLEADOS QUE SON MANAGERS
SELECT last_name, employee_id
FROM employees
WHERE employee_id IN (
    SELECT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
);

-- USA UNA SUBCONSULTA CON ALL PARA COMPARAR
SELECT last_name, employee_id
FROM employees
WHERE employee_id <= ALL (
    SELECT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
);

--DEPARTAMENTOS DONDE EL SALARIO MINIMO ES MENOR QUE ALGUN SALARIO DE LOS DEPARTAMENTOS 10 O 20
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) < ANY (
    SELECT salary
    FROM employees
    WHERE department_id IN (10, 20)
)
ORDER BY department_id;

--EMPLEADOS QUE COMPARTEN MANAGER Y DEPARTAMENTO CON LOS EMPLEADOS 149 Y 174
--EXCLUYE A LOS EMPLEADOS 149 Y 174 DE LOS RESULTADOS
SELECT employee_id, manager_id, department_id
FROM employees
WHERE (manager_id, department_id) IN (
    SELECT manager_id, department_id
    FROM employees
    WHERE employee_id IN (149, 174)
)
AND employee_id NOT IN (149, 174);

--OTRA FORMA DE CONSULTAR LOS EMPLEADOS CON MISMO MANAGER Y DEPARTAMENTO QUE 149 O 174
--USANDO IN DE FORMA SEPARADA PARA CADA COLUMNA
SELECT employee_id, manager_id, department_id
FROM employees
WHERE manager_id IN (
    SELECT manager_id
    FROM employees
    WHERE employee_id IN (149, 174)
)
AND department_id IN (
    SELECT department_id
    FROM employees
    WHERE employee_id IN (149, 174)
)
AND employee_id NOT IN (149, 174);

--EMPLEADOS CON EL MISMO job_id QUE ALGUN EMPLEADO DE APELLIDO ERNST
--USADO PARA BUSCAR QUIENES TIENEN EL MISMO TIPO DE TRABAJO
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id IN (
    SELECT job_id
    FROM employees
    WHERE last_name = 'Ernst'
);

--EMPLEADOS CON SALARIO MAYOR AL PROMEDIO DE SU PROPIO DEPARTAMENTO
--COMPARA CADA EMPLEADO CON EL PROMEDIO DEL DEPARTAMENTO EN EL QUE TRABAJA
SELECT e.first_name, e.last_name, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

--EMPLEADOS QUE NO SON MANAGERS USANDO NOT EXISTS
--VERIFICA QUE NINGUN OTRO EMPLEADO LO TENGA COMO SU JEFE
SELECT last_name AS "Not a Manager"
FROM employees emp
WHERE NOT EXISTS (
    SELECT 1
    FROM employees mgr
    WHERE mgr.manager_id = emp.employee_id
);

--EMPLEADOS QUE NO SON MANAGERS USANDO NOT IN
--EXCLUYE A LOS EMPLEADOS CUYO ID ESTA COMO manager_id EN OTROS REGISTROS
SELECT last_name AS "Not a Manager"
FROM employees
WHERE employee_id NOT IN (
    SELECT DISTINCT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
);

--CREA UNA SUBCONSULTA TEMPORAL DE TODOS LOS MANAGERS Y LOS EXCLUYE DEL RESULTADO
WITH managers AS (
    SELECT DISTINCT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
)
SELECT last_name AS "Not a manager"
FROM employees
WHERE employee_id NOT IN (
    SELECT manager_id FROM managers
);
