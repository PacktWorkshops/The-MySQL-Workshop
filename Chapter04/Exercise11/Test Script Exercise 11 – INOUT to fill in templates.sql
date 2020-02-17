-- Create a template in a variable to pass into the stored procedure
SET @DocumentTemplate = (SELECT TemplateText FROM autoclubtemplates.templates WHERE TemplateType='GB_Identification_Report');

-- Call the stored procedure passing in the template
Call sp_CountIdentificationTypes(@DocumentTemplate);

-- Select the template variable for output
SELECT @DocumentTemplate;
