USE world;

SELECT Name, LifeExpectancy FROM country WHERE Region='Eastern Europe';

SELECT Name, LifeExpectancy FROM country WHERE Region='Eastern Europe'
INTO OUTFILE '/var/lib/mysql-files/eastern_europe_life_expectancy.csv'
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

