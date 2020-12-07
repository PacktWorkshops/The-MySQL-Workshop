USE test;

--disable_warnings
DROP TABLE IF EXISTS users;
--enable_warnings

CREATE TABLE users (user varchar(255) primary key, has_logged_in int not null);

INSERT INTO users VALUES ('jdoe', 0), ('monty', 0), ('sakila', 0);

UPDATE users u JOIN logincount l on u.user=l.user SET u.has_logged_in=TRUE WHERE l.logins>0;

SELECT * FROM users;
