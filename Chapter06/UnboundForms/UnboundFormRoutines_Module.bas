Option Compare Database

'Create a storage that will persist across all functions in this module, we will store the original data in here when loading the form
'First element will be field name, second is the value when loaded
'We will start it at 1 for fields and data
'0 will be used to store the forms SQL statement
Private OriginalData(20, 1) As Variant 'Assign this to ensure big enough to hold all fields in the recordsets you pass in


Public Function LoadForm(TheForm As Form, SQL As String, TableName As String) As Boolean
'This function will accept
'
'FormName, the form to be loaded with data, pass in the form using Me as the parameter
'SQL, The sql with filter to load the form, should return one record only
'
'It will pass back a True for sucess, False for fail
'
'Please note the following rules
'1. All fields on the form must be unbound, i.e. have no datasource
'2. All fields must have the same name as the field they are to be loaded by
'3. SQL statement must include all fields for the form
'4. SQL statement must be MySQL ready
'5. The tablename passed in must be that table the data is being read from
'6. SQL can only read from one table


Dim RS As Recordset     'To load the data into
Dim Fld As Field        'For when we are cycling through the record fields
Dim Msg As String       'Messages
Dim Response As Integer 'User responses
Dim Count1 As Integer   'Generic counter
Dim Count2 As Integer   'Just in case we need a second
Dim Pos As Integer      'Maintains position in the array

On Error GoTo HandleError

'---------------------------------------------
'Create and check the recordset
'---------------------------------------------
'Create the passthrough for the passed in SQL to read the data
Call CreatePassThrough(SQL, "tmpLoadForm", True, True)

'Load the record into the recordset, only needs to be read only
Set RS = CurrentDb.OpenRecordset("tmpLoadForm", dbReadOnly)

'Check there is a record
If RS.EOF And RS.BOF Then
    'The only time a record can be at both EOF and BOF is when it is empty, no record
    MsgBox "No record to load the form with", vbOKOnly + vbCritical, "Cannot load form, no record"
    LoadForm = False
    GoTo ExitFunction
Else
    'We have a recordset. Check how many there are. We only want one
    'Moving to last then first forces the record counter to be set correctly
    'otherwise it will be 1, even if there are more
    RS.MoveLast
    RS.MoveFirst
    
    If RS.RecordCount > 1 Then
        'Too many records
        MsgBox "Too many records, There should only be one, please check the filters", vbOKOnly + vbCritical, "Cannot load form, too many records"
        LoadForm = False
        GoTo ExitFunction
    Else
        'Got through to here so we are good to go, move one
    End If
End If

'Reset all array elements before we continue
For Count1 = LBound(OriginalData) To UBound(OriginalData)
    'Reset both elements
    OriginalData(Count1, 0) = Empty
    OriginalData(Count1, 1) = Empty
Next

'---------------------------------------------
'Recordset is good, let's go
'---------------------------------------------

'Store the SQL and table for later use
OriginalData(0, 0) = SQL
OriginalData(0, 1) = TableName

'Initiate Pos to the first element we will place the fields/data in
Pos = 1

'Now we cycle through the fields in the recordset and try to match them with fields on the form

'Just ignore errors, if we cannot find a field on the form then simply move on
On Error Resume Next
For Each Fld In RS.Fields
    'Assign value to matching form control
    TheForm.Controls(Fld.Name).Value = Fld.Value
    'Assign field and value to originaldta array
    OriginalData(Pos, 0) = Fld.Name
    OriginalData(Pos, 1) = Fld.Value
    
    'Increment the position pointer for the array
    Pos = Pos + 1

Next
'Finished

'---------------------------------------------
'Tidy up before leaving
'---------------------------------------------

'Remove the query when finished
CurrentDb.QueryDefs.Delete "tmpLoadForm"


ExitFunction:

    RS.Close
    Set RS = Nothing

    Exit Function
    
HandleError:

    'Log error and leave
    Call LogError(Err, Error(Err), "Module - UnboundFormRoutine - LoadForm", , True)
    Resume ExitFunction


End Function

Public Function SaveFormData(TheForm As Form) As Boolean
'This function accepts a form and will compare the current data on the form with the data
'stored in the array when it ws loaded. If anything has changed, it will build
'an SQL statement to update the record.

Dim UpdateFields As String 'The list of fields to be updated
Dim UpdateValues As String 'The list of values to go into the update fields
Dim SQL As String           'Where we will build it all
Dim Count1 As Integer       'a counter
Dim Tmp As String

On Error GoTo HandleError

'Initial the string
UpdateFields = ""

'Check for changes and build the field and value strings
For Count1 = 1 To UBound(OriginalData)
    If IsEmpty(OriginalData(Count1, 1)) Then
        Exit For
    Else
        If Nz(OriginalData(Count1, 1), "") <> Nz(TheForm.Controls(OriginalData(Count1, 0)).Value, "") Then
            'The data has changed
            'Build the string
            
            'Add a comma if there is already something in the field
            If UpdateFields <> "" Then
                UpdateFields = UpdateFields & ","
            End If
            
            'Add the fieldname, remember, this is for MySQL so use back ticks too
            'Check if is date, if it is put it in the right format for MySQL
            If IsDate(TheForm.Controls(OriginalData(Count1, 0)).Value) Then
                TheForm.Controls(OriginalData(Count1, 0)).Value = Format(TheForm.Controls(OriginalData(Count1, 0)).Value, "YYYY-MM-DD")
            End If
            
            If IsNumeric(TheForm.Controls(OriginalData(Count1, 0)).Value) Then
                'No quotes for numbers
                'Test if the control is a CheckBox
                If TheForm.Controls(OriginalData(Count1, 0)).ControlType = 106 Then
                    'It is a checkbox, make sure the value is positive
                    UpdateFields = UpdateFields & "`" & OriginalData(Count1, 0) & "` = " & Abs(TheForm.Controls(OriginalData(Count1, 0)).Value)
                Else
                    UpdateFields = UpdateFields & "`" & OriginalData(Count1, 0) & "` = " & TheForm.Controls(OriginalData(Count1, 0)).Value
                End If
            Else
                'Text fields in here
                UpdateFields = UpdateFields & "`" & OriginalData(Count1, 0) & "` = " & "'" & Nz(TheForm.Controls(OriginalData(Count1, 0)).Value, "") & "'"
            End If
            
        Else
            'No change to this field
        End If
    End If
Next

'Stop

If UpdateFields = "" Then
    'Nothing was changed so just leave
    GoTo ExitFunction
Else
    'Something changed, build the SQL to save
    
    'Get the WHERE clause from the original query
    startpos = InStr(1, OriginalData(0, 0), "WHERE")
    endpos = InStr(1, OriginalData(0, 0), "ORDER BY")
    
    If endpos = 0 Then
        Tmp = Right(OriginalData(0, 0), Len(OriginalData(0, 0)) - (startpos - 1))
    Else
        Tmp = Mid(OriginalData(0, 0), startpos, endpos - startpos)
    End If
    
    'Put it all together
    SQL = "UPDATE `" & OriginalData(0, 1) & "` SET " & UpdateFields & " "
    SQL = SQL & Tmp
    
    'SQL to update the record
    Call CreatePassThrough(SQL, "ptTemp", False, False)
    
    'Turn off warnings before adding record
    DoCmd.SetWarnings False
    DoCmd.OpenQuery ("pttemp")
    DoCmd.SetWarnings True
    
    'Remove the query when finished
    CurrentDb.QueryDefs.Delete "ptTemp"
    
End If

ExitFunction:

    Exit Function
    
HandleError:

    'Log error and leave
    Call LogError(Err, Error(Err), "Module - UnboundFormRoutine - LoadForm", , True)
    Resume ExitFunction

End Function
