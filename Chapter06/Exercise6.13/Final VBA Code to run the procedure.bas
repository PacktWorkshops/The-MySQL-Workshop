SQL = "Call spCountryList_par('" & TableName & "','" & Me.cmbSeries & "')"
Call CreatePassThrough(SQL, "spCountryList_par", True, False)
Me.cmbCountry.RowSource = "spCountryList_par"
