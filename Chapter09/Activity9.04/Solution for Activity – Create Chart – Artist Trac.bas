'This code is to go into the Dashboard worksheets General section


'Solution for Activity – Create Chart – Artist Track Sales

Private Sub ArtistTrackSales(ByVal pArtist As String)

            Dim RS As Recordset
            Dim SQL As String
            Dim MyNamedRng As Range
            
            'Clear the target area first
            On Error Resume Next
            Worksheets("Data Sheet").Range("ArtistTrackSales").ClearContents
            On Error GoTo HandleError
            
            If ConnectDB_DSNless(g_Conn_DSNless) = True Then
                'Prepare the SQL
                SQL = ""
                SQL = SQL & "SELECT  TrackName, `Units Sold` "
                SQL = SQL & "FROM vw_artist_track_sales "
                SQL = SQL & "WHERE Name = '" & pArtist & "' "
                SQL = SQL & "ORDER BY `Units Sold` DESC"
                
                'Set the recordset variable
                Set RS = New ADODB.Recordset
                
                'Load the recordset, pass in the SQL and the connection to use
                RS.Open SQL, g_Conn_DSNless
            
                'Test there are records.
                If RS.EOF And RS.BOF Then
                    'No data
                    GoTo Leavesub
                Else
                    'We have data so load it
                    Worksheets("Data Sheet").Cells(2, 12).CopyFromRecordset RS
                    
                    'Set and create a named range covering the column with the Genre name, data only
                    Set MyNamedRng = Worksheets("Data Sheet").Range("L2:M" & RS.RecordCount + 1)
                    ActiveWorkbook.Names.Add Name:="ArtistTrackSales", RefersTo:=MyNamedRng
                    
                End If
            Else
                'This line will be reached if there is no data, we do nothing and drop through                
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
