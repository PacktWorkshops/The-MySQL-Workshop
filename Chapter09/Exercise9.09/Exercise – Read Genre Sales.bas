'This code is to go into the MySQLDatabase module

'Exercise – Read Genre Sales

'1.	Continuing with the MySQLDatabase function
'2.	Declare the function and enter comments on the what the function is doing

Public Function ReadGenreSales () as Boolean
'This function will read Genre Sales data from the MySQL database
'It will place the data in the worksheet named 'Data Sheet'
'It will cycle through the Field headings and use them for column headings in Row 1
'It will then place the data starting at Row 2

'3.	Declare the variables and setup error handling

    'Declare the variables to use
    Dim SQL As String       'To store the SQL statement
    Dim RS As Recordset     'The Recordset variable
    Dim Msg As String       'To display messages
    Dim Counter As Integer  'A counter
    Dim MyNamedRng As Range ' A range variable
    
    'Setup error handling
    On Error GoTo HandleError
    
'4.	Build the SQL statement to read the data 

    'Build the SQL statement to read from the two databases
    SQL = ""
    SQL = SQL & "SELECT "
    SQL = SQL & "genre.Name, "
    SQL = SQL & "Sum(invoiceline.Quantity) AS `Units Sold` "
    SQL = SQL & "FROM "
    SQL = SQL & "genre "
    SQL = SQL & "INNER JOIN track ON track.GenreId = genre.GenreId "
    SQL = SQL & "LEFT JOIN invoiceline ON invoiceline.TrackId = track.TrackId "
    SQL = SQL & "Group BY "
    SQL = SQL & "genre.Name "
    SQL = SQL & "Order BY "
    SQL = SQL & "genre.Name"

'5.	Connect to the server and test it worked

    'Make the connection to the server, test if it was successful
    If ConnectDB_DSNless(g_Conn_DSNless) = True Then
        'Connection succeeded so we can continue processing

'6.	The connection worked so setup the recordset

        'Set the recordset variable
        Set RS = New ADODB.Recordset

'7.	Load the recordset using the SQL and connection

        'Load the recordset, pass in the SQL and the connection to use
        RS.Open SQL, g_Conn_DSNless

'8.	Test there are records to work with

        'Test there are records.
        'A recordset can only be at End Of File and Beginning Of File at the same time when the recordset is empty
        If RS.EOF And RS.BOF Then

'9.	If execution gets in here then there are no records, we need to deal with this situation by telling the user, closing the recordset and leaving the function

            'No data, close the recordset
            RS.Close
            Set RS = Nothing
            
            'tell user and then leave the function
            Msg = "There is no data"
            MsgBox Msg, vbOKOnly + vbInformation, "No data to display"
            Exit Function

'10.	If we get into this part the record test, happy days, we have data so we need to process it

        Else
            'We have data

'11.	We need headings for the data on the worksheet, so for this exercise, we will use the field names. 

            'Insert Field headings for column headings
            'We cycle through the field collection
            For Counter = 0 To RS.Fields.Count - 1
                'Put the fieldname in the cell on row 1
                'When cycling through objects or data, it is easier to refer to the worksheet cells by their numeric values
                Cells(1, 1 + Counter) = RS.Fields(Counter).Name
            Next

'12.	We are done adding the headings, now to add the data. In Excel, we can use the CopyFromRecordset command to copy the entire dataset with one command, too easy

            'Starting at cell in Row 2, Column 1, copy the entire recordset into the worksheet
           Worksheets("Data Sheet").Cells(2, 1).CopyFromRecordset RS

'13.	Set a named range for the data, we use the RS.RecordCount value to calculate how many rows the range should cover

            'Set and create a named range covering the column with the Genre name, data only
            Set MyNamedRng = Worksheets("Data Sheet").Range("A2:A" & RS.RecordCount + 1)
            ActiveWorkbook.Names.Add Name:="Genre", RefersTo:=MyNamedRng

'14.	Now we have our data in place, start closing everything down

            'Close the recordset
            RS.Close
            Set RS = Nothing
            
            'Close the connection
            g_Conn_DSNless.Close
            Set g_Conn_DSNless = Nothing

'15.	And pass back success

            'Pass back success
            ReadGenreSales = True
        End If

'16.	If we get in here after the connection test, then the connection failed so leave the function

    Else
        'Connection failed if gets in here, just drop through to leave
        'The connection routine will have displayed a message so nothing to do but leave
       ReadGenreSales = False
       Exit Function
    End If

'17.	And leave the function

LeaveFunction:
    'Leave the function
    Exit Function
   
'18.	But if we get in here, we have had an error

HandleError:
    'In this sample we are just going to display the error and leave the function
    'you may want to log the error or do something else
    'depending on your requirements
   MsgBox Err & "-" & Error(Err), vbOKOnly + vbCritical, "There was an error"

'19.	Pass back a fail  and leave the function 

    'Pass back Failed
    ReadGenreSales = False
    Resume LeaveFunction
    
'20.	Of course, the End Function has been here all along

End Function
