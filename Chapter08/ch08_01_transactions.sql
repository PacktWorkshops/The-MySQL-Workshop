USE test;

--disable_warnings
DROP TABLE IF EXISTS mytable;
--enable_warnings

CREATE TABLE mytable (
  id int primary key,
  c1 varchar(10),
  c2 varchar(10),
  c3 varchar(10)
);

BEGIN;
INSERT INTO mytable VALUES (1, 'foo', 'bar', 'baz');
SELECT * FROM mytable;
COMMIT;

TRUNCATE mytable;
