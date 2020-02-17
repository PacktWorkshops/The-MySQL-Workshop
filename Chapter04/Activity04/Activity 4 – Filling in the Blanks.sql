
-- Standard drop and custom delimiter 
DROP procedure IF exists sp_MembersFeeReceipt;
DELIMITER $$

-- Create the procedure, two parameters are passed in
-- MemberID, the ID value for the member we want to create the receipt for
-- The template text 
CREATE PROCEDURE `sp_MembersFeeReceipt`( IN MemberID VARCHAR(5), INOUT TemplateText LongText)
BEGIN

-- Query starts here  
SELECT
-- This is the list of field name we are extracting from the databse
  members.Surname,
  members.#####,
  members.MiddleNames,
  memberaddress.StreetAddress1,
  memberaddress.StreetAddress2,
  memberaddress.Town,
  states.#####,
  memberaddress.Postcode,
  membershipfees.DatePaid,
  membershipfees.FeeAmount,
  members.ID
  
INTO
-- The INTO tells MySQL to put the values into variables
-- Below is the list of variables, a variable starts with an @
-- The variables in this sample are named the same as the field they will receive data from (except ID)
-- They are also in the same order as the fields are above, VERY IMPORTANT.  
  @Surname,
  @FirstName,
  @MiddleNames,
  @#####,
  @StreetAddress2,
  @Town,
  @State,
  @PostCode,
  @#####,
  @AmountPaid,
  @MemberNumber
  
FROM
-- A standard method of linking the required tables together
  members
  INNER JOIN memberaddress ON memberaddress.MemberID = members.ID
  INNER JOIN membershipfees ON membershipfees.MemberID = members.ID
  INNER JOIN states ON memberaddress.State = states.ID
  
WHERE
-- And this is the filter to determin whecj member to use
-- the MemberID was passed in as a parameter
  members.ID = MemberID;

-- The TemplateText is now modified with the new values to replace the tags
 SET TemplateText = REPLACE(TemplateText,'<Surname>', #####);
 SET TemplateText = REPLACE(TemplateText,'<FirstName>', @FirstName);

-- COALESCE is used to replace an NULLS with an empty string
-- NULLs will cause the procedure to fail
-- COALESCE could be put on all fields, we are using them only for the fields likely to
-- contain a NULL
 SET TemplateText = REPLACE(TemplateText,'<MiddleNames>', COALESCE(@#####,""));
 SET TemplateText = REPLACE(TemplateText,'<Address1>', @StreetAddress1);
 SET TemplateText = REPLACE(TemplateText,'<Address2>', COALESCE(@#####,""));
 SET TemplateText = REPLACE(TemplateText,'<Town>', @Town);
 SET TemplateText = REPLACE(TemplateText,'<State>', @State);
 SET TemplateText = REPLACE(TemplateText,'<Postcode>', @Postcode);
 SET TemplateText = REPLACE(TemplateText,'<PaymentDate>', @DatePaid);

-- This is a dollar values so we are doing two things here, FORMAT will format the value with 
-- two decimal places and the CONCAT will put a dollar sign in front of the amount.
SET TemplateText = REPLACE(TemplateText,'<Amount>', CONCAT("$",FORMAT(@AmountPaid,2)));
 
-- And we finish up
 END$$
 
DELIMITER ;