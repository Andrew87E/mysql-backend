DROP PROCEDURE IF EXISTS sp_update_employee_role;

DELIMITER //

CREATE PROCEDURE sp_update_employee_role(employee_id INT, role_id INT)
BEGIN
    UPDATE employee
    SET employee.role_id = role_id
    WHERE employee.id = employee_id;
END //

DELIMITER ;