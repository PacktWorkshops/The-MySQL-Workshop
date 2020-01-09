USE world_simple;

SELECT Name FROM city WHERE CountryCode=(
  SELECT Code FROM country WHERE Name='Romania'
);

SELECT
  Name,
  CountryCode,
  (SELECT Name FROM country WHERE Code=city.CountryCode) AS CountryName
FROM city;
