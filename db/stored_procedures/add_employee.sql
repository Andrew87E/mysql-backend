DROP PROCEDURE IF EXISTS sp_add_employee;

DELIMITER //

CREATE PROCEDURE sp_add_employee(first_name VARCHAR(30), last_name VARCHAR(30), role_id INT, manager_id INT)
BEGIN
    INSERT INTO employee (first_name, last_name, role_id, manager_id)
    VALUES (first_name, last_name, role_id, manager_id);
END //

DELIMITER ;