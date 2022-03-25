SELECT
  members.Surname,
  members.FirstName,
  memberaddress.StreetAddress1,
  memberaddress.StreetAddress2,
  memberaddress.Town,
  memberaddress.Postcode,
  states.State
FROM
  members
  INNER JOIN memberaddress ON memberaddress.MemberID = members.ID
  INNER JOIN states ON memberaddress.State = states.ID
WHERE
  members.Active <> 0
ORDER BY members.Surname, members.FirstName
