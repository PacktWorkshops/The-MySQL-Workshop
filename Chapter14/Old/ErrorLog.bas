Option Compare Database

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

    Dim Msg As String      ' String for display in MsgBox
    Dim LogAttempt As Integer
    Dim UpdateString As String
    LogAttempt = 0

    'If the option to show the error to the user was passed in, show it
    If ShowUser Then
        Msg = "Error " & ErrNumber & ": " & ErrDescription
        MsgBox Msg, vbExclamation, CallingProc
    End If

    'This is in case the routine that errored had echo turned off
    Application.Echo True

    'Build update string for MySQL errorlog table
    'The fields to be updated
    updatefields = "ErrNumber,ErrDescription,ErrDate,CallingProc,UserName,ShowUser"
    
    'Build the values string (same order as fields)
    UpdateString = ""
    UpdateString = UpdateString & "'" & ErrNumber & "',"
    UpdateString = UpdateString & "'" & Replace(Left$(ErrDescription, 255), "'", "_") & "',"
    UpdateString = UpdateString & "'" & Now() & "',"
    UpdateString = UpdateString & "'" & CallingProc & "',"
    UpdateString = UpdateString & "'" & Environ("Username") & "',"
    UpdateString = UpdateString & Val(ShowUser)
    
    'If a parameter was passed in, include it
    If Not IsMissing(Parameters) Then
        updatefields = updatefields & ",Parameters"
        UpdateString = UpdateString & ",'" & Left(Parameters, 255) & "'"
    End If
    
    'Put them all together in a single SQL string
    UpdateString = "INSERT ErrorLog(" & updatefields & ") VALUES(" & UpdateString & ")"
    
LogMySQL:
    LogAttempt = 1  'If there is an error with MySQL logging, 1 will cause LogLocal to be attempted
    'Attempt to log the error to MySQL's errorlog. This is the ideal place to log errors
    'especially if there are multiple users, the programmer can view them all here
    
    'Create a temporary passthrough query to write the data
    Call CreatePassThrough(UpdateString, "TempUpdate", False, True)

    'Execute the passthrough query
    CurrentDb.Execute "TempUpdate"
    
    'No problems logging to MySQL if got here, Leave the function
    GoTo Exit_LogError
    

LogLocal:
    LogAttempt = 2
    'If there was a problem logging the error to MySQL, log it local.
    'This may happen if there is a connection problem. Whilst not ideal, at least the error will be logged somewhere
    Dim RS As DAO.RecordSet  ' The tLogError table

    Set RS = CurrentDb.OpenRecordset("ErrorLog", , dbAppendOnly)
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
    RS.Close
    LogError = True

Exit_LogError:
    Set RS = Nothing
    Exit Function

Err_LogError:
    
    If LogAttempt = 1 Then
        'If got here and LogAttemp is 1 then there was an issue logging to MySQL
        'So try to log it locally
        Resume LogLocal
    Else
        'If LogAttempt is not 1 then report there was also a problem loggin it locally so report a problem logging error
         Msg = "The following error has occured." & vbCrLf & "Please write down the following details :- " & vbCrLf & vbCrLf
         Msg = Msg & "Calling Procedure :- " & CallingProc & vbCrLf & "Error Number " & lngErrNumber & vbCrLf & ErrDescription & vbCrLf & vbCrLf & "Unable to log this error." & vbCrLf & "Reason :-  " & Err.Number & vbCrLf & Err.Description & vbCrLf & vbCrLf
         Msg = Msg & "Parameters :-  " & Parameters
         MsgBox Msg, vbCritical, "LogError()"
        
         Resume Exit_LogError
    End If

    Resume
End Function


