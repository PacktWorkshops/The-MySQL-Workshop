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

    Dim RS As DAO.RecordSet
    Dim myField As DAO.Field
    Dim KeyField As String
    
    Dim Ctrl As Control
    
    
On Error GoTo HandleError

        Set RS = CurrentDb.OpenRecordset(RecordSet, dbOpenSnapshot)
        
        'Before we start loading, OldValue array
        'we are going to load this array with the data so we can compare to database
        'before updating to determin if user has modified the fields data and write conflicts. We need to do this because Unbound form fields do not have OldValue property
        'We will use OrdinalPosition to determin which element fields value goes into
        'As we are using exact same SQL for opening the recordset for writing later we are assuming the positions will be the same
        'when comparing
        
        If RS.BOF And RS.EOF Then
            PopulateForm = False
            GoTo ExitFunction
        Else
        
            RS.MoveFirst
            
            'Cycle through each recordset field
            For Each myField In RS.Fields
                'Assign the value from the recordset to the control with the same name
                'Ensure the control is not locked
                myForm.Controls(myField.Name).Locked = False
                'Assign the value from the record to the control
                myForm.Controls(myField.Name).Value = Nz(myField.Value, "")
                
                'Record value for Write Conflict comparison later when writing back to database
                OldValues(RS.Fields(myField.Name).OrdinalPosition, 0) = myField.Value
                OldValues(RS.Fields(myField.Name).OrdinalPosition, 1) = myField.Name
            Next
            
        End If
        
        PopulateForm = True
    
ExitFunction:
        RS.Close



    Exit Function
    
HandleError:

    Select Case Err
        Case 91
            'If recordset is closed will come in here to stop endless loop
            'Log and Exit function
            Call LogError(Err, Error(Err), "Populate Form", myForm.Name & " - " & RecordSet, True)
            PopulateForm = False
            Exit Function
        Case 2465   'Cant find control with the field name.
            Resume Next
        Case 438, 2448 'Object doesn't support this property or method
            Resume Next
        Case Else
            'Log the error
            Call LogError(Err, Error(Err), "Populate Form", myForm.Name & " - " & RecordSet, True)
            PopulateForm = False
            Resume ExitFunction
    End Select
    Exit Function
    
    Resume
    
End Function