
DROP procedure IF exists sp_MembersFeeReceipt;
DELIMITER $$
CREATE PROCEDURE `sp_MembersFeeReceipt`( IN MemberID VARCHAR(5), INOUT TemplateText LongText)
BEGIN


SELECT
  members.Surname,
  members.FirstName,
  members.MiddleNames,
  memberaddress.StreetAddress1,
  memberaddress.StreetAddress2,
  memberaddress.Town,
  states.State,
  memberaddress.Postcode,
  membershipfees.DatePaid,
  membershipfees.FeeAmount,
  members.ID
  
INTO
    
  @Surname,
  @FirstName,
  @MiddleNames,
  @StreetAddress1,
  @StreetAddress2,
  @Town,
  @State,
  @PostCode,
  @DatePaid,
  @AmountPaid,
  @MemberNumber
  
FROM
  members
  INNER JOIN memberaddress ON memberaddress.MemberID = members.ID
  INNER JOIN membershipfees ON membershipfees.MemberID = members.ID
  INNER JOIN states ON memberaddress.State = states.ID
  
WHERE
  members.ID = MemberID;

-- The TemplateText is now modified and then passed back
 SET TemplateText = REPLACE(TemplateText,'<Surname>', @Surname);
 SET TemplateText = REPLACE(TemplateText,'<FirstName>', @FirstName);
 SET TemplateText = REPLACE(TemplateText,'<MiddleNames>', COALESCE(@MiddleNames,""));
 SET TemplateText = REPLACE(TemplateText,'<Address1>', @StreetAddress1);
 SET TemplateText = REPLACE(TemplateText,'<Address2>', COALESCE(@StreetAddress2,""));
 SET TemplateText = REPLACE(TemplateText,'<Town>', @Town);
 SET TemplateText = REPLACE(TemplateText,'<State>', @State);
 SET TemplateText = REPLACE(TemplateText,'<Postcode>', @Postcode);
 SET TemplateText = REPLACE(TemplateText,'<PaymentDate>', @DatePaid);
 SET TemplateText = REPLACE(TemplateText,'<Amount>', CONCAT("$",FORMAT(@AmountPaid,2)));
 
 END$$
 
DELIMITER ;