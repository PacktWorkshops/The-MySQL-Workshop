'This code is to go into the MySQLDatabase module


'Exercise – Creating a Connection Function
'1.	Continuing in the MySQLDatabase module, enter the following line after the variable declarations

Public Function ConnectDB_DSNless(oConn As ADODB.Connection) As Boolean 

'Note: VBA will add the End Function statement, be sure to add all of the following commands between the functions declaration and End Function. It will also add a line immediately under variable 'declarations, these lines will be added between functions and subs, they provide an easy way to see where the functions begin and end, especially when you scroll up and down the code
'2.	Add some comments on what the function does. This is for your benefit to jog the memory and for other developers who may need to modify the code at a later stage
'This Function will create a DSNless connection and assign it to the
'input variable.
'
'Input: oConn, ADODB.Connection variable to assign the connection to
'Output: Boolean, Success (True) or Failure (False)

3.	Add and error handler instruction and declare some variables to use

On Error GoTo HandleError
    
    'Declare the variables we will use
    Dim Msg As String
    Dim str As String

'4.	Set the connection variable to a new variable, until now it has just been a declaration, this will set it as an actual connection type 

    'Set the passed in connection variable to a new connection
    Set oConn = New ADODB.Connection

    'Use the Client cursor so we can read the number of records returned
    oConn.CursorLocation = adUseClient

'5.	Enter the following lines, as in previous chapters, fill in your specific details for ServerIP, User and Password. Be sure to take out the <> as well. Note that each of the parameters are separated by 'a semi-colon and no spaces.
 
    'Prepare the connection string
    str = "DRIVER={MySQL ODBC 5.3 Unicode Driver};"
    str = str & "SERVER=<Server IP Address>;"
    str = str & "PORT=3306;"
    str = str & "DATABASE=<Database name>;"
    str = str & "UID=<User ID or Account Name>;"
    str = str & "PWD=<Password>;"
    str = str & "Option=3"


'Note: Option=3 is a server directive. It is optional however leaving it out could cause issues with reading the data on some databases. If you do leave it out, be sure to remove the Semi-colon from the 'previous statement
'6.	Now open the connection. If there is an error, the code will jump to the error handler as defined earlier in the code, otherwise it will continue with the next statement

    'Open the connection, if there is a problem, it will happen here
    oConn.Open str

'7.	If the connection was made, then we will get to here, pass back a True, so the calling routine knows the connection was successful
    'No problem, good, pass back a True to signify connection was successful
 
    ConnectDB_DSNless = True

'8.	Declare a sub routine to exit the function, and the error handler will then have a point to resume to to exit the function. Immediately followed by an actual Exit Function. At this point the Function 'will terminate.

LeaveFunction:
    'and leave
    Exit Function

'9.	Declare the errorHandler sub routine to handle any errors, in here we are preparing a message to the user with the error number and description included and displaying it.

HandleError:
    
    'There was a problem, tell the user and include the error number and message
    Msg = "There was an error - " & Err & " - " & Error(Err)
    MsgBox Msg, vbOKOnly + vbCritical, "Problem Connecting to server"

'10.	After the user has clicked OK, pass back a False to the calling routine to indicate failure to connect then resume code at the LeaveFunction sub routine to exit. The End Function will already be 'there, don’t put it in twice.
    'Pass back a False to signify there was an issue to the calling code
    ConnectDB_DSNless = False
    
    'Leave the function
    Resume LeaveFunction

End Function
