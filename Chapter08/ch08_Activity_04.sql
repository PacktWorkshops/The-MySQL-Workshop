USE world;

--disable_warnings
DROP TABLE IF EXISTS city_export_california;
--enable_warnings

CREATE TABLE city_export_california LIKE city;

ALTER TABLE city_export_california
  DROP INDEX CountryCode,
  DROP PRIMARY KEY,
  MODIFY COLUMN ID int NOT NULL,
  ENGINE=CSV;

INSERT INTO
  city_export_california
SELECT
  *
FROM
  city
WHERE
  CountryCode='USA'
  AND District='California';

DROP TABLE city_export_california;
