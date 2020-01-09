\use test
\sql

DROP TABLE IF EXISTS climate_history;
DROP TABLE IF EXISTS building_report;
DROP TABLE IF EXISTS building1;
DROP TABLE IF EXISTS building2;
DROP TABLE IF EXISTS building3;

CREATE TABLE climate_history (
  report_date date NOT NULL PRIMARY KEY,
  temperature DECIMAL(3,1),
  humidity DECIMAL(3,1)
);
\source building1.sql
RENAME TABLE climate_history TO building1;
CREATE TABLE building2 LIKE building1;
LOAD DATA INFILE "building2.CSV"
  INTO TABLE building2
  FIELDS TERMINATED BY "," ENCLOSED BY '"';
\js
db.createCollection('building3')
util.importJson("building3.json")
\rehash
db.building3.find()
\sql
CREATE TABLE building_report LIKE building1;
ALTER TABLE building_report
  ADD COLUMN building VARCHAR(255) FIRST,
  DROP PRIMARY KEY,
  ADD PRIMARY KEY (building, report_date);
INSERT INTO building_report
SELECT 'building 1', building1.* FROM building1;

INSERT INTO building_report
SELECT 'building 2', building2.* FROM building2;

INSERT INTO building_report
SELECT
  'building 3',
  doc->>'$.report_date',
  doc->>'$.temp',
  doc->>'$.humidity'
FROM building3;

SELECT * FROM building_report ORDER BY report_date, building;

SELECT 'building 1' AS building, building1.*
FROM building1
UNION ALL
SELECT 'building 2', building2.*
FROM building2
UNION ALL
SELECT
  'building 3',
  doc->>'$.report_date' AS report_date,
  doc->>'$.temp' AS temperature,
  doc->>'$.humidity' AS humidity
FROM building3 ORDER BY report_date, building;
