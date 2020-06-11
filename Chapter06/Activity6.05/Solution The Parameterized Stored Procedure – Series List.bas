SQL = "Call spSeriesList_par('" & Me.cmbGroups & "');"

Call CreatePassThrough(SQL, "spSeriesFiltered", True, False)

Me.cmbSeries.RowSource = "spSeriesFiltered"
