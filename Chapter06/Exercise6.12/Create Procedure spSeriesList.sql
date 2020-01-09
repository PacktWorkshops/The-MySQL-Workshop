
USE ms_access_migration;

DROP PROCEDURE IF EXISTS  spSeriesList;

DELIMITER //

CREATE PROCEDURE spSeriesList() 
BEGIN

	SELECT DISTINCT ms_access_migration.series.`Series Code`, ms_access_migration.series.`series Name` 
	FROM ms_access_migration.series 
	ORDER BY ms_access_migration.series.`series Name`;

END//

DELIMITER ;

