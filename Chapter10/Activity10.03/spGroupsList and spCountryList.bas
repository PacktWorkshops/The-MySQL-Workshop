SQL = "Call spGroupsList;"
Call CreatePassThrough(SQL, "spGroupsList", True, False)
Me.cmbGroups.RowSource = "spGroupsList"

SQL = "Call spCountryList;"
Call CreatePassThrough(SQL, "spCountryList", True, False)
Me.cmbCountry.RowSource = "spCountryList"