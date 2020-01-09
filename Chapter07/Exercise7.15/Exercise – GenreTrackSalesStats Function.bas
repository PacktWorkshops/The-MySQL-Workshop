'This code is to go into the MySQLDatabase module

'Exercise – GenreTrackSalesStats Function

'1.	In the module MySQLDatabase, create a new function as below. The function will return a Boolean value to indicate success or failure.

Public Function GenreTrackSalesStats() As Boolean

'2.	Declare the variables we will use and also error handling

    Dim SQL As String       'To store the SQL statement
    Dim RS As Recordset     'The Recordset variable
    Dim Msg As String       'To display messages
    Dim Counter As Integer  'A counter
    Dim MyNamedRng As Range ' A range variable

    On Error GoTo HandleError
    
'3.	Prepare the SQL statement. The SQL combines two views to retrieve our data

    SQL = ""
    SQL = SQL & "SELECT "
    SQL = SQL & "vw_genre_count.Count  - vw_genre_count_no_sales.Count AS Sales, "
    SQL = SQL & " vw_genre_count_no_sales.Count AS NoSales, "
    SQL = SQL & "vw_genre_count.Genre "
    SQL = SQL & "FROM "
    SQL = SQL & "vw_genre_count "
    SQL = SQL & "LEFT JOIN vw_genre_count_no_sales ON vw_genre_count_no_sales.Genre = vw_genre_count.Genre "
    SQL = SQL & "Order BY "
    SQL = SQL & "vw_genre_count.Genre"

'4.	Now we call the new ODBC connection function. The difference between this and the DSNless connection is here we are using the global ODBC variable and also passing in the name of the DSN we want to 'use. You can use this function with any Named DSN

    If ConnectDB_ODBC(g_Conn_ODBC, “chinook”) = True Then

'5.	Set the recordset variable and open the recordset, passing in the SQL and the global ODBC variable

        Set RS = New ADODB.Recordset
        RS.Open SQL, g_Conn_ODBC
    
'6.	Test we have data and deal with a no data situation

        If RS.EOF And RS.BOF Then
            RS.Close
            Set RS = Nothing
            Msg = "There is no data"
            MsgBox Msg, vbOKOnly + vbInformation, "No data to display"
            GoTo LeaveFunction

'7.	Else if we have, process it, start by setting the column headings. We are placing the data in columns H, I and J

        Else
            For Counter = 0 To RS.Fields.Count - 1
                Worksheets("Data Sheet").Cells(1, 8 + Counter) = RS.Fields(Counter).Name
            Next
            Worksheets("Data Sheet").Cells(2, 8).CopyFromRecordset RS
            
'8.	Create the Named Range for the data. Columns H and I contain the data for the two series in the chart

            Set MyNamedRng = Worksheets("Data Sheet").Range("H2:I" & RS.RecordCount + 1)
            ActiveWorkbook.Names.Add Name:="Sales", RefersTo:=MyNamedRng

            Set MyNamedRng = Worksheets("Data Sheet").Range("J2:J" & RS.RecordCount + 1)
            ActiveWorkbook.Names.Add Name:="TrackStatGenre", RefersTo:=MyNamedRng
            
'9.	Close the recordset and connection

            RS.Close
            Set RS = Nothing
            g_Conn_ODBC.Close
            Set g_Conn_ODBC = Nothing
            
'10.	Now we want to set some options in the chart so we activate the chart

            Worksheets("Dashboard").ChartObjects("TrackStats").Activate
            With ActiveChart
                .HasTitle = True
                .ChartTitle.Text = "Genre Tracks Sales vs. No Sales"

'11.	Set the charts data source and category to the Named Ranges we defined and also set the series names

                .SetSourceData Source:=Worksheets("Data Sheet").Range("Sales"), PlotBy:=xlColumns
                .Axes(xlCategory).CategoryNames = Worksheets("Data Sheet").Range("TrackStatGenre")

                .SeriesCollection(1).Name = "Sales"
                .SeriesCollection(2).Name = "No Sales"
            End With
            GenreTrackSalesStats = True
        End If

'12.	From here we handle failed connection and exit the function

    Else
        'Connection failed if gets in here, just drop through to leave
    End If

LeaveFunction:
    'Leave the function
    Exit Function
    
HandleError:
    GenreTrackSalesStats = False
    Resume LeaveFunction
    
End Function
