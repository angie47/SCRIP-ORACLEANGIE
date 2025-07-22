CREATE TABLE IF NOT EXISTS departments (
    department_id   SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);


CREATE TABLE IF NOT EXISTS employees (
    employee_id SERIAL PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    salary      NUMERIC(10,2)
);


CREATE TABLE IF NOT EXISTS clients (
    client_id   SERIAL PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    email       VARCHAR(100) UNIQUE NOT NULL,
    phone       VARCHAR(20),
    address     TEXT
);


INSERT INTO departments (department_id, department_name)
VALUES 
    (10, 'Administration'),
    (20, 'Marketing'),
    (30, 'Shipping'),
    (40, 'IT')
ON CONFLICT (department_id) DO NOTHING;


INSERT INTO employees (first_name, last_name, salary)
VALUES 
    ('Ellen', 'Abel', 12000),
    ('Curtis', 'Davies', 15000),
    ('Lex', 'De Haan', 20000);

INSERT INTO clients (first_name, last_name, email, phone, address)
VALUES 
    ('Ana', 'Ramírez', 'ana.ramirez@example.com', '987654321', 'Colonia Centro, La Ceiba'),
    ('Luis', 'Martínez', 'luis.martinez@example.com', '998877665', 'Barrio Inglés, La Ceiba'),
    ('Sofía', 'González', 'sofia.gonzalez@example.com', '912345678', 'Zona Viva, La Ceiba')
ON CONFLICT (email) DO NOTHING;


SELECT 'Departments:' as table_info;
SELECT * FROM departments;

SELECT 'Employees:' as table_info;
SELECT * FROM employees;

SELECT 'Clients:' as table_info;
SELECT * FROM clients;