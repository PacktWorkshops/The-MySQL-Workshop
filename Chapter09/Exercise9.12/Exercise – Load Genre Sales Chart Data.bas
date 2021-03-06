'This code is to go into the Dashboard worksheets General section

'Exercise – Load Genre Sales Chart Data

'We will be placing the code in the Dashboard worksheet
'1.	Open the VBA IDE
'2.	In the project panel,  locate and Double-Click on the Dashboard worksheet to open the worksheets VBA window
'3.	Move your cursor to the end of any existing code to start entering the following code
'4.	Declare the private subroutine, we are going to pass in the selected genre name as a string so declare the parameter as well. This is a subroutine so it will not be returning any values

Private Sub GenreSales(ByVal pGenre As String)

'5.	Declare the variable we will be using

            Dim RS As Recordset
            Dim SQL As String
            Dim MyNamedRng As Range

'6.	Start by clearing an existing range data from the location we are going to insert the data. The first time this sub is run, the range does not exists and will cause and error so before attempting to 'clear the range, we ignore errors. After the range is cleared, we start normal error checking.

On Error Resume Next           
Worksheets("Data Sheet").Range("GenreSales").ClearContents

On Error GoTo HandleError            

'7.	Connect to the database, if the connection was successful start processing

            If ConnectDB_DSNless(g_Conn_DSNless) = True Then

'8.	Prepare the SQL statement, we have a view in the database compiling the data so we only need to filter to the genre passed in and select the fields we want to display

                SQL = ""
                SQL = SQL & "SELECT SaleMonth, `Units Sold` "
                SQL = SQL & "FROM vw_genresales "
                SQL = SQL & "WHERE Name = '" & pGenre & "' "
                SQL = SQL & "ORDER BY SaleMonth ASC"
                
'9.	The next code sets the record set variable and opens the record set with the connection

                Set RS = New ADODB.Recordset
                RS.Open SQL, g_Conn_DSNless
            
                'Test there are records.
                If RS.EOF And RS.BOF Then
                    'No data
                    Exit Sub
                Else

'10.	We load the data into the “Data Sheet” starting at row 2, column 5
                    Worksheets("Data Sheet").Cells(2, 5).CopyFromRecordset RS

'11.	We load the data into the “Data Sheet” starting at row 2, column 5

'Set and create a named range covering new data
                    Set MyNamedRng = Worksheets("Data Sheet").Range("E2:F" & RS.RecordCount + 1)
                    ActiveWorkbook.Names.Add Name:="GenreSales", RefersTo:=MyNamedRng

'12.	The rest of the code finalizes the routine including error handling

                End If
            Else
            End If

Leavesub:
    'Close recordset
    RS.Close
    Set RS = Nothing
    Exit Sub

HandleError:
    
    MsgBox Err & " " & Error(Err)
    Resume Leavesub
End Sub
