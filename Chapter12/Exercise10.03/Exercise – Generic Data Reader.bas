'Exercise – Generic Data Reader
'This code is to go into the MySQLDatabase module

'In this exercise, we will create a single function that you can use to query the database and return a single value only. You will pass in an SQL statement to be executed and the result will be returned. 'We will then demonstrate its use by populating cells N8, N9 and N12 in the Dashboard worksheet

'1.	In the MySQLDatabase module, add a new function. The function will have one parameter, SQL, a string and it will return a Variant type value. Because we do not know what type of value is to be 'returned, a variant type will allow any data type

Public Function runSQL_SingleResult(SQL As String) As Variant

'2.	Declare the variables to use and also setup error handling

    Dim RS As Recordset     'The Recordset variable
    Dim Msg As String       'To display messages

    On Error GoTo HandleError

'3.	Make the connection to the database, we will be using the Named DSN connector and passing in the DSN name to use

    If ConnectDB_ODBC(g_Conn_ODBC, "chinook") = True Then

'4.	Prepare and open the recordset variable RS, pass in the SQL statement that was passed into the function using the ODBC connection

        Set RS = New ADODB.Recordset
        RS.Open SQL, g_Conn_ODBC

'5.	Test there was a record returned, if not then close the recordset and connection and return a zero before leaving the function

        If RS.EOF And RS.BOF Then
            RS.Close
            Set RS = Nothing
            
            Msg = "There is no data"
            MsgBox Msg, vbOKOnly + vbInformation, "No data to display"
            runSQL_SingleResult = 0
            Exit Function

'6.	If there was a record returned, set the position to the first record and read the value and pass it back by assigning it to the function. Because this function accepts an SQL, we have no idea what the 'fields name maybe, as we expect only one single value to be returned, we can simply read the first (and only) fields value by referring to it using its numeric value of zero

        Else
            RS.MoveFirst
            runSQL_SingleResult = RS.Fields(0)

'7.	We then close the recordset, connection and make our way out of the function, in the error routine we pass back a zero.

            RS.Close
            Set RS = Nothing
        End If
        
        g_Conn_ODBC.Close
        Set g_Conn_ODBC = Nothing
        
    Else
    End If

LeaveFunction:
    Exit Function
    
HandleError:
    runSQL_SingleResult = 0
    Resume LeaveFunction
End Function
