USE test;

UPDATE vegetables SET id=10 WHERE vegetable='Cabbage';
SELECT * FROM vegetables;

UPDATE vegetables SET id=20, vegetable="White Cabbage" WHERE id=10;
SELECT * FROM vegetables;
