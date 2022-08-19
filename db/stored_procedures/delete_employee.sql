DROP PROCEDURE IF EXISTS sp_delete_employee;

DELIMITER //

CREATE PROCEDURE sp_delete_employee(employee_id INT)
BEGIN
    DELETE FROM employee WHERE id = employee_id;
END //

DELIMITER ;