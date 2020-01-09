USE ms_access_migration;

DROP PROCEDURE IF EXISTS  spGroupsList;

DELIMITER //

CREATE PROCEDURE spGroupsList() 
BEGIN

	SELECT DISTINCT series.Group 
	FROM series 
	ORDER BY series.Group;

END//

DELIMITER ;
