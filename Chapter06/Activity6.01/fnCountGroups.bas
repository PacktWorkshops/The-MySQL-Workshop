SQL = "SELECT fnCountGroups() as RecCount"
Call CreatePassThrough(SQL, "CntGroups", True, False)
Set RS = CurrentDb.OpenRecordset("CntGroups", dbOpenDynaset)
RS.MoveFirst
Me.cntGroups = RS.Fields("RecCount")
RS.Close