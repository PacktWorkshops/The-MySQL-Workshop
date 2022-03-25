-- Create a template in a variable to pass into the stored procedure
SET @DocumentTemplate = (SELECT TemplateText FROM autoclubtemplates.templates WHERE TemplateType='Receipt_Membership');

-- Call the stored procedure passing in the template
 Call sp_MembersFeeReceipt('2',@DocumentTemplate);

-- Select the template variable for output
SELECT @DocumentTemplate;