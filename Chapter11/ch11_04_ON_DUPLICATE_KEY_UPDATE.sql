USE test;

--disable_warnings
DROP TABLE IF EXISTS logincount;
--enable_warnings

CREATE TABLE logincount (user varchar(255) primary key, logins int not null);

INSERT INTO logincount VALUES ('jdoe', 1) ON DUPLICATE KEY
  UPDATE logins=logins+1;
SELECT * FROM logincount;

INSERT INTO logincount VALUES ('jdoe', 1) ON DUPLICATE KEY
  UPDATE logins=logins+1;
SELECT * FROM logincount;
