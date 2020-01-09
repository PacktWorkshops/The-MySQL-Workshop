'NOTE: The code marked NEW CODE below is meant to be placed after the EXISTING CODE in the ReadArtistSales() function located in the MySQLDatabase Module
'	The EXISTING CODE is here to provide you with a reference, it should not be duplicated in the function.


'Solution for Activity – Artist Dropdown


'1.	ReadArtistSales VBA modification
'	Step 8 in the solution for the previous activity will now be

			'EXISTING CODE
            'Set and create a named range covering the columns with the Artist name and sales data only
            Set MyNamedRng = Worksheets("Data Sheet").Range("C2:D" & RS.RecordCount + 1)
            ActiveWorkbook.Names.Add Name:="Artist_Units_Sold", RefersTo:=MyNamedRng
            
            'NEW CODE
            'Set and create a named range covering the single column for the Artists name, data only
            Set MyNamedRng = Worksheets("Data Sheet").Range("C2:C" & RS.RecordCount + 1)
            ActiveWorkbook.Names.Add Name:="Artist_List", RefersTo:=MyNamedRng
