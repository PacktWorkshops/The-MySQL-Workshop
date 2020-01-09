Public Function TransferData(DatabaseName As String, SQLPrefix As String, Optional Task As String) As Boolean
    
'Task - if ommitted or anything but Transfer = Count records in SQL database only
'       "Transfer" = do transfer of data
    
'---------------------------------------------------------------------------------
'Author:    Tom Pettit
'Date:      27/06/2014
'Purpose:   To transfer data from MS Access database to MySQL database
'
'About This Function:
'
'This function will transfer data from an MS Access database to its SQL Server upgraded version.
'Or count how many records are in the MySQL tables

'For this function to work correctly, the following MUST be observed.
'---------------------------------------------------------------------------------
' ************* PLEASE READ THIS - VERY IMPORTANT *************
'---------------------------------------------------------------------------------
'1) All SOURCE tables (MS Access) must be linked, DO NOT change their names in any way.  You can copy source DB locally if required if small enough
'2) ALL DESTINATION tables (MySQL) must be linked, CHANGE their names linked with a prefix such as 'mysql_' to differentiate them from the Access tables
'3) If a source table does NOT have an AutoNumber field, its SQL counterpart MUST have one added and it MUST be named SQLID and set to Identity and AutoIncrement
'4) If a table has had an SQLID Identity field (3 above) and doe NOT have a Primary Key field set, the SQLID must be set to be the PrimaryKey
'5) Backups have been made (for your own peace of mind)
'---------------------------------------------------------------------------------
        
    'Declare the variable we will use
    Dim RSTables As Recordset   'Our table list
    Dim SQL As String           'to build the SQL statements we will create
    Dim Source As String        'to store the source field name when we work our way through
    Dim HasSQLID As Boolean     'Indicates if the table has an SQLID field...require different processing
    Dim TimeSeconds As Boolean  'So we know how long it took
    Dim StartTime As Date
    Dim DeleteData As Boolean
    Dim Response As Integer
    
    'Set default value for DeleteData flag
    DeleteData = False
        
    'Check if Task is Transfer
    If Task = "Transfer" Then
        'Start the Transfer process
        'Ask user if want to delete SQL data
        Response = MsgBox("Do you want to DELETE ALL DATA from linked MySQL tables?", vbYesNo + vbCritical, "Delete SQL Data")
        'Check response
        If Response = vbYes Then
            'User said Yes...verify this once more
            Response = MsgBox("ALL DATA from linked MySQL tables WILL be DELETED....Are YOU SURE?", vbYesNo + vbCritical, "Verify Delete MySQL Data")
            'Check response again
            If Response = vbYes Then
                'User said Yes again...set flag to delete the data
                DeleteData = True
            End If
        End If
        
        'Start the timer, after first run user will have an idea how long it takes for subsequent runs
        StartTime = Now()
        
        'Are we deleting data?
        If DeleteData = True Then
            'Yes...tell user we are starting the deletion
            Debug.Print "Deleting MySQL data from tables" & vbCrLf
            'call the function to delete the data
            Call EmptyMySQLTables(DatabaseName, SQLPrefix)
        End If
        
        'Now tell user we are starting the data transfer
        Debug.Print "Transferring data from Access tables to MySQL"
    Else
        'Transfer was not passed in so tell user we are counting the MySQL records
        Debug.Print "Counting MySQL table records"
    
    End If
    
    'Get our list of SQL linked tables from the System Objects table, we use the SQLPrefix to identify them
    Set RSTables = CurrentDb.OpenRecordset("SELECT MSysObjects.Name FROM MSysObjects WHERE (((MSysObjects.Name) Like '" & SQLPrefix & "*'));")

    'Just a habit to ensure table reports EOF correctly
    RSTables.MoveLast
    RSTables.MoveFirst
    
    'Clear our SQL variables
    SQL = ""
    Source = ""
    
    'Start processing until end of file for table list
    Do Until RSTables.EOF
        'Set SQLID flag to false at the start of each table
        HasSQLID = False
    
        'Test SQL table is empty
        If DCount("*", RSTables.Fields("Name")) > 0 Then
            'Table has records in it so skip it.  Could get in here for a number of reasons.
            '1. Processing was stopped halway through a run...we don't want to do it again
            '2. Table was not empty to start with, could be list data, lookups, etc.  Ensure this was on purpose
            '   NOTE: To not include list tables and such, don't link them from Access or MySQL and they will not be touched (SAFEST)
            '3. You forgot to clear the SQL tables first....this is left as a separate task to ensure you mean to run this
            
            'Print out to immediate window table name, record count and a message indicating table has data
            Debug.Print RSTables.Fields("Name"), DCount("*", RSTables.Fields("Name")) & " (Already populated)"
        Else
            'Print tablename and record count in debug, semi colon added at end to ensure next print is on same line
            Debug.Print RSTables.Fields("Name"), DCount("*", RSTables.Fields("Name")) & " (Table Empty)";
            
            'Check if we are transferring data
            If Task = "Transfer" Then
                'We are transferring and there are NO records in destination so copy the data
                'Setup Sourcename...the MS Access table.  This is derived from the destination name...minus the dbo_ prefix.
                Source = Replace(RSTables.Fields("Name"), SQLPrefix, "")
                
                'Look through the fields in the destination table and see if we have a field named SQLID
                For counter = 0 To CurrentDb.TableDefs(RSTables.Fields("Name")).Fields.Count - 1
                    If CurrentDb.TableDefs(RSTables.Fields("Name")).Fields(counter).Name = "SQLID" Then
                        'we found an SQLID field, set flag to true and leave the loop
                        HasSQLID = True
                        Exit For
                    End If
                Next
                
                'Make the sql to transfer all data from Source to Destination
                SQL = ""
                SQL = "INSERT INTO " & RSTables.Fields("Name") & " SELECT * FROM " & Source
                
                'Run the query to insert data, SetWarning off so you are not prompted for each table to allow
                'the insert query to run
                DoCmd.SetWarnings False
                DoCmd.RunSQL (SQL)
                DoCmd.SetWarnings True

                
                'Print the table name and record count
                Debug.Print " - " & DCount("*", RSTables.Fields("Name")) & " records transferred"
                
                'Clear our variable
                SQL = ""
                Source = ""
            End If
        End If
    
        'Next table in list
        RSTables.MoveNext
    
    Loop
    
    'Done...close the table list
    RSTables.Close

    'Check if we just did a Transfer, if so then tell user we are done and how long it took
    If Task = "Transfer" Then
        MsgBox "Transfer Completed in " & DateDiff("s", StartTime, Now()) & " Seconds."
    End If
    
    'And get outta here....
    TransferData = True
    

End Function

Public Function RunPassThrough(strSQL As String, strQueryName As String)

'----------------------------------------------------------
'This function will create a passthrough query in the QueryDefs and then run it
'strSQL         - The SQL statement to create
'sqtrQueryName  - The name of the query
'----------------------------------------------------------

    Dim qdfPassThrough As DAO.QueryDef, MyDB As Database
    Dim strConnect As String
    Dim myCounter As Integer
    
    'Set counter
    myCounter = 0
    
    'Set error handling
    On Error GoTo HandleError
    
    'Check if the query allready exists
    If QueryExists(strQueryName) Then
        'It exists...delete the existing query
        CurrentDb.QueryDefs.Delete strQueryName
    End If
    
    'Now create the new query
    Set MyDB = CurrentDb()
    Set qdfPassThrough = MyDB.CreateQueryDef(strQueryName)  'Use the name passed in fr the query
    
    'Use the ODBC setup to the SQL database
    'Change this to whatever you conncetion string is
    strConnect = "ODBC;" & DLookup("Connect", "MSysObjects", "Type=4")
    qdfPassThrough.Connect = strConnect
    'Use the SQL statement passed in for the query
    qdfPassThrough.SQL = strSQL
    'Set the option of returns records based on value passed in
    qdfPassThrough.ReturnsRecords = False
    'Done, close the query
    qdfPassThrough.Close
    
    'Refresh the application window so the new query shows.
    Application.RefreshDatabaseWindow
    
    'This is to ensure the query exists before exiting otherwise the calling routine may have issues
    'this is in case Access is a little slow updating
    Do Until QueryExists(strQueryName) Or myCounter > 1000  'try a maximum of 1000 times
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

Public Function EmptyMySQLTables(DatabaseName As String, SQLPrefix As String) As Boolean
'This function will empty ALL the table in the MySQL database

    'Declare the variables
    Dim PSQL As String
    Dim SQL As String
    Dim RS As Recordset
    
    'Set return value of True as default, if there is an issue this will be changed
    'by the error handler
    EmptyMySQLTables = True
    
    'Prepare a list of Linked data tables
    'Objects listed in the MSysObjects table with a Type of 4 are ODBC linked tables
    SQL = ""
    SQL = SQL & "SELECT MSysObjects.Name "
    SQL = SQL & "FROM MSysObjects "
    SQL = SQL & "WHERE (((MSysObjects.Type)=4)); "
    
    'assign the table list to a recordset
    Set RS = CurrentDb.OpenRecordset(SQL)
    
    'Check there are records (ODBC linked tables)
    If RS.EOF And RS.BOF = True Then
        'No tables
        'Close the recordset
        RS.Close
        Set RS = Nothing
        
        'Tell the user
        MsgBox "There are no ODBC linked tables", vbOKOnly + vbCritical, "There was an error clearing the MySQL data"
            
        'Return a fail
        EmptyMySQLTables = False
        GoTo ExitFunction
    End If
    
    'We have records, position to the first
    RS.MoveFirst
    
    'Set up the PassThrough query commands
    'Begin with instruction to use the database passed in
    'PSQL = "USE " & DatabaseName & ";" & vbCrLf
    
    'Loop through the list of tables and build a DELETE query for each table
    Do Until RS.EOF
        'Create the DELETE query for the current table
        PSQL = "DELETE FROM " & Replace(RS.Fields("Name"), SQLPrefix, "") & vbCrLf
        
        'Create the Passthrough query to delete the data
        Call RunPassThrough(PSQL, "DeleteMySQLData")
        
        'now Execute it.
        CurrentDb.QueryDefs("DeleteMySQLData").Execute
        
        Debug.Print Replace(RS.Fields("Name"), SQLPrefix, "") & " - data has been deleted"
        
        RS.MoveNext
    Loop
    
    'Close the table list
    RS.Close
    
    
    'And leave the function
ExitFunction:
    Exit Function
    
HandleError:

    'Report the error, set a return of Fail and exit function
    MsgBox Err & " " & Error(Err), vbOKOnly + vbCritical, "There was an error clearing the MySQL data"
    EmptyMySQLTables = False
    
    Resume ExitFunction
    
End Function
