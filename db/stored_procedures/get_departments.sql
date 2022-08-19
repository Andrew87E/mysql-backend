DROP PROCEDURE IF EXISTS sp_get_departments;

DELIMITER //

CREATE PROCEDURE sp_get_departments()
BEGIN
    SELECT id AS 'Id', name AS 'Name' FROM department;
END //

DELIMITER ;