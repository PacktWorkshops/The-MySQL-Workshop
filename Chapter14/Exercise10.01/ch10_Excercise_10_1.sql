USE world;

SELECT ci.Name, ci.Population
FROM city ci JOIN country co ON ci.CountryCode=co.Code
WHERE co.Region='Middle East' ORDER BY ci.Population DESC LIMIT 5;
