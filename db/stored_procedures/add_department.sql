DROP PROCEDURE IF EXISTS sp_add_department;

DELIMITER //

CREATE PROCEDURE sp_add_department(IN name VARCHAR(30))
BEGIN
    INSERT INTO department (name)
    VALUES (name);
END //

DELIMITER ;