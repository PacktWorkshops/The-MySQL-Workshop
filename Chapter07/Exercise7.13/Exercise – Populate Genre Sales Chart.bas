'Note: This code is to go into the Dashboard worksheets Worksheet_Change event

'Exercise – Populate Genre Sales Chart


'2.	To test what cell was changed, we test the Target parameter, this is a Range object and amongst other things, contains the Address and the Value, and we are interested in both. Test the address of 'Target using a Select Case statement to test if the changed cell is B5


Private Sub Worksheet_Change(ByVal Target As Range)
'Test the active cell (the one that changed)
    Select Case Target.Address
    
        Case "$B$5"

'3.	If the target is referring to B5 then we need to process it, start by calling the data load routine we created in the previous exercise. Target will contain the selected Genre text, this is very 'convenient, we only need to pass in Target.

            'The change was in the dropdown, target has the value
            Call GenreSales(Target)

'4.	Activate the Dashboard worksheet so we can use the With/End With construct 

            'Set the chart details Population
            Worksheets("Dashboard").ChartObjects("chrtPopulation").Activate

'5.	Set the parameters for the chart including datasource, title and series name

            With ActiveChart
                .SetSourceData Source:=Sheets("Data Sheet").Range("GenreSales"), PlotBy:=xlColumns
                .HasTitle = True
                .ChartTitle.Text = "Genre Sales - " & Target
                .SeriesCollection(1).Name = "Sales"
            End With

'6.	We are finished with B5. Include the Else to ignore the cell changes we are not interested in. Note: If you want to include other cells, just add its Case test and code (remember that for the upcoming 'activity)

        Case Else
            'Nothing to work with so leave
            GoTo Leavesub
    End Select
    
Leavesub:
        Exit Sub

End Sub