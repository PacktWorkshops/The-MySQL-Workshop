Option Compare Database


Public gConnectionString As String

Public Function WriteFormData(ByRef myForm As Form, RecordSet As String, ByRef OldValues As Variant, Table As String, TheFilter As String) As String
'------------------------------------------
'Author : Tom Pettit
'Web    : https://www.msaccess.guru/
'------------------------------------------
'Usage  : You are granted permission to use and modify this code freely for your
'       : applications. Please retain this notice in the code
'------------------------------------------

'Inputs to function
'myForm = The form passed in
'Recordset = the query usd to populate the form originally
'OldValues = Reference to the forms OldValue array, this holds the forms originally loaded values
'Table = The table to update
'TheFilter = The filter to return the record, this is used to load the current data from the database to check for Write Conflicts

'Outputs from function
'String value containing a status message for the calling routine


'This function will accept a reference to a form and an SQL statement
'It will then load the recordset and cycle through all the recordset fields and store the
'fields value into a the database.
'The recordset is filtered to the record we are updating

    '1. Declare the variables
    Dim RS As DAO.RecordSet     'Recordset for checking for Write Conflict
    Dim myField As DAO.Field    'To cycle through the recordset fields
    Dim NewValue As String      'Storage for new value when processing
    Dim Msg As String           'To message the user
    Dim WCMessage As String     'For the WriteConflict message if there is one
    Dim WCMessageFile As String 'To write the Write Conflict to a disk file if required
    Dim DoSave As Boolean       'Flag to indicate Save will be performed
    Dim ArrayPosition As Long   'Pointer in array where the field appears
    
    Dim UpdateString As String  'To build the update fields and values for changes
     
    '2. Initiate the update string
    UpdateString = ""
    
    '3. Set up error handling
    On Error GoTo HandleError
    
        'Reload the record from the database so we can check it is the same as the original record
        'If any fields from the original load are different to this load then someone else has changed the record
        'since we originally loaded it
        'so we have a Write Conflict situation
        Set RS = CurrentDb.OpenRecordset(RecordSet)
        
        '4. Check we have a record to edit
        If RS.BOF And RS.EOF Then
            '5. No...set function as false and leave function
            WriteFormData = False
            GoTo LeaveFunction
        Else
            '6. Yes, move to first record...shold only have one record anyway
            RS.MoveFirst
            
            '7. Prepare file message string
            WCMessageFile = ""
            
            '8. Cycle through each field in the recordset
            For Each myField In RS.Fields
                '9. Check the fields, some we don't want or cannot touch
                Select Case myField.Name
                    Case "TimeStamp", "AutoNumb"
                        '10. Ignore these system maintained fields
                        
                        'If you have any fields that are dealt with by other code you can include a case statement to ignore them as well
                        
                    Case Else
                        '11. Do these, these fields are what the user may change
                        
                        '12. Check if the field is an autonumber field
                        If myField.Attributes And dbAutoIncrField Then
                            '13. Is an autonumber field so don't try to update it, drop out to do next field
                        Else
                            '14. Compare the recordsets field to the equivalent form fields values
                            '   we only want to update fields that have been changed
                            '   Check if user has modified record
                            
                            '15.Find the field in the array and return its position
                            ArrayPosition = IsInArray(myField.Name, OldValues)
                            
                            '16. Test we found the field in the array
                            If ArrayPosition = -1 Then
                                '17. Couldn't find it so move to next field...the field in the recordset is not on the form
                                GoTo NextField
                            End If
                            
                            '18. Do the actual check for changes
                            If Nz(myForm.Controls(myField.Name).Value, "") <> Nz(OldValues(ArrayPosition, 0), "") Then
                                '19. Values are different so has been modified..we want to update this field
                                'but first check if OldValue of field is same as current value we just read in.
                                'If it is NOT the same, there is a write conflict with another user
                                
                                '20. Check for Write Conflict, if no one else has changed the record then both values should be the same
                                If Nz(OldValues(ArrayPosition, 0), "") <> Nz(myField.Value, "") Then
                                    '21. WriteConflict, someone else has updated the fields value since  you opened the form
                                    '   Prepare the message for user
                                    WCMessage = "Another user has modified the field - " & myField.Name & " - since you opened this record." & vbCrLf & vbCrLf
                                    WCMessage = WCMessage & "Value when you opened the form" & vbCrLf
                                    WCMessage = WCMessage & Nz(OldValues(ArrayPosition, 0), "") & vbCrLf & vbCrLf
                                    WCMessage = WCMessage & "Value you modified it to" & vbCrLf
                                    WCMessage = WCMessage & Nz(myForm.Controls(myField.Name).Value, "") & vbCrLf & vbCrLf
                                    WCMessage = WCMessage & "Current value in database (other users changes)" & vbCrLf
                                    WCMessage = WCMessage & Nz(myField.Value, "") & vbCrLf & vbCrLf & vbCrLf
                                    WCMessage = WCMessage & "Select YES to save YOUR changes" & vbCrLf
                                    WCMessage = WCMessage & "Select NO to keep THEIR changes" & vbCrLf & vbCrLf
                                    WCMessage = WCMessage & "Your selection will apply to this field only."
                                    
                                    '22. Check if there is already a message for the user
                                    If WCMessageFile = "" Then
                                        '23. No, First time adding message so add a header
                                        WCMessageFile = "WRITE CONFLICT details" & vbCrLf & vbCrLf
                                        WCMessageFile = WCMessageFile & "Form: " & myForm.Name & vbCrLf
                                        WCMessageFile = WCMessageFile & "=========================================" & vbCrLf
                                    End If
                                    
                                    '24. add message to end of MessageFile
                                    WCMessageFile = WCMessageFile & WCMessage & vbCrLf
                                    WCMessageFile = WCMessageFile & "=========================================" & vbCrLf
                                    
                                    '25. Message user about conflict and get response
                                    Select Case MsgBox(WCMessage, vbYesNo + vbQuestion, "Write Conflict ([" & myField.Name & "])")
                                        Case vbYes
                                            '26. User chose to overwrite database value
                                            DoSave = True
                                        Case vbNo
                                            '27. User chose keep database value, this is for this field only, other fields will still be processed
                                            DoSave = False
                                    End Select
                                    
                                Else
                                    '28. No Write Conflict on the field, allow save to proceed
                                    DoSave = True
                                End If
                            
                                '29. Perform save operation if we have the go ahead to perform the save, do it
                                If DoSave = True Then
                                     '30. Store the value into NewValue...we will use these later
                                     NewValue = Nz(myForm.Controls(myField.Name).Value, "")
                                    
                                    '31. Check if other changes have been set for writing, if yes then add a coma
                                    If UpdateString <> "" Then
                                       UpdateString = UpdateString & ", "
                                    End If
                                    
                                    '32. Add the fieldname and an = to the string. Fieldname is surround by backticks in case of spaces
                                    UpdateString = UpdateString & "`" & myField.Name & "`="
                                    
                                    '33. Check the type of field we are looking at
                                     Select Case myField.Type
                                         Case 10, 12 'text, memo and hyperlink
                                             '34. Add the value to the updatestring, this is a text field so wrap it in quotes
                                            UpdateString = UpdateString & "'" & NewValue & "'"
                                         Case 8  'Date
                                            '35. Add the value to the updatestring, the date can be formatted if required
                                            UpdateString = UpdateString & "'" & NewValue & "'"
                                             
                                         Case Else
                                             '36. Is a numeric value then so determine value and record it
                                             UpdateString = UpdateString & Val(NewValue)
                                     End Select
                                '37. Back out of the IF statements
                                End If
                            End If
                        End If
                '38. Back out of the Select statement
                End Select
NextField:
                '39. Reset new value and do next field
                NewValue = ""
            '40. Go back for next field
            Next
        '41. End main if
        End If
        
        '42. Close recordset now we have cycled through all the fields
        RS.Close
    
        '43. Check if there have been changes set for writing
        If UpdateString <> "" Then
            '44. There are changes so build the update query
            UpdateString = "UPDATE " & Table & " SET " & UpdateString & " WHERE " & TheFilter
            
            '45. Create a temporary passthrough query to write the data
            Call CreatePassThrough(UpdateString, "TempUpdate", False)
            
            '46. Execute the passthrough query to do the updates
            CurrentDb.Execute "TempUpdate"
            
            '47. Remove the passthrough query. We do not want to leave update queries laying around
            'in case they are accidentally executed in the panel
            CurrentDb.QueryDefs.Delete "TempUpdate"
        
            '48. Tell user the changes are saved
            WriteFormData = "Changes have been saved"
            
        Else
            '49. There were no changes set in the update string so tell user nothing to save and leave the function
            WriteFormData = "No changes were made, nothing to write"
            GoTo LeaveFunction
        End If
    
        '50. Check if need to create a Write Conflict log
        If WCMessageFile <> "" Then
            '51. We have Write Conflict messages so save them to file, declare the variables
            Dim myFileName As String
            Dim fso As Object
            Dim Fileout As Object
            
            '52. Build the filename to log the write conflict to
            myFileName = DLookup("Value", "Lookups", "Key='SystemLogs'") & "WRITE CONFLICT - " & gCurrentUserName & " - " & myForm.Name & " - " & Format(Now(), "YYYYMMDD HHnn") & ".txt"
            
            '53. Prepare and write out the file
            Set fso = CreateObject("Scripting.FileSystemObject")
            Set Fileout = fso.CreateTextFile(myFileName, True, True)
            Fileout.Write WCMessageFile
            Fileout.Close
                    
            '54. open the file for user to view
            Shell (myFileName)
        End If
    
'55. Set exit point
LeaveFunction:
    Exit Function
    
HandleError:
    'Handle errors
    Select Case Err
        Case 2424, 2465   'Cant find field..
            '56. Can't find these fields so ignore an go for next field
            Resume NextField
        Case Else
            '57. Log the error
            Call LogError(Err, Error(Err), "WriteFormData", myForm.Name & " - " & RecordSet, True)
            
            '58. Pass back write error
            WriteFormData = "There was an error saving changes - " & Err & " - " & Error(Err)
            
            '59. Leave the function
            GoTo LeaveFunction
    End Select
End Function

Public Function IsInArray(stringToBeFound As String, Arr As Variant) As Long
'------------------------------------------
'Author : Tom Pettit
'Web    : https://www.msaccess.guru/
'------------------------------------------
'Usage  : You are granted permission to use and modify this code freely for your
'       : applications. Please retain this notice in the code
'------------------------------------------

'Inputs
'StringToBeFound, the string to search for, will be a fieldname in this application
'Arr, the array the details are stored in

'Output
'Long, the position within the array the string was found, -1 if not found

    '1. Declare variables
  Dim i As Long
  
  '2. Set default return value if value not found in array
  IsInArray = -1

  '3. Cycle through the array elements
  For i = LBound(Arr) To UBound(Arr)
    '4. Check the 1 element for each loop through
    If StrComp(stringToBeFound, Arr(i, 1), vbTextCompare) = 0 Then
      '5. If found then set the position and leave...no need to waste time continuing
      IsInArray = i
      Exit For
    End If
    '6. Next element
  Next i
  
  '7. If gets to here the value will still be -1 so drop out, not found
  
End Function

Public Function PopulateForm(ByRef myForm As Form, ByVal RecordSet As String, ByRef OldValues As Variant, Optional DontLock As Boolean = False) As Boolean
'------------------------------------------
'Author : Tom Pettit
'Web    : https://www.msaccess.guru/
'------------------------------------------
'Usage  : You are granted permission to use and modify this code freely for your
'       : applications. Please retain this notice in the code
'------------------------------------------

'This function will accept a reference to a form and an SQL statement
'It will then load the recordset and cycle through all the recordset fields and store the
'fields value into a textbox on the form with the same name as the field.

'To ensure the function will work with a form.
'1. Create the form with a wizard, dropping all required fields on the form
'2. Ensure all textboxes have the same name as their corresponding field (wizard will do this)
'3. Remove all ControlSources for all the controls bound to the recordset
'4. Call this function passing in the form and the SQL your code has built to filter to a given record


'The form is now disconnected from the underlying recordset ensuring no changes are automatically updated
'Data is updated by user clicking a Save button and code calling function SaveFormData

    '1. Declare variables
    Dim RS As DAO.RecordSet
    Dim myField As DAO.Field
    Dim KeyField As String
    Dim Ctrl As Control
    
    '2. Set up error handling
    On Error GoTo HandleError
        '3. Open recordset passed in
        Set RS = CurrentDb.OpenRecordset(RecordSet, dbOpenSnapshot)
        
        'Before we start loading, OldValue array
        'we are going to load this array with the data so we can compare to database
        'before updating to determin if user has modified the fields data and write conflicts. We need to do this because Unbound form fields do not have OldValue property
        'We will use OrdinalPosition to determin which element fields value goes into
        'As we are using exact same SQL for opening the recordset for writing later we are assuming the positions will be the same
        'when comparing
        
        '4. Test we have data
        If RS.BOF And RS.EOF Then
            '5. No data, leave
            PopulateForm = False
            GoTo ExitFunction
        Else
            '6. We have data, position to first record
            RS.MoveFirst
            
            '7. Cycle through each field in the recordset
            For Each myField In RS.Fields
                '8. Assign the value from the recordset to the control with the same name
                
                '9. Ensure the control is not locked
                myForm.Controls(myField.Name).Locked = False
                
                '10. Assign the value from the record to the control
                myForm.Controls(myField.Name).Value = Nz(myField.Value, "")
                
                '11. Record fieldname and value for Write Conflict comparison later when writing back to database
                OldValues(RS.Fields(myField.Name).OrdinalPosition, 0) = myField.Value
                OldValues(RS.Fields(myField.Name).OrdinalPosition, 1) = myField.Name
            Next
        End If
                
        '12. If got here then no errors, set return value to true
        PopulateForm = True
    
'13. Set exit point
ExitFunction:
        '14. Close the recordset
        RS.Close
        Exit Function
    
HandleError:
    '15. Handle any errors
    Select Case Err
        Case 91
            '16. If recordset is closed will come in here to stop endless loop, Log and Exit function
            Call LogError(Err, Error(Err), "Populate Form", myForm.Name & " - " & RecordSet, True)
            PopulateForm = False
            Exit Function
        Case 2465
            '17. Cant find control with the field name. Ignore and do next field
            Resume Next
        Case 438, 2448
            '18. Object doesn't support this property or method. Ignore and do next field
            Resume Next
        Case Else
            '19. Log al othe errors and leave
            Call LogError(Err, Error(Err), "Populate Form", myForm.Name & " - " & RecordSet, True)
            PopulateForm = False
            Resume ExitFunction
    End Select
    
    '20. Leave
    Exit Function
End Function



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
    
    '1. Declare the variables we will use
    Dim Msg As String
    Dim str As String
    
    '2. These will be read in from the lookup table
    Dim Driver As String
    Dim Server As String
    Dim Port As String
    Dim Database As String
    Dim UserName As String
    Dim Password As String
    
    '3. Read in the connection parameters from lookup table
    Driver = DLookup("Value", "lookups", "Key='MySQL Driver'")
    Server = DLookup("Value", "lookups", "Key='MySQL Server'")
    Port = DLookup("Value", "lookups", "Key='MySQL Port'")
    Database = DLookup("Value", "lookups", "Key='MySQL Database'")
    UserName = DLookup("Value", "lookups", "Key='MySQL User Name'")
    Password = DLookup("Value", "lookups", "Key='MySQL User Password'")
    
    
    '4. Prepare the connection string
    str = "DRIVER={" & Driver & "};"
    str = str & "SERVER=" & Server & ";"
    str = str & "PORT=" & Port & ";"
    str = str & "DATABASE=" & Database & ";"
    str = str & "UID=" & UserName & ";"
    str = str & "PWD=" & Password & ";"
    str = str & "Option=3"
    
    '5. And pass it back to the caller
    ConnectString_DSNless = str
    
    
'7. Exit point
LeaveFunction:
    
    Exit Function
    
HandleError:
    
    '7. There was a problem, tell the user and include the error number and message
    Msg = "There was an error - " & Err & " - " & Error(Err)
    MsgBox Msg, vbOKOnly + vbCritical, "Problem creating the Connection String"
    
    '8. Pass back a False to signify there was an issue to the calling code
    ConnectDB_DSNless = ""
    
    '9. Leave the function
    Resume LeaveFunction
End Function


Public Function CreatePassThrough(strSQL As String, strQueryName As String, ReturnRecords As Boolean)
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

    '1. Declare variables
    Dim qdfPassThrough As DAO.QueryDef, MyDB As Database
    Dim strConnect As String
    Dim myCounter As Integer
        
    '2. Initiate counter
    myCounter = 0
    
    '3. Set error handling
    On Error GoTo HandleError
    
    '4. Check if the query allready exists
    If QueryExists(strQueryName) Then
        '5. It exists...delete the existing query
        CurrentDb.QueryDefs.Delete strQueryName
    End If
    
    '6. Now create the new query
    Set MyDB = CurrentDb()
    Set qdfPassThrough = MyDB.CreateQueryDef(strQueryName)  'Use the name passed in for the query
    
    '7. Use the ODBC setup to the SQL database, check if the Connection String has been created
    If gConnectionString = "" Then
        '8. No, create it
        gConnectionString = "ODBC;" & ConnectString_DSNless
    End If
    
    '9. Set the passthrough query's connection string
    qdfPassThrough.Connect = gConnectionString
    
    '10. Set the option of returns records based on value passed in
    qdfPassThrough.ReturnsRecords = ReturnRecords
    
    '11. Use the SQL statement passed in for the query
    qdfPassThrough.SQL = strSQL
    
    '12. Done, close the query
    qdfPassThrough.Close
    
    '13. Refresh the application window so the new query shows.
    Application.RefreshDatabaseWindow
    
    '14. This is to ensure the query exists before exiting otherwise the calling routine may have issues this is in case Access is a little slow updating
    Do Until QueryExists(strQueryName) Or myCounter > 1000  'try a maximum of 1000 times, should not get anywhere near that
        '15. Increment counter
        myCounter = myCounter + 1
    Loop
    
'16. Exit point
LeaveFunction:
    
    Exit Function
    
HandleError:
    
    '17. There was a problem, tell the user and include the error number and message
    Msg = "There was an error - " & Err & " - " & Error(Err)
    MsgBox Msg, vbOKOnly + vbCritical, "Problem creating the Connection String"
    
    '18. Leave the function
    Resume LeaveFunction
End Function

Public Function QueryExists(QueryName As String) As Boolean
'----------------------------------------------------------
'This function will accept a queryname and check if it exists
'It will return a True if it exists, a False if not.
'Used by the CreatePassThrough function but can be used by any function where you need to determine the existance
'of a query
'----------------------------------------------------------
    
    '1. Set error handling
    On Error GoTo HandleError

    '2. Set default return value
    QueryExists = False

    '3. Check if the query exists
    If Not IsNull(CurrentDb.QueryDefs(QueryName).SQL) Then
        '4. Query was found
        QueryExists = True
    End If

    '5. Leave the function
    Exit Function

HandleError:

    '6. Return a False and leave function
    QueryExists = False
    

End Function


Public Function LogError(ByVal ErrNumber As Long, ByVal ErrDescription As String, ByVal CallingProc As String, Optional ByVal Parameters, Optional ByVal ShowUser As Boolean = True) As Boolean
            
On Error GoTo Err_LogError
'------------------------------------------
'Author : Tom Pettit
'Web    : https://www.msaccess.guru/
'------------------------------------------
'Usage  : You are granted permission to use and modify this code freely for your
'       : applications. Please retain this notice in the code
'------------------------------------------
    ' Logs provided error details to the Error table
    ' Optionally displays error to the user
    '
    'Function initially attempts to log error to the MySQL server, failing that
    'it will log the error locally
    'Failing that it will display a message

    '1. Declare the variables
    Dim Msg As String      ' String for display in MsgBox
    Dim LogAttempt As Integer
    Dim UpdateString As String
    
    '2. Initiate the log attempts
    LogAttempt = 0

    '3. If the option to show the error to the user was passed in, show it
    If ShowUser Then
        '4. Display error to user
        Msg = "Error " & ErrNumber & ": " & ErrDescription
        MsgBox Msg, vbExclamation, CallingProc
    End If

    '5. This is in case the routine that errored had echo turned off, if we don't turn it back on then Access will appear to have hung
    Application.Echo True

    '6. Build update string for MySQL errorlog table
    '7. The fields to be updated
    updatefields = "ErrNumber,ErrDescription,ErrDate,CallingProc,UserName,ShowUser"
    
    '8. Build the values string (same order as fields)
    UpdateString = ""
    UpdateString = UpdateString & "'" & ErrNumber & "',"
    UpdateString = UpdateString & "'" & Replace(Left$(ErrDescription, 255), "'", "_") & "',"
    UpdateString = UpdateString & "'" & Now() & "',"
    UpdateString = UpdateString & "'" & CallingProc & "',"
    UpdateString = UpdateString & "'" & Environ("Username") & "',"
    UpdateString = UpdateString & Val(ShowUser)
    
    '9. If a parameter value was passed in, include it
    If Not IsMissing(Parameters) Then
        '10. Add the parameter field to field string
        updatefields = updatefields & ",Parameters"
        '11. Add only the first 255 characters to the value string (that is how big the field is)
        UpdateString = UpdateString & ",'" & Left(Parameters, 255) & "'"
    End If
    
    '12. Put them all together in a single SQL string
    UpdateString = "INSERT errorlog(" & updatefields & ") VALUES(" & UpdateString & ")"
    
LogMySQL:
    '13. Increment LogAttempt
    LogAttempt = 1  'If there is an error with MySQL logging, 1 will cause LogLocal to be attempted
    'Attempt to log the error to MySQL's errorlog.
    'This is the ideal place to log errors especially if there are multiple users, the programmer can view them all here
    
    '14. Create a temporary passthrough query to write the data
    Call CreatePassThrough(UpdateString, "TempUpdate", False)

    '15. Execute the passthrough query
    CurrentDb.Execute "TempUpdate"
    
    '16. Tell user error is logged
    MsgBox "Error has been logged on the MySQL server"
    
    '17. No problems logging to MySQL if got here, Leave the function
    GoTo Exit_LogError
    

LogLocal:
    '18. There was a problem with SQL log so increment LoAttempt, 2 indicates local
    LogAttempt = 2
    'If there was a problem logging the error to MySQL, log it local.
    'This may happen if there is a connection problem. Whilst not ideal, at least the error will be logged somewhere
    
    '19. Declare the recordset for local logging
    Dim RS As DAO.RecordSet  ' The tLogError table

    '20. Open the errorlog table
    Set RS = CurrentDb.OpenRecordset("ErrorLog", , dbAppendOnly)
    
    '21. Add a new record, assign all the values and update
    RS.AddNew
        RS![ErrNumber] = ErrNumber
        RS![ErrDescription] = Left$(ErrDescription, 255)
        RS![ErrDate] = Now()
        RS![CallingProc] = CallingProc
        RS![UserName] = Environ("Username")
        RS![ShowUser] = ShowUser
        If Not IsMissing(Parameters) Then
            RS![Parameters] = Left(Parameters, 255)
        End If
    RS.Update
    
    '22. Close the recordset
    RS.Close
    
    '23. Tell user error was logged locally
    MsgBox "Error has been logged locally in the applications errorlog"
    

'24. Set exit point
Exit_LogError:
    Set RS = Nothing
    
'25.HINT:  A common practice I use when logging error (not included here), especially for multi user systems is to at this point is to email the
'       error and details to the person maintaining the system. Doing this has three benefits
'       1) The Developer gets the details even if logging fails
'       2) If both MySQL and Local logging failed, then details will be in the email if the problem does not stop it being sent
'       3) When the email comes through, the developer can contact the user by phone if remote or drop around to their desk to discuss the issue
'           This provides excellent system support and often, impresses the users at how on the ball you are.
'
'       You may want to consider adding such a feature.
    
    '26. Leave the function
    Exit Function

Err_LogError:
    
    '27. Test the logattempt value to see where the log failure happened (MySQL or Local)
    If LogAttempt = 1 Then
        '28. If got here and LogAttempt is 1 then there was an issue logging to MySQL
        'So try to log it locally
        Resume LogLocal
    Else
        '29. If LogAttempt is not 1 then report there was also a problem logging it locally so report a problem logging error
         Msg = "The following error has occured." & vbCrLf & "Please write down the following details :- " & vbCrLf & vbCrLf
         Msg = Msg & "Calling Procedure :- " & CallingProc & vbCrLf & "Error Number " & lngErrNumber & vbCrLf & ErrDescription & vbCrLf & vbCrLf & "Unable to log this error." & vbCrLf & "Reason :-  " & Err.Number & vbCrLf & Err.Description & vbCrLf & vbCrLf
         Msg = Msg & "Parameters :-  " & Parameters
         MsgBox Msg, vbCritical, "LogError()"
        
        '30. Can't do much else, leave the function. If an email notification is included, then that may send the problem directly to the developer
         Resume Exit_LogError
    End If
End Function


Public Function CheckForNewVersion() As Boolean
'This function will compare the local version of the application against the latest released version on the MySQL server.
'If it finds the released version number on the server is later than the local version
'a True will be returned indicating there is a new version
'If the local version is the same or higher than the MySQL version number then a False will be returned indicating
'the installed version is the latest

'1. Declare the variables
Dim InstalledVersion As Double
Dim ReleasedVersion As Double
Dim SQL As String

'2. Get the Installed VersionNo
InstalledVersion = DLookup("Value", "Lookups", "Key='InstalledVersion'")

'3. Get the release version from MySQL
SQL = "SELECT Value FROM lookups WHERE `Key`='ReleaseVersion'"
Call CreatePassThrough(SQL, "pt_ReleaseVersion", True)
ReleasedVersion = DLookup("Value", "pt_ReleaseVersion")

'4. Test the installed and release version
If ReleasedVersion > InstalledVersion Then
    '5. There is a new
    CheckForNewVersion = True
Else
    '6. Latest version is installed
    CheckForNewVersion = False
End If

'7. Remove the passthrough query
CurrentDb.QueryDefs.Delete "pt_ReleaseVersion"

'8. and leave function
End Function

Public Function UpdateApplication()

    'This function will check for a new version of the application
    'If there is a new version then the new version will be downloaded
    
    '1.Declare the variables
    Dim ReleaseFolder As String
    Dim ReleaseName As String
    Dim ApplicationFolder As String
    Dim BatchString As String
    Dim SQL As String
    Dim myFileName As String
    
    '2. Check for a new version release
    If CheckForNewVersion = True Then
        'There is a new version so download it
        
        '3. Get the release folder and application name and store them in variables
        SQL = "SELECT `Key`, `Value` FROM lookups WHERE `Key`='ReleaseFolder' OR `Key`='ReleaseName'"
        Call CreatePassThrough(SQL, "pt_ReleaseFile", True)
        ReleaseFolder = DLookup("Value", "pt_ReleaseFile", "Key='ReleaseFolder'")
        ReleaseName = DLookup("Value", "pt_ReleaseFile", "Key='ReleaseName'")
    
        '4. Make sure there is a backslash on the folder path
        If Right(ReleaseFolder, 1) <> "/" Or Right(ReleaseFolder, 1) <> "\" Then
            'Add the backslash
            ReleaseFolder = ReleaseFolder & "\"
        Else
        End If
        
        '5. Delete the pt_ReleaseFile
        CurrentDb.QueryDefs.Delete "pt_ReleaseFile"
        
        '6. Get the path of the current project
        ApplicationFolder = CurrentProject.Path & "\"
        
        
        '7. Download the file to the current folder and rename it to NewVersion.accdb
        FileCopy ReleaseFolder & ReleaseName, ApplicationFolder & "NewVersion.accdb"
        
        '8. Prepare the batch script file to rename the files
        BatchString = ""    'Initiate the string
        BatchString = BatchString & "@echo off" & vbCrLf    'It all happens so fast so probably not really needed
        
        '9. Wait for the lockfile to disappear to indicate this application has closed
        BatchString = BatchString & ":loop" & vbCrLf
        BatchString = BatchString & "if exist """ & Replace(ApplicationFolder & CurrentProject.Name, ".", ".l") & """ (" & vbCrLf
        BatchString = BatchString & "    goto loop" & vbCrLf
        BatchString = BatchString & ") else (" & vbCrLf
        BatchString = BatchString & "    goto exitloop" & vbCrLf
        BatchString = BatchString & ")" & vbCrLf
        BatchString = BatchString & ":exitloop" & vbCrLf
        
        '10. Delete the older version (this copy of the application)
        BatchString = BatchString & "del """ & ApplicationFolder & CurrentProject.Name & """" & vbCrLf
        
        '11. Rename the new version to the proper name
        BatchString = BatchString & "rename """ & ApplicationFolder & "NewVersion.accdb" & """ """ & CurrentProject.Name & """" & vbCrLf
        
        '12. Start the new version
        BatchString = BatchString & "start """ & SysCmd(acSysCmdAccessDir) & "MSACCESS.EXE"" """"""" & ApplicationFolder & CurrentProject.Name & """"""""
        
        'Create the batch file
            
        '13. Build the filename for the batch script to be saved to
        myFileName = ApplicationFolder & "UpdateVersion.bat"
        
        '14. Prepare and write out the file
        Set strm = CreateObject("ADODB.Stream")
        With strm
           .Open
           .Charset = "UTF-8"
           .WriteText BatchString
           .SaveToFile myFileName, 1
           .Close
        End With
        
        
        '15. Run the batch file
        Shell myFileName
                
        '16. Quit this application
        Application.Quit
    
    Else
        '17. Installed version is the latest remove the batch file if it still exists
        '18. Just in case the batch file is not there
        On Error Resume Next
        
        '19. Remove batch file
        Kill CurrentProject.Path & "\" & "UpdateVersion.bat"
        
        '20. Leave function
        Exit Function
    End If




End Function


Public Function StartApplication()
'This function will perform any startup actions required, it is called from the AutoExec macro

    '1. Check if there is a new version
    Call UpdateApplication

    '2. Load the opening form
    DoCmd.OpenForm "ContactDetails"
    
End Function

