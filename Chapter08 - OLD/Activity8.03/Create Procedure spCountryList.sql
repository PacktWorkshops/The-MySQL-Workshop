
USE ms_access_migration;

DROP PROCEDURE IF EXISTS  spCountryList;

DELIMITER //

CREATE PROCEDURE spCountryList() 
BEGIN

	SELECT DISTINCT country.`Country Code`, country.`Country Name`
	FROM country 
	ORDER BY country.`Country Name`;

END//

DELIMITER ;
