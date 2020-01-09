SQL = "SELECT fnCountGroups() as GroupCount"
Call CreatePassThrough(SQL, "CntGroups", True, False)
Set RS = CurrentDb.OpenRecordset("CntGroups", dbOpenDynaset)
RS.MoveFirst
Me.cntGroups = RS.Fields("GroupCount")
RS.Close