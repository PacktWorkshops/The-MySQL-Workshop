USE test;

--disable_warnings
DROP TABLE IF EXISTS fruits;
--enable_warnings

CREATE TABLE fruits (id int primary key, fruit varchar(255));
INSERT INTO fruits VALUES (1, 'Apple'), (2, 'Pear'), (3, 'Orange'), (4, 'Carrot');
DELETE FROM fruits WHERE fruit='Carrot';
SELECT * FROM fruits;
