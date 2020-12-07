USE world_simple;

WITH city_in_romania AS (
  SELECT ci.Name, ci.CountryCode, co.Name AS CountryName
  FROM city ci INNER JOIN country co ON ci.CountryCode=co.Code AND co.Name='Romania'
)
SELECT * FROM city_in_romania;

SELECT * FROM (
  SELECT ci.Name, ci.CountryCode, co.Name AS CountryName
  FROM city ci INNER JOIN country co ON ci.CountryCode=co.Code
  AND co.Name='Romania'
) AS city_in_romania;
