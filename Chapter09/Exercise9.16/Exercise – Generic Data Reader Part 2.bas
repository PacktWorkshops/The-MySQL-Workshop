'NOTE: This code is to be added after any existing in the Workbook_Open event



'1.	Pass in a query to read data from the customer count view and assign the value to N8

	'Populate Customer Purchase Details
	Worksheets("Dashboard").Cells(8, 14) = runSQL_SingleResult("SELECT * FROM vw_customer_count")

'2.	Pass in a query to call a stored procedure and place the returned value in N9

	Worksheets("Dashboard").Cells(9, 14) = runSQL_SingleResult("call spTotalSales()")

'3.	Finally, pass in a query to find the maximum InvoiceDate from the invoice table and place the returned value in N12

    Worksheets("Dashboard").Cells(12, 14) = runSQL_SingleResult("SELECT MAX(InvoiceDate) FROM invoice")

