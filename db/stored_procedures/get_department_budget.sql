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