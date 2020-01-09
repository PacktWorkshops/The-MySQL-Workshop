USE world;

WITH country_portuguese AS (
  SELECT CountryCode FROM countrylanguage
  WHERE Language='Portuguese' AND IsOfficial='T'
)
SELECT * FROM country_portuguese;

WITH country_portuguese AS (
  SELECT CountryCode FROM countrylanguage
  WHERE Language='Portuguese' AND IsOfficial='T'
)
SELECT
  *
FROM country_portuguese col_pt
JOIN countrylanguage col
  ON col_pt.CountryCode=col.CountryCode;

WITH country_portuguese AS (
  SELECT CountryCode FROM countrylanguage
  WHERE Language='Portuguese' AND IsOfficial='T'
)
SELECT
  co.Name,
  GROUP_CONCAT(Language) AS Languages
FROM country_portuguese col_pt
JOIN countrylanguage col
  ON col_pt.CountryCode=col.CountryCode
JOIN country co
  ON co.Code=col.CountryCode
GROUP BY co.Name;
