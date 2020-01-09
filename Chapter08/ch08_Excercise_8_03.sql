USE test;

DESCRIBE animals;

TRUNCATE TABLE animals;

BEGIN;

INSERT INTO animals VALUES(1, 'dolphin');

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;
