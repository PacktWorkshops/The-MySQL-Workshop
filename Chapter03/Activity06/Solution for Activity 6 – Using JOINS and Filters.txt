SELECT
  members.ID,
  members.Surname,
  members.FirstName,
  membershipfees.MemberID
FROM
  members
  LEFT JOIN membershipfees ON membershipfees.MemberID = members.ID
WHERE
  membershipfees.MemberID IS NULL
