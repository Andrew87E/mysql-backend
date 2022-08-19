DROP PROCEDURE IF EXISTS sp_add_role;

DELIMITER //

CREATE PROCEDURE sp_add_role(title VARCHAR(30), salary INT, department_id INT)
BEGIN
    INSERT INTO role (title, salary, department_id)
    VALUES (title, salary, department_id);
END //

DELIMITER ;