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