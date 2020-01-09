
-- remove_file /var/lib/mysql-files/example.txt
SELECT 'This is a test', VERSION()
INTO OUTFILE '/var/lib/mysql-files/example.txt';
-- cat_file /var/lib/mysql-files/example.txt

-- remove_file /var/lib/mysql-files/example.csv
SELECT 'This is a test', VERSION()
INTO OUTFILE '/var/lib/mysql-files/example.csv'
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
-- cat_file /var/lib/mysql-files/example.csv
