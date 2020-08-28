USE world;

--disable_warnings
DROP TABLE IF EXISTS copy_of_city;
--enable_warnings

SELECT * FROM city INTO OUTFILE '/var/lib/mysql-files/city.csv' CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
--cat_file /var/lib/mysql-files/city.csv

CREATE TABLE copy_of_city LIKE city;
LOAD DATA INFILE '/var/lib/mysql-files/city.csv' INTO TABLE copy_of_city
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

DROP TABLE copy_of_city;
--remove_file /var/lib/mysql-files/city.csv
