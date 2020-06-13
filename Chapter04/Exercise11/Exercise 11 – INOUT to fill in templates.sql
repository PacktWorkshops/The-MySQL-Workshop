USE `autoclub`;
DROP procedure IF EXISTS `sp_CountIdentificationTypes`;

DELIMITER $$
USE `autoclub`$$
CREATE DEFINER=`Tom`@`%` PROCEDURE `sp_CountIdentificationTypes`( INOUT TemplateText LongText)
BEGIN

-- Create the SELECT statement, the data will be coming from a 
-- Sub Query and the returned rows will be in a single field named TheText
-- GROUP_CONCAT will combine the values from THeText 
-- in all rows returned into one string and place the string into @IDCount
SELECT GROUP_CONCAT( DISTINCT TheText ) INTO @IDCount

-- The FROM clause, next comes our data source
FROM

-- The data source is a Sub Query. The sq after the closing bracket 
-- of the subquery is just a name we need to assign it. 

-- Sub Query CONCATs the field values into a derived field named TheText.
-- The /n is a NewLine to ensure each row will start on a new line
-- The count is surrounded by brackets
(
SELECT (CONCAT('\n',identificationtype.identificationtype, ' (', Count(identificationtype.ID),')' ) ) as TheText

-- The source of the data
FROM
  identification
  INNER JOIN identificationtype ON identification.IDType = identificationtype.ID
  
-- GROUP BY ensures each identificationtype found is grouped together
GROUP BY
  identificationtype.identificationtype
) sq;



SELECT
  Count(members.Active) INTO @ActiveMemberCount
FROM
  members
WHERE
  members.Active <> 0;


-- The REPLACE command will replace the <IdentificationData> tag in the TemplateText passed in 
-- with the values now in @IDCount
-- The TemplateText is now modified and ready to be passed back
SET TemplateText = REPLACE(TemplateText,'<ReportDate>', CURDATE());
SET TemplateText = REPLACE(TemplateText,'<IdentificationData>', @IDCount);
SET TemplateText = REPLACE(TemplateText,'<TotalMembers>', CONVERT(@ActiveMemberCount,UNSIGNED));

END$$

DELIMITER ;
