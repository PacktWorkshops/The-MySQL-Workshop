
USE ms_access_migration;
DROP PROCEDURE IF EXISTS  spCountryList_par;
DELIMITER //

CREATE PROCEDURE spCountryList_par(IN TableName VARCHAR(25), IN TheSeries VARCHAR(25) ) 
BEGIN

SET @t1 = CONCAT(    
    'SELECT DISTINCT Country.`Country Code`, Country.`Country Name`, ' , TableName , '.`Series Code` ',
    'FROM Country INNER JOIN ' , TableName , ' ON Country.`Country Code` = ' , TableName , '.`Country Code` ',
    'WHERE ' , TableName , '.`Series Code` = "' , TheSeries , '" ',   
    'ORDER BY Country.`Country Name`'	
  );

PREPARE stmt1 FROM @t1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

END//

DELIMITER ;