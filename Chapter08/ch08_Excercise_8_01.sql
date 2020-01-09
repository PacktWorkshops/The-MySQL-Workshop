USE test;

--disable_warnings
DROP TABLE IF EXISTS animals;
--enable_warnings

CREATE TABLE animals ( id int primary key, name varchar(255) );

DESCRIBE animals;

INSERT INTO animals VALUES(1, 'dog');

SELECT * FROM animals;
