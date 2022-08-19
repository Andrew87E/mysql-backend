DROP PROCEDURE IF EXISTS sp_delete_role;

DELIMITER //

CREATE PROCEDURE sp_delete_role(role_id INT)
BEGIN
    DELETE FROM role WHERE id = role_id;
END //

DELIMITER ;