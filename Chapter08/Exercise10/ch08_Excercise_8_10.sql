USE world;

SELECT * FROM city INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/city.csv' CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
--cat_file /var/lib/mysql-files/city.csv

CREATE TABLE copy_of_city LIKE city;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/city.csv' INTO TABLE copy_of_city
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

