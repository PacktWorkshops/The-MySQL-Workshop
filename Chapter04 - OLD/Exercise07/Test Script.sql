SELECT members.Surname, members.FirstName, Nz(members.MiddleNames,"_No Middle Name_") AS MiddleName, Nz(membershipfees.FeeAmount,0) AS FeesPaid
FROM members LEFT JOIN membershipfees ON members.ID = membershipfees.ID
WHERE (((membershipfees.FeeAmount) Is Null))
ORDER BY Nz(membershipfees.FeeAmount,0);
