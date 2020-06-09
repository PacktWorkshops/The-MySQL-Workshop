SQL = "Call spSeriesList_par('" & Me.cmbGroups & "');"
Call CreatePassThrough(SQL, "spSeriesFiltered", True, False)
USE ms_access_migration;
DROP PROCEDURE IF EXISTS  spDateRange_par;
DELIMITER //

CREATE PROCEDURE spDateRange_par(IN TableName VARCHAR(25), IN TheSeries VARCHAR(25) ) 
BEGIN

SET @t1 = CONCAT(    
    'SELECT DISTINCT ' , TableName , '.Year ',
    'FROM ', TableName , ' ',
    'WHERE ' , TableName , '.`Series Code` = "' , TheSeries , '" ',   
    'ORDER BY ', TableName ,'.Year'	
);

PREPARE stmt1 FROM @t1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

END//

DELIMITER ;