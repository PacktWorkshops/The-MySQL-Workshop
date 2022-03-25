USE world;

SELECT Name, Population FROM city ORDER BY Population LIMIT 1;

SELECT Code FROM country WHERE name='India';
SELECT * FROM countrylanguage WHERE CountryCode='IND';

SELECT Language FROM countrylanguage GROUP BY Language HAVING COUNT(*)>20;

SELECT name
FROM world.country
WHERE region = "Southern and Central Asia"
ORDER BY population DESC
LIMIT 5;

SELECT * FROM city WHERE Name Like '%ester';
