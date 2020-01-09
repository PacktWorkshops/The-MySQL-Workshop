USE world;

SELECT Name, HeadOfState FROM country
WHERE GovernmentForm LIKE '%Monarchy%';

-- remove_file /var/lib/mysql-files/monarchy.csv
SELECT Name, HeadOfState FROM country
WHERE GovernmentForm LIKE '%Monarchy%'
INTO OUTFILE '/var/lib/mysql-files/monarchy.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

-- cat_file /var/lib/mysql-files/monarchy.csv

SELECT GovernmentForm FROM country 
WHERE GovernmentForm LIKE '%Monarchy%'
GROUP BY GovernmentForm;
