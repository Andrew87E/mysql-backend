DROP PROCEDURE IF EXISTS sp_delete_department;

DELIMITER //

CREATE PROCEDURE sp_delete_department(department_id INT)
BEGIN
    DELETE FROM department WHERE id = department_id;
END //

DELIMITER ;