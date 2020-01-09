USE world;

SELECT Continent, AVG(GNP), SUM(SurfaceArea)
FROM country GROUP BY Continent;

SELECT Region, SUM(SurfaceArea) FROM country
WHERE Continent='Asia' GROUP BY Region;
