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

    Dim RS As DAO.RecordSet     'Recordset for checking for Write Conflict
    Dim myField As DAO.Field    'To cycle through the recordset fields
    Dim NewValue As String      'Storage for new value when processing
    Dim Msg As String           'To message the user
    Dim WCMessage As String     'For the WriteConflict message if there is one
    Dim WCMessageFile As String 'To write the Write Conflict to a disk file if required
    Dim DoSave As Boolean       'Flag to indicate Save will be performed
    Dim ArrayPosition As Long   'Pointer in array where the field appears
    
    Dim UpdateString As String  'To build the update fields and values for changes
     
    'Initiate the update string
    UpdateString = ""
    
On Error GoTo HandleError
    
        'Reload the record from the database so we can check it is the same as the original record
        'If any fields from the original load are different to this load then someone else has changed the record
        'since we originally loaded it
        'so we have a Write Conflict situation
        Set RS = CurrentDb.OpenRecordset(RecordSet)
        
        'Check we have a record to edit
        If RS.BOF And RS.EOF Then
            'No...set function as false
            WriteFormData = False
        Else
            'Yes, move to first record...shold only have one record anyway
            RS.MoveFirst
            'Prepare file message string
            WCMessageFile = ""
            
'Cycle through each field in the recordset
            For Each myField In RS.Fields
'Check the fields, some we don't want or cannot touch
                Select Case myField.Name
                    Case "TimeStamp", "AutoNumb"
                        'Ignore these system maintained fields
                        
                        'If you have any fields that are dealt with by other code you can include a case statement to ignore them as well
                        
                    Case Else
                        'Do these, these fields are what the user may change
                        'Check if the field is an autonumber field
                        If myField.Attributes And dbAutoIncrField Then
                            'Is an autonumber field so don't try to update it
                        Else
                            'Compare the recordsets field to the equivalent form fields values
                            'we only want to update fields that have been changed
'Check if user has modified record
                            'Find the field in the array and return its position
                            ArrayPosition = IsInArray(myField.Name, OldValues)
                            'Test we found it
                            If ArrayPosition = -1 Then
                                'Couldn't find it so move to next field...the field in the recordset is not on the form
                                GoTo NextField
                            End If
                            
                            'Do the actual check for changes
                            If Nz(myForm.Controls(myField.Name).Value, "") <> Nz(OldValues(ArrayPosition, 0), "") Then
                                'Values are different so has been modified..we want to update this field
                                'but first check if OldValue of field is same as current value we just read in.
                                'If it is NOT the same, there is a write conflict with another user
'Check for Write Conflict, if no one else has changed the record then both values should be the same
                                If Nz(OldValues(ArrayPosition, 0), "") <> Nz(myField.Value, "") Then
                                    'WriteConflict, someone else has updated the fields value since  you opened the form
                                    'Prepare the message for user
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
                                    
                                    If WCMessageFile = "" Then
                                        'First time adding message so add a header
                                        WCMessageFile = "WRITE CONFLICT details" & vbCrLf & vbCrLf
                                        WCMessageFile = WCMessageFile & "Form: " & myForm.Name & vbCrLf
                                        WCMessageFile = WCMessageFile & "=========================================" & vbCrLf
                                    End If
                                    
                                    'add message to end
                                    WCMessageFile = WCMessageFile & WCMessage & vbCrLf
                                    WCMessageFile = WCMessageFile & "=========================================" & vbCrLf
                                    
                                    Select Case MsgBox(WCMessage, vbYesNo + vbQuestion, "Write Conflict ([" & myField.Name & "])")
                                        Case vbYes
                                            'User chose to overwrite database value
                                            DoSave = True
                                        Case vbNo
                                            'User chose keep database value, this is for this field only, other fields will still be processed
                                            DoSave = False
                                    End Select
                                    
                                Else
                                    'No Write Conflict on the field, allow save to proceed
                                    DoSave = True
                                End If
                            
'Perform save operation
                                'If we have the go ahead to perform the save, do it
                                If DoSave = True Then
                                     'Store the value into NewValue...we will use these later
                                     NewValue = Nz(myForm.Controls(myField.Name).Value, "")
                                    
                                    'Check if other changes have been set for writing, if yes then add a coma
                                    If UpdateString <> "" Then
                                       UpdateString = UpdateString & ", "
                                    End If
                                    
                                    'Add the fieldname and an = to the string. Fieldname is surround by backticks in case of spaces
                                    UpdateString = UpdateString & "`" & myField.Name & "`="
                                    
                                    'Check the type of field we are looking at
                                     Select Case myField.Type
                                         Case 10, 12 'text, memo and hyperlink
                                             'Add the value to the updatestring, this is a text field so wrap it in quotes
                                            UpdateString = UpdateString & "'" & NewValue & "'"
                                         Case 8  'Date
                                            'Add the value to the updatestring, the date can be formatted if required
                                            UpdateString = UpdateString & "'" & NewValue & "'"
                                             
                                         Case Else
                                             'Is a numeric value then so determine value and record it
                                             UpdateString = UpdateString & Val(NewValue)
                                     End Select
                                End If
                            End If
                        End If
                End Select
NextField:
                'Reset new value and do next field
                NewValue = ""
            Next
End If
        
        'Close recorset
RS.Close
    
        'Check if there have been changes set for writing
        If UpdateString <> "" Then
            'There are changes so build the update query
            UpdateString = "UPDATE " & Table & " SET " & UpdateString & " WHERE " & TheFilter
            
            'Create a temporary passthrough query to write the data
            Call CreatePassThrough(UpdateString, "TempUpdate", False, True)
            'Execute the passthrough query
            CurrentDb.Execute "TempUpdate"
            'Remove the passthrough query. We do not want to leave update queries laying around
            'in case they are accidentally executed in the panel
            CurrentDb.QueryDefs.Delete "TempUpdate"
        
            'Tell user the changes are saved
            WriteFormData = "Changes have been saved"
            
        Else
            'There were no changes set in updatetring so tell user nothing to save and leave the function
            WriteFormData = "No changes were made, nothing to write"
            GoTo LeaveFunction
        End If
    
        'Check if need to create a Write Conflict log
        If WCMessageFile <> "" Then
            'We have Write Conflict messages so save them to file
            Dim myFileName As String
            Dim fso As Object
            Dim Fileout As Object
            
            'Build the filename to log the write conflict to
            myFileName = DLookup("Values", "Lookups", "Key='SystemLogs'") & "WRITE CONFLICT - " & gCurrentUserName & " - " & myForm.Name & " - " & Format(Now(), "YYYYMMDD HHnn") & ".txt"
            
            'Prepare and write out the file
            Set fso = CreateObject("Scripting.FileSystemObject")
            Set Fileout = fso.CreateTextFile(myFileName, True, True)
            Fileout.Write WCMessageFile
            Fileout.Close
                    
            'open the file for user to view
            Shell "c:\WINDOWS\notepad.exe " & myFileName
                    
        End If
    
LeaveFunction:
    Exit Function
    
HandleError:

    Select Case Err
        Case 2424, 2465   'Cant find field..
            Resume NextField
        Case Else
            'Log the error
            Call LogError(Err, Error(Err), "WriteFormData", myForm.Name & " - " & RecordSet, True)
            'Pass back write error
            WriteFormData = "There was an error saving changes - " & Err & " - " & Error(Err)
            'Leave the function
            GoTo LeaveFunction
    End Select
    
    'Will never get here by code
    'You can set a break on the ELSE and then move yellow line to here and press F8 to return the line that caused the error
    Resume

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

  Dim i As Long
  ' default return value if value not found in array
  IsInArray = -1

  'Cycle through the array elements
  For i = LBound(Arr) To UBound(Arr)
    'Check the 1 element for each loop through
    If StrComp(stringToBeFound, Arr(i, 1), vbTextCompare) = 0 Then
      'If found the set the position and leave...no need to waste time continuing
      IsInArray = i
      Exit For
    End If
  Next i
  
  'If gets to here the value will still be -1
  
End Function