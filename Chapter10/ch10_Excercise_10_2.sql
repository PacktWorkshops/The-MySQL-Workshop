USE world;

SELECT * FROM countrylanguage
WHERE Language='Portuguese' AND IsOfficial='T';

SELECT (
  SELECT Name FROM country
  WHERE Code=CountryCode
) AS CountryName FROM countrylanguage
WHERE Language='Portuguese' AND IsOfficial='T';
