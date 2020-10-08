USE world;

EXPLAIN SELECT cl.Language, cl.Percentage
FROM city ci JOIN country co ON ci.CountryCode=co.Code
JOIN countrylanguage cl ON cl.CountryCode=co.Code
WHERE
  ci.Name='San Francisco'
  AND co.Name='United States'
  AND cl.Percentage>1\G

ALTER TABLE country ADD INDEX(Name);
EXPLAIN SELECT cl.Language, cl.Percentage
FROM city ci JOIN country co ON ci.CountryCode=co.Code
JOIN countrylanguage cl ON cl.CountryCode=co.Code
WHERE
  ci.Name='San Francisco'
  AND co.Name='United States'
  AND cl.Percentage>1\G

ALTER TABLE city ADD INDEX (Name);
EXPLAIN SELECT cl.Language, cl.Percentage
FROM city ci JOIN country co ON ci.CountryCode=co.Code
JOIN countrylanguage cl ON cl.CountryCode=co.Code
WHERE
  ci.Name='San Francisco'
  AND co.Name='United States'
  AND cl.Percentage>1\G

EXPLAIN SELECT cl.Language, cl.Percentage
FROM city ci
JOIN countrylanguage cl ON cl.CountryCode=ci.CountryCode
WHERE
  ci.Name='San Francisco'
  AND cl.Percentage>1\G
