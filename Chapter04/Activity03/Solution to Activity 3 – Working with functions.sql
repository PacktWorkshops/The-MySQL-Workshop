USE autoclub;
DROP FUNCTION IF EXISTS fn_GSTComponent;
DELIMITER $$
CREATE FUNCTION fn_GSTComponent(GSTInclusiveAmount DECIMAL(13,2)) RETURNS DECIMAL(13,2) 
reads sql data

BEGIN

-- Declare the variables
DECLARE SalesTaxPayable DECIMAL(13,2);
DECLARE Divisor DOUBLE;

-- Calculate the Divisor value
-- This value when applied will determine the GST component of the GSTInclusiveAmount
SET Divisor = 1 + (1 * fn_Lookup("GSTRate"));

-- Perform the calculation
SET SalesTaxPayable = GSTInclusiveAmount - (GSTInclusiveAmount / Divisor);

-- Return the result, formatted to two decimal places
RETURN FORMAT(SalesTaxPayable,2);   

END $$
DELIMITER ;
