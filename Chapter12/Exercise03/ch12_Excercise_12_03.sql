USE world;

SELECT Name, IndepYear, Population, SurfaceArea FROM country 
WHERE YEAR(NOW()) - IndepYear > 1000;

SELECT
  Name, 
  IndepYear,
  YEAR(NOW()) - IndepYear,
  Population,
  ROUND(Population/SurfaceArea,0)
FROM country
WHERE YEAR(NOW()) - IndepYear > 1000;

SELECT
  Name, 
  IndepYear,
  YEAR(NOW()) - IndepYear,
  ROUND(Population / 1000000, 0),
  ROUND(Population/SurfaceArea,0)
FROM country
WHERE YEAR(NOW()) - IndepYear > 1000;
