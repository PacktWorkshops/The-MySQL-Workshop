USE world;

SELECT * FROM city WHERE CountryCode='CHE';

SELECT Name, Population FROM country WHERE Continent='Oceania'
AND Population > 1000000;

SELECT Name FROM country WHERE Name LIKE 'United %';

SELECT * FROM city WHERE District='New York' OR District='New Jersey'
AND Population>100000;
SELECT * FROM city WHERE (District='New York' OR District='New Jersey')
AND Population>100000;
