DROP PROCEDURE IF EXISTS sp_update_employee_manager;

DELIMITER //

CREATE PROCEDURE sp_update_employee_manager(employee_id INT, manager_id INT)
BEGIN
    UPDATE employee
    SET employee.manager_id = manager_id
    WHERE employee.id = employee_id;
END //

DELIMITER ;