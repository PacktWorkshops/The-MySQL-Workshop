USE test;

CREATE TABLE months (
  month_number tinyint unsigned primary key,
  month_name varchar(15),
  CHECK (month_number <= 12)
);
DESCRIBE months;
INSERT INTO months VALUES (1, 'January');

--error 1136
INSERT INTO months VALUES ('February');

--error 1366
INSERT INTO months VALUES ('February', 2);

--error 3819
INSERT INTO months VALUES (15, 'February');

--error 1406
INSERT INTO months VALUES (2, 'The month February');
