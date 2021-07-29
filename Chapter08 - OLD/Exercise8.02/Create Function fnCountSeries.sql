USE ms_access_migration;

DROP FUNCTION IF EXISTS  `fnCountSeries`;

DELIMITER //

CREATE FUNCTION `fnCountSeries`() RETURNS long
    DETERMINISTIC
BEGIN

DECLARE TheValue Long;
SET TheValue = (SELECT COUNT(*) FROM series);
RETURN(TheValue);   

END//

DELIMITER ;