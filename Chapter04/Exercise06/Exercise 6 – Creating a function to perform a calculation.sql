USE autoclub;
DROP FUNCTION IF EXISTS fn_SalesTax;
DELIMITER $$
CREATE FUNCTION fn_SalesTax(SaleValue DECIMAL(13,4)) RETURNS DECIMAL(13,4) 
reads sql data

BEGIN

-- Declare the variables
DECLARE GSTRate DECIMAL(13,4);
DECLARE SalesTaxPayable DECIMAL(13,4);

-- Get the GST tax rate using the Lookup function
SET GSTRate = fn_Lookup("GSTRate");


-- Perform the calculation
SET SalesTaxPayable = SaleValue * GSTRate;

-- Return the result, formatted to two decimal places
RETURN FORMAT(SalesTaxPayable,4);   

END $$
DELIMITER ;
