DROP PROCEDURE IF EXISTS sp_get_roles;

DELIMITER //

CREATE PROCEDURE sp_get_roles()
BEGIN
    SELECT r.id AS 'Id', r.title AS 'Title', r.salary AS 'Salary', d.name AS 'Department' from role r LEFT JOIN department d on r.department_id = d.id;
END //

DELIMITER ;