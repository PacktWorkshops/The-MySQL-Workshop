USE test;

--disable_warnings
DROP TABLE IF EXISTS vegetables;
--enable_warnings

CREATE TABLE vegetables (id int primary key, vegetable varchar(255));
INSERT INTO vegetables VALUES (1, 'Broccoli'), (2, 'Cabbage'), (3, 'Apple');
DELETE FROM v USING vegetables v JOIN fruits f ON v.vegetable=f.fruit;
SELECT * FROM vegetables;
