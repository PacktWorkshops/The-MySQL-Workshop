USE world;

CREATE TABLE city_export LIKE city;
SHOW CREATE TABLE city_export;

ALTER TABLE city_export MODIFY COLUMN `ID` int NOT NULL;
ALTER TABLE city_export DROP KEY CountryCode;
ALTER TABLE city_export DROP PRIMARY KEY;
ALTER TABLE city_export ENGINE=CSV;

INSERT INTO city_export SELECT * FROM city WHERE CountryCode='RUS';

SELECT @@datadir;
# \! head /path/to/world/city_export.CSV
