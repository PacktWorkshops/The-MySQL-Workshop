USE world;

--disable_warnings
ALTER TABLE country DROP COLUMN population_outside_of_city;
--enable_warnings

ALTER TABLE country
  ADD COLUMN population_outside_of_city INT;

WITH citytotal AS (
  SELECT CountryCode, SUM(Population) city_population
  FROM city GROUP BY CountryCode)
UPDATE country co
JOIN citytotal ct ON co.Code=ct.CountryCode
SET co.population_outside_of_city=co.Population-ct.city_population;

SELECT Name, Population, population_outside_of_city FROM country LIMIT 5;

SELECT Code, Name, Population, population_outside_of_city
FROM country WHERE population_outside_of_city<0;

SELECT SUM(Population) FROM city WHERE CountryCode='SGP';

UPDATE country SET population_outside_of_city=0 WHERE population_outside_of_city<0;
SELECT Code, Name, Population, population_outside_of_city
FROM country WHERE population_outside_of_city<0;
