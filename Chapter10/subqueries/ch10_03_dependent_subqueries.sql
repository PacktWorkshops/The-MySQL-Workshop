USE world_simple;
SELECT
  Name,
  CountryCode,
  (SELECT Name FROM country WHERE Code=city.CountryCode) AS CountryName
FROM city;