USE `autoclub`;
DROP procedure IF EXISTS `sp_CountCars_MembersMakes`;
DELIMITER $$

-- Create the stored procedure with 3 parameters
-- 1) 	is the Make of car, ie. Holden, this is an IN parameter
-- 2) 	is an INOUT called TotalCars, the SQL in the procedure will count the Make and assign it to a variable, the count is then added
-- 		to the TotalCars value which will then be passed back out, updating the variable that passed the original value in 
-- 3)	is an INOUT named CarString, The Make and Count will be added to this string on each pass through, same as 2)
CREATE PROCEDURE `sp_CountCars_MembersMakes` (IN CarMake VARCHAR(20), INOUT TotalCars INT, INOUT CarString VARCHAR(255))

BEGIN

-- The SQL to count the make. 
    -- This is a standard SQL statement except for
    -- the COUNT value is inserted into a variable, not a field name
    -- and the Filter in the WHERE clause come from the CrMake value passed in as the IN parameter
	SELECT
	  Count(vehicle.Make) INTO @TotalInMake	-- The count is put INTO the variable @TotalInMake instead of a field name
	FROM
	  vehicle
	  INNER JOIN members ON vehicle.MemberID = members.ID
	  INNER JOIN make ON vehicle.Make = make.ID
	  INNER JOIN vehiclemodel ON vehicle.Model = vehiclemodel.ID
	WHERE
	  members.Active <> 0 AND
	  make.Make = CarMake;	-- The Carmake is used to filter the records

	-- The car count value in @TotalInMake is added to the CarTotal value passed insert
    -- This is then passed back out via the INOUT, updating the value in the calling routine
	SET TotalCars = TotalCars + @TotalInMake;
    
    -- The CarMake and the  @TotalInMake values are added to the string passed in
    -- This is then passed back out via the INOUT, updating the value in the calling routine
    SET CarString = CONCAT(CarString,CarMake,"=",@TotalInMake, "  ");

END$$

DELIMITER ;
