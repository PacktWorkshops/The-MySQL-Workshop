USE `autoclub`;
DROP procedure IF EXISTS `sp_ListTableData`;
DELIMITER $$

CREATE PROCEDURE `sp_ListTableData` (IN TableName VARCHAR(100))
BEGIN

SET @sql =CONCAT('SELECT * FROM ',TableName);
	PREPARE statement FROM @sql;
	EXECUTE statement;
DEALLOCATE PREPARE statement; 
      
END$$

DELIMITER ;
