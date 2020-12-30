Option Compare Database

Public gConnectionString As String

Public Function ConnectString_DSNless() As String
'------------------------------------------
'Author : Tom Pettit
'Web    : https://www.msaccess.guru/
'------------------------------------------
'Usage  : You are granted permission to use and modify this code freely for your
'       : applications. Please retain this notice in the code
'------------------------------------------


'This Function will build the connection string required for the passthrough query's

'Output: String, the connection string

On Error GoTo HandleError
    
    'Declare the variables we will use
    Dim Msg As String
    Dim str As String
    
    'These will be read in from the lookup table
    Dim Driver As String
    Dim Server As String
    Dim Port As String
    Dim Database As String
    Dim UserName As String
    Dim Password As String
    
    'Read in the connection parameters from lookup table
    Driver = DLookup("Value", "lookups", "Key='MySQL Driver'")
    Server = DLookup("Value", "lookups", "Key='MySQL Server'")
    Port = DLookup("Value", "lookups", "Key='MySQL Port'")
    Database = DLookup("Value", "lookups", "Key='MySQL Database'")
    UserName = DLookup("Value", "lookups", "Key='MySQL User Name'")
    Password = DLookup("Value", "lookups", "Key='MySQL User Password'")
    
    
    'Prepare the connection string
    str = "DRIVER={" & Driver & "};"
    str = str & "SERVER=" & Server & ";"
    str = str & "PORT=" & Port & ";"
    str = str & "DATABASE=" & Database & ";"
    str = str & "UID=" & UserName & ";"
    str = str & "PWD=" & Password & ";"
    str = str & "Option=3"
    
    'And pass it back to the caller
    ConnectString_DSNless = str
    
    
    
LeaveFunction:
    'and leave
    Exit Function
    
HandleError:
    
    'There was a problem, tell the user and include the error number and message
    Msg = "There was an error - " & Err & " - " & Error(Err)
    MsgBox Msg, vbOKOnly + vbCritical, "Problem creating the Connection String"
    
    'Pass back a False to signify there was an issue to the calling code
    ConnectDB_DSNless = ""
    
    'Leave the function
    Resume LeaveFunction

End Function


Public Function CreatePassThrough(strSQL As String, strQueryName As String, ReturnRecords As Boolean, Optional Recreate As Boolean = True)
'------------------------------------------
'Author : Tom Pettit
'Web    : https://www.msaccess.guru/
'------------------------------------------
'Usage  : You are granted permission to use and modify this code freely for your
'       : applications. Please retain this notice in the code
'------------------------------------------

'----------------------------------------------------------
'This function will create a passthrough query in the QueryDefs
'
'strSQL         - The SQL statement to create, this must be formed to run on MySQL so must use SQL syntax
'sqtrQueryName  - The name of the query
'ReturnRecords  - Does the statement return records? Set to False if the SQL passed in is to perform a task and not return records or values otherwise set to True
'Recreate       - This will delete the existing query and rebuild it
'----------------------------------------------------------

    Dim qdfPassThrough As DAO.QueryDef, MyDB As Database
    Dim strConnect As String
    Dim myCounter As Integer
        
    'Set counter
    myCounter = 0
    
    'Set error handling
    On Error GoTo HandleError
    
    'Test the query exists, in case Recreate is set to false and the query does not exists
    'which will cause an error
    If QueryExists(strQueryName) = False Then
        'Override the passed in parameter and create the passthrough
        Recreate = True
    End If
    
    'Test if creating the PT query or just editing the SQL
    If Recreate Then
        'Check if the query allready exists
        If QueryExists(strQueryName) Then
            'It exists...delete the existing query
            CurrentDb.QueryDefs.Delete strQueryName
        End If
        
        'Now create the new query
        Set MyDB = CurrentDb()
        Set qdfPassThrough = MyDB.CreateQueryDef(strQueryName)  'Use the name passed in for the query
        
        'Use the ODBC setup to the SQL database
        'Check if the Connection String has been created
        If gConnectionString = "" Then
            'No, create it
            gConnectionString = "ODBC;" & ConnectString_DSNless
        End If
        
        'Set the passthrough query's connection string
        qdfPassThrough.Connect = gConnectionString
        
        'Set the option of returns records based on value passed in
        qdfPassThrough.ReturnsRecords = ReturnRecords
    Else
        'Not recreating so only update the SQL
        'We do not need to perform the above Recreate tasks
        Set MyDB = CurrentDb()
        Set qdfPassThrough = MyDB.QueryDefs(strQueryName)  'Use the name passed in for the query
    End If
    
    
    'Use the SQL statement passed in for the query
    qdfPassThrough.SQL = strSQL
    
    'Done, close the query
    qdfPassThrough.Close
    
    'Refresh the application window so the new query shows.
    Application.RefreshDatabaseWindow
    
    'This is to ensure the query exists before exiting otherwise the calling routine may have issues
    'this is in case Access is a little slow updating
    Do Until QueryExists(strQueryName) Or myCounter > 1000  'try a maximum of 1000 times, should not get anywhere near that
        'Increment coutner
        myCounter = myCounter + 1
    Loop
    
    'All finished...leave
    Exit Function
    
HandleError:

    MsgBox Err & " - " & Error(Err)
    Exit Function
    Resume
End Function

Public Function QueryExists(QueryName As String) As Boolean
'----------------------------------------------------------
'This function will accept a queryname and check if it exists
'It will return a True if it exists, a False if not.
'Used by the CreatePassThrough function but can be used by any function where you need to determine the existance
'of a query
'----------------------------------------------------------
    On Error GoTo HandleError

    'Set default return value
    QueryExists = False

    'Check if the query exists
    If Not IsNull(CurrentDb.QueryDefs(QueryName).SQL) Then
        'Yes, pass back a true
        QueryExists = True
    End If

    Exit Function

HandleError:

    QueryExists = False
    

End Function