--TABLAS DE LA SECCION 19 ORACLE

-- FUNCIONES DE TEXTO Y FORMATO (TABLA CLIENTS)
SELECT 
    LOWER(first_name) AS lowercase_name,
    UPPER(last_name) AS uppercase_name,
    INITCAP(email) AS proper_case_email,
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(last_name, 1, 3) AS first_three_chars,
    LENGTH(first_name) AS name_length,
    POSITION('a' IN LOWER(first_name)) AS position_of_a,
    LPAD(client_id::TEXT, 6, '0') AS padded_id,
    RPAD(first_name, 15, '.') AS right_padded_name,
    TRIM(BOTH ' ' FROM '  ' || first_name || '  ') AS trimmed_name,
    REPLACE(email, '@', ' AT ') AS replaced_email
FROM clients
WHERE client_id <= 5;

--EJEMPLOS CON DATOS NUMÉRICOS (USANDO client_id)
SELECT 
    client_id,
    ROUND(client_id, -1) AS rounded_id,
    TRUNC(client_id, -1) AS truncated_id,
    MOD(client_id, 10) AS mod_result
FROM clients
WHERE client_id <= 5;

-- ============================================
-- FECHAS (SIN hire_date, USAREMOS CURRENT_DATE)
-- ============================================
SELECT 
    CURRENT_DATE AS current_date,
    DATE_TRUNC('month', CURRENT_DATE) AS truncated_to_month,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, CURRENT_DATE - INTERVAL '2 years')) * 12 +
    EXTRACT(MONTH FROM AGE(CURRENT_DATE, CURRENT_DATE - INTERVAL '2 years')) AS months_between,
    CURRENT_DATE + INTERVAL '6 months' AS add_6_months,
    DATE_TRUNC('week', CURRENT_DATE) + INTERVAL '6 days' AS next_sunday,
    DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month' - INTERVAL '1 day' AS last_day_of_month
FROM clients
WHERE client_id <= 3;

--FORMATO DE TEXTO
SELECT 
    TO_CHAR(client_id, '999,999') AS formatted_id,
    TO_CHAR(CURRENT_DATE, 'Month DD, YYYY') AS formatted_date,
    client_id::TEXT AS number_to_char,
    TO_DATE('2023-12-25', 'YYYY-MM-DD') AS converted_date
FROM clients
WHERE client_id <= 3;

--NVL, COALESCE, NULLIF (ADAPTADO)
SELECT 
    first_name,
    COALESCE(phone, 'NO PHONE') AS nvl_equivalent,
    CASE WHEN phone IS NOT NULL THEN phone ELSE 'NO PHONE' END AS nvl2_equivalent,
    NULLIF(address, '') AS nullif_example,
    COALESCE(phone, address, 'NO CONTACT') AS coalesce_example
FROM clients
WHERE client_id <= 5;


--CASE Y CLASIFICACIÓN
SELECT 
    first_name,
    client_id,
    CASE client_id 
        WHEN 1 THEN 'PRIORITY CLIENT'
        WHEN 2 THEN 'NORMAL CLIENT'
        ELSE 'OTHER'
    END AS decode_equivalent,
    CASE 
        WHEN client_id > 100 THEN 'HIGH ID'
        WHEN client_id > 50 THEN 'MEDIUM ID'
        ELSE 'LOW ID'
    END AS id_grade
FROM clients
WHERE client_id <= 10;

--CROSS JOIN CON DEPARTMENTS
SELECT c.last_name, d.department_name
FROM clients c CROSS JOIN departments d
WHERE c.client_id = 1;


SELECT d.department_id, d.department_name, d.location_id
FROM departments d
NATURAL JOIN departments d2
WHERE d.department_id <= 5;


-- INNER JOIN CON DEPARTMENTS
SELECT c.client_id, c.last_name, d.department_name
FROM clients c 
JOIN departments d ON d.department_id = 10
WHERE c.client_id <= 5;

--RIGHT JOIN CON DEPARTMENTS
SELECT c.client_id, c.last_name, d.department_id, d.department_name
FROM clients c 
RIGHT OUTER JOIN departments d ON (d.department_id = 10)
WHERE d.department_id <= 30;

--LEFT JOIN CON DEPARTMENTS
SELECT c.client_id, c.last_name, d.department_id, d.department_name
FROM clients c 
LEFT OUTER JOIN departments d ON (d.department_id = 10)
WHERE c.client_id <= 10;

--CREACION DE TABLA DE EJEMPLO
DROP TABLE IF EXISTS example_table CASCADE;
CREATE TABLE example_table
(col1 SERIAL,
col2 VARCHAR(50),
col3 VARCHAR(30),
col4 NUMERIC(10,2),
col5 INTEGER,
CONSTRAINT tab_col1_pk PRIMARY KEY(col1),
CONSTRAINT tab_col3_uk UNIQUE(col2),
CONSTRAINT tab_col4_ck CHECK (col4 > 0),
CONSTRAINT tab1_col5_fk FOREIGN KEY (col5) REFERENCES departments(department_id));


--ROW_NUMBER() OVER()
SELECT 
    ROW_NUMBER() OVER (ORDER BY client_id DESC) AS rank,
    first_name,
    last_name,
    client_id
FROM clients
ORDER BY client_id DESC
LIMIT 5;


-- SUBCONSULTA CON PROMEDIO POR UBICACION
SELECT c.first_name, c.last_name, sub.avg_id
FROM clients c,
     (SELECT location_id, AVG(department_id) AS avg_id
      FROM departments
      GROUP BY location_id) sub
WHERE sub.location_id = departments.location_id
LIMIT 5;

--CONVERSIONES ORACLE A POSTGRESQL
SELECT 'PostgreSQL function equivalents:' AS info;
SELECT 'SUBSTR → SUBSTRING, INSTR → POSITION, NVL → COALESCE' AS conversions;
SELECT 'ROWNUM → ROW_NUMBER() OVER(), DECODE → CASE' AS conversions2;
