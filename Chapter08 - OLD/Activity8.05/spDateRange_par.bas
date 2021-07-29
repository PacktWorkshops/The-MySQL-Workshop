SQL = "Call spDateRange_par('" & TableName & "','" & Me.cmbSeries & "');"
Call CreatePassThrough(SQL, "spDateRange_par", True, False)


'Fill the Year dropdowns
    Me.StartYear.RowSource = "spDateRange_par"
    Me.StartYear = Me.StartYear.ItemData(0)
    
    Me.EndYear.RowSource = "spDateRange_par"
    Me.EndYear = Me.EndYear.ItemData(Me.EndYear.ListCount - 1)

    