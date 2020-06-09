USE ms_access_migration;
DROP PROCEDURE IF EXISTS  spCTSource_par;
DELIMITER //


CREATE PROCEDURE spCTSource_par
(
IN TableName VARCHAR(25), 
IN TheSeries VARCHAR(25), 
IN TheGroup VARCHAR(25), 
IN TheCountry VARCHAR(100), 
IN StartYear VARCHAR(20), 
IN EndYear VARCHAR(20)  
)


BEGIN
SET @t1 = CONCAT(
  

    'SELECT country.`Country Name`, series.`Series Name`, ', TableName ,'.`Year`, ', TableName ,'.`StatisticValue` '
    'FROM (', TableName ,' '
    'INNER JOIN country ON ', TableName ,'.`Country Code` = country.`Country Code`) '
    'INNER JOIN series ON ', TableName ,'.`Series Code` = series.`Series Code` '
    'WHERE (((country.`Country Code`) = "' , TheCountry , '") '
    'And ((series.`Series Code`) = "' , TheSeries , '") '
    'And ((', TableName ,'.Year) >= "' , StartYear , '" '
    'And (', TableName ,'.Year) <= "' , EndYear , '") '
    'And ((series.Group) = "' , TheGroup , '"))'
    'GROUP BY country.`Country Name`, series.`Series Name`, ', TableName ,'.`Year` '

    'ORDER BY ', TableName ,'.Year '
);

PREPARE stmt1 FROM @t1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
END//
DELIMITER ;
