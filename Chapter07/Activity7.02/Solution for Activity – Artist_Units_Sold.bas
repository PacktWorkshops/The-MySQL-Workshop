'This code is to go into the MySQLDatabase module

'Solution for Activity – Artist_Units_Sold

Public Function ReadArtistSales() As Boolean

    'Declare the variables to use
    Dim SQL As String       'To store the SQL statement
    Dim RS As Recordset     'The Recordset variable
    Dim Msg As String       'To display messages
    Dim Counter As Integer  'A counter
    Dim MyNamedRng As Range ' A range variable
    
    'Setup error handling
    On Error GoTo HandleError

'2.	Prepare the SQL statement. Using a pre-prepared View has reduced the SQL statement to a single line

    'Build the SQL statement to read from the two databases
    SQL = ""
    SQL = SQL & "SELECT * FROM vw_artist_unit_sales;"

'3.	Create the connection passing in the global connection variable and test if it was successful

    'Make the connection to the server, test if it was successful
    If ConnectDB_DSNless(g_Conn_DSNless) = True Then
        'Connection succeeded so we can continue processing

'4.	If successful, set the RecordSet variable RS and then open it with the SQL and connection

        'Set the recordset variable
        Set RS = New ADODB.Recordset
        
        'Load the recordset, pass in the SQL and the connection to use
        RS.Open SQL, g_Conn_DSNless
    
'5.	Test there are records and handle it appropriately if there are none

        'Test there are records.
        If RS.EOF And RS.BOF Then
            'No data, close the recordset
            RS.Close
            Set RS = Nothing
            
            'tell user and then leave the function
            Msg = "There is no data"
            MsgBox Msg, vbOKOnly + vbInformation, "No data to display"
            GoTo LeaveFunction
        
'6.	Start processing the recordset if there are records, beginning with the headings. The starting column has changed to 3 “C” 

        Else
            'Insert Field headings for column headings
            For Counter = 0 To RS.Fields.Count - 1
                Worksheets("Data Sheet").Cells(1, 3 + Counter) = RS.Fields(Counter).Name
            Next
            
'7.	Place the data on the worksheet, and the column is now 3

            'Place the data on the worksheet
            Worksheets("Data Sheet").Cells(2, 3).CopyFromRecordset RS
            
'8.	Set the range, the range is now on columns C and D, and the ranges name has been set to appropriately describe the ranges purpose

            'Set and create a named range covering the columns with the Artist name and sales data only
            Set MyNamedRng = Worksheets("Data Sheet").Range("C2:D" & RS.RecordCount + 1)
            ActiveWorkbook.Names.Add Name:="Artist_Units_Sold", RefersTo:=MyNamedRng
         
'9.	Close the recordset and connection

            'Close the recordset
            RS.Close
            Set RS = Nothing
            
            'Close the connection
            g_Conn_DSNless.Close
            Set g_Conn_DSNless = Nothing
            
'10.	The result passed back is assigned to the function name

            'Pass back success
            ReadArtistSales = True
        End If
        
    Else
        'The connection routine will have displayed a message so nothing to do but leave
        ReadArtistSales = False
    End If

'11.	Set an exit point for error handling

LeaveFunction:
    'Leave the function
    Exit Function

'12.	Set error handling

HandleError:
    'Pass back Failed
    ReadArtistSales = False
    Resume LeaveFunction

'13.	And we are finished

End Function
