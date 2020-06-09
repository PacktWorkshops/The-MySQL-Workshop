
USE ms_access_migration;

DROP PROCEDURE IF EXISTS  spSeriesList_par;

DELIMITER //

CREATE PROCEDURE spSeriesList_par(IN GroupName VARCHAR(25)) 
BEGIN

	SELECT DISTINCT ms_access_migration.series.`Series Code`, ms_access_migration.series.`series Name` 
	FROM ms_access_migration.series 
	WHERE series.`Group` = GroupName 
	ORDER BY ms_access_migration.series.`series Name`;

END//

DELIMITER ;

