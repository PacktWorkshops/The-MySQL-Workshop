-- Declare the variables
SET @TotalCars = 0;	-- Declare and initialise @TotalCars 
SET @MakeString = "Car Make/Count :- ";  -- Declare and initialise @MakeString 

-- Each call will pass in the Make to be counted
-- Each call will pass in the current value for @TotalCars and @MakeString
-- Each call will add to the string or total
call sp_CountCars_MembersMakes("Holden",@TotalCars,@MakeString);
call sp_CountCars_MembersMakes("Ford",@TotalCars,@MakeString);
call sp_CountCars_MembersMakes("Mazda",@TotalCars,@MakeString);
call sp_CountCars_MembersMakes("Toyota",@TotalCars,@MakeString);

-- Output the make string and total when finish
SELECT @MakeString, @TotalCars 
