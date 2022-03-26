'This code is to go into the MySQLDatabase module


'Exercise – Create the Named DSN Connection function
'In this exercise we will create a function to connect to the database using a Named DSN
'Using the module MySQLDatabase, start a new function with two parameters, a connection variable and a string to pass in the name of the Named ODBC. The function will return a Boolean value

Public Function ConnectDB_ODBC(oConn As ADODB.Connection, ODBCName As String) As Boolean

'1.	Setup error handling and declare the variables we will use

On Error GoTo HandleError
    
    Dim Msg As String
    Dim str As String
    
'2.	Setup the connection variable. With Named ODBC it is important to tell the connection which cursor to use, we need to use the client cursor otherwise we will not get the data back as we expected

    'Set the passed in connection variable to a new connection
    Set oConn = New ADODB.Connection
    oConn.CursorLocation = adUseClient
    
'3.	Now we prepare the connection string, this is simply, we use the string we passed in representing the name of the Named DSN. An advantage of this method is we can pass in any Named DSN we have 'available so it is very flexible. This method is very simple compared to DSNless

    'Prepare the connection string
    str = "DSN=" & ODBCName & ";"
    
'4.	Now we open the connection passing in the connection string we just built
    'Open the connection, if there is a problem, it will happen here

    oConn.Open str

'5.	And the rest is the same as the DSNLess connection, returning to a value to indicate success and handling errors

    'No problem, good, pass back a True to signify connection was successful
    ConnectDB_ODBC = True
        
LeaveFunction:
    'and leave
    Exit Function
    
'6. Include error handling
HandleError:
    'There was a problem, tell the user and include the error number and message
    Msg = "There was an error - " & Err & " - " & Error(Err)
    MsgBox Msg, vbOKOnly + vbCritical, "Problem Connecting to server"
    
    'Pass back a False to signify there was an issue to the calling code
    ConnectDB_ODBC = False
    
    'Leave the function
    Resume LeaveFunction

'7. Close off the function block
End Function

'And we are done, we cannot test this until we create a routine to use it, we will do that in the next exercise
