
USE ms_access_migration;

DROP PROCEDURE IF EXISTS  spCountryList;

DELIMITER //

CREATE PROCEDURE spCountryList() 
BEGIN

	SELECT DISTINCT Country.`Country Code`, Country.`Country Name`
	FROM Country 
	ORDER BY Country.`Country Name`;

END//

DELIMITER ;
