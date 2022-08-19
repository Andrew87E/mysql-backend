DROP DATABASE IF EXISTS employees_db;
CREATE DATABASE employees_db;

USE employees_db;

CREATE TABLE department (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30),
    PRIMARY KEY (id)
);

CREATE TABLE role (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(30) NOT NULL,
    salary DECIMAL NOT NULL,
    department_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (department_id) REFERENCES department(id)
        ON DELETE SET NULL
);

CREATE TABLE employee (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    role_id INT,
    manager_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (role_id) REFERENCES role(id)
        ON DELETE SET NULL,
    FOREIGN KEY (manager_id) REFERENCES employee(id)
        ON DELETE SET NULL
);

DROP PROCEDURE IF EXISTS sp_add_department;

DELIMITER //

CREATE PROCEDURE sp_add_department(IN name VARCHAR(30))
BEGIN
    INSERT INTO department (name)
    VALUES (name);
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_add_employee;

DELIMITER //

CREATE PROCEDURE sp_add_employee(first_name VARCHAR(30), last_name VARCHAR(30), role_id INT, manager_id INT)
BEGIN
    INSERT INTO employee (first_name, last_name, role_id, manager_id)
    VALUES (first_name, last_name, role_id, manager_id);
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_add_role;

DELIMITER //

CREATE PROCEDURE sp_add_role(title VARCHAR(30), salary INT, department_id INT)
BEGIN
    INSERT INTO role (title, salary, department_id)
    VALUES (title, salary, department_id);
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_delete_department;

DELIMITER //

CREATE PROCEDURE sp_delete_department(department_id INT)
BEGIN
    DELETE FROM department WHERE id = department_id;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_delete_employee;

DELIMITER //

CREATE PROCEDURE sp_delete_employee(employee_id INT)
BEGIN
    DELETE FROM employee WHERE id = employee_id;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_delete_role;

DELIMITER //

CREATE PROCEDURE sp_delete_role(role_id INT)
BEGIN
    DELETE FROM role WHERE id = role_id;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_get_department_budget;

DELIMITER //

CREATE PROCEDURE sp_get_department_budget(selected_department_id INT)
BEGIN
    SELECT d.id AS Id, d.name AS 'Department', SUM(salary) as 'Total Budget'
    FROM department as d
        INNER JOIN
        role AS r
        ON d.id = r.department_id
        INNER JOIN
        employee AS e
        ON r.id = e.role_id
        WHERE d.id = selected_department_id
        GROUP BY d.id;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_get_departments;

DELIMITER //

CREATE PROCEDURE sp_get_departments()
BEGIN
    SELECT id AS 'Id', name AS 'Name' FROM department;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_get_department_employees;

DELIMITER //

CREATE PROCEDURE sp_get_department_employees(department_id INT)
BEGIN
    SELECT e.id AS 'Id', e.first_name AS 'First Name', e.last_name AS 'Last Name', r.title AS 'Title', d.name AS 'Department', r.salary AS 'Salary', CONCAT(m.first_name, ' ', m.last_name) as 'Manager'
    FROM employee AS e
        LEFT JOIN
        employee AS m
        ON e.manager_id = m.id
        INNER JOIN
        role AS r
        ON e.role_id = r.id
        INNER JOIN
        department as d
        ON r.department_id = d.id
        WHERE d.id = department_id;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_get_employees;

DELIMITER //

CREATE PROCEDURE sp_get_employees()
BEGIN
    SELECT e.id AS 'Id', e.first_name AS 'First Name', e.last_name AS 'Last Name', r.title AS 'Title', d.name AS 'Department', r.salary AS 'Salary', CONCAT(m.first_name, ' ', m.last_name) as 'Manager'
    FROM employee AS e
        LEFT JOIN
        employee AS m
        ON e.manager_id = m.id
        LEFT JOIN
        role AS r
        ON e.role_id = r.id
        LEFT JOIN
        department as d
        ON r.department_id = d.id;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_get_employee_reports;

DELIMITER //

CREATE PROCEDURE sp_get_employee_reports(employee_id INT)
BEGIN
    SELECT e.id AS 'Id', e.first_name AS 'First Name', e.last_name AS 'Last Name', r.title AS 'Title', d.name AS 'Department', r.salary AS 'Salary', CONCAT(m.first_name, ' ', m.last_name) as 'Manager'
    FROM employee AS e
        INNER JOIN
        employee AS m
        ON e.manager_id = m.id
        LEFT JOIN
        role AS r
        ON e.role_id = r.id
        LEFT JOIN
        department as d
        ON r.department_id = d.id
        WHERE e.manager_id = employee_id;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_get_managers;

DELIMITER //

CREATE PROCEDURE sp_get_managers()
BEGIN
    SELECT DISTINCT e.id AS 'Id', e.first_name AS 'First Name', e.last_name AS 'Last Name', r.title AS 'Title', d.name AS 'Department', r.salary AS 'Salary', CONCAT(m.first_name, ' ', m.last_name) as 'Manager'
    FROM employee AS e
        LEFT JOIN
        employee AS m
        ON e.manager_id = m.id
        INNER JOIN
        employee as report
        ON e.id = report.manager_id
        LEFT JOIN
        role AS r
        ON e.role_id = r.id
        LEFT JOIN
        department as d
        ON r.department_id = d.id;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_get_roles;

DELIMITER //

CREATE PROCEDURE sp_get_roles()
BEGIN
    SELECT r.id AS 'Id', r.title AS 'Title', r.salary AS 'Salary', d.name AS 'Department' from role r INNER JOIN department d on r.department_id = d.id;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_update_employee_manager;

DELIMITER //

CREATE PROCEDURE sp_update_employee_manager(employee_id INT, manager_id INT)
BEGIN
    UPDATE employee
    SET employee.manager_id = manager_id
    WHERE employee.id = employee_id;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_update_employee_role;

DELIMITER //

CREATE PROCEDURE sp_update_employee_role(employee_id INT, role_id INT)
BEGIN
    UPDATE employee
    SET employee.role_id = role_id
    WHERE employee.id = employee_id;
END //

DELIMITER ;
