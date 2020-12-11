USE world_simple;

SELECT Name FROM city WHERE CountryCode=(
  SELECT Code FROM country WHERE Name='Romania'
);


