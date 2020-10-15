USE world;

INSERT INTO country
(Code, Name, Continent, Region, SurfaceArea, IndepYear,
Population, GNP, GovernmentForm, HeadOfState,
Capital, Code2)
VALUES ('SSD', 'South Sudan', 'Africa', 'Northern Africa', 619745, 2011,
10975927, 18435, 'Republic', 'Salva Kiir Mayardit',
(SELECT ID FROM city WHERE Name='Juba'), 'SS');

UPDATE city SET CountryCode='SSD' WHERE Name='Juba';

INSERT INTO countrylanguage
SELECT 'SSD', Language, IsOfficial, Percentage
FROM countrylanguage cl
JOIN country co ON cl.CountryCode=co.Code
WHERE co.Name='Sudan';

SELECT Name, Population, SurfaceArea
FROM country WHERE name='Sudan' or name='South Sudan';

UPDATE country sdn JOIN country ssd
SET sdn.Population=sdn.Population-ssd.Population,
sdn.SurfaceArea=sdn.SurfaceArea-ssd.SurfaceArea
WHERE sdn.Name='Sudan' and ssd.Name='South Sudan';

SELECT Name, Population, SurfaceArea
FROM country WHERE name='Sudan' or name='South Sudan';
