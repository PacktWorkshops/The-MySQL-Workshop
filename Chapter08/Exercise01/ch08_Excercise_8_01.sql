CREATE DATABASE IF NOT EXISTS test;

use test;

CREATE TABLE animals ( id int primary key, name varchar(255) );

DESCRIBE animals;

INSERT INTO animals VALUES(1, 'dog');

SELECT * FROM animals;
