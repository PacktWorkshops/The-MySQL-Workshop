\use world

\sql CREATE TABLE copy_of_city LIKE city;

\sql SELECT * FROM city INTO OUTFILE 'city.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

\sql TRUNCATE TABLE copy_of_city;
util.importTable(
  'city.csv',
  {"table": "c", "dialect": "csv-unix"}
)

\sql DROP TABLE copy_of_city;
