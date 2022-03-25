USE autoclub;

DROP FUNCTION IF EXISTS fn_GetImagePath;
DELIMITER $$
CREATE FUNCTION fn_GetImagePath(MemberID INT, ImageType VARCHAR(10)) RETURNS VARCHAR (255) 
READS SQL DATA

BEGIN
	#Declare the variable
	DECLARE vImagePath VARCHAR(255) DEFAULT "";
	DECLARE vTheValue  VARCHAR(255) DEFAULT "";
	
#Test the image type and Retrieve the appropriate image path
	CASE ImageType
		WHEN "Signature" THEN
			SET vImagePath = COALESCE((SELECT `SigPath` FROM `members` WHERE `ID` = MemberID),"");
		WHEN "Photo" THEN
			SET vImagePath = COALESCE((SELECT `PhotoPath` FROM `members` WHERE `ID` = MemberID),"");
		ELSE
			RETURN "No Image Directive";
	END CASE;


	#Test there is a path
	CASE vImagePath 
		WHEN "" THEN
			RETURN "No image for member";	
		ELSE
			SET vTheValue = CONCAT(fn_Lookup("ImageRepository"), vImagePath);
	END CASE;

RETURN (RTRIM(LTRIM(vTheValue)));   

END $$
DELIMITER ;