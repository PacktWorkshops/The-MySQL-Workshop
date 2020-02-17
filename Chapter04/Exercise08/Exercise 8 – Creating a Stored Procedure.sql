USE `autoclub`;
DROP procedure IF EXISTS `sp_ListMembers`;
DELIMITER $$

CREATE PROCEDURE `sp_ListMembers` ()

BEGIN

SELECT * FROM members;

END$$

DELIMITER ;
