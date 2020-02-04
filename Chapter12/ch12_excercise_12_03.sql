--disable_warnings
DROP ROLE IF EXISTS 'manager';
DROP ROLE IF EXISTS 'webdeveloper';
DROP ROLE IF EXISTS 'appdeveloper';
DROP USER IF EXISTS 'linda'@'%';
DROP USER IF EXISTS 'john'@'%';
DROP USER IF EXISTS 'vladimir'@'%';
DROP USER IF EXISTS 'jack'@'%';
--enable_warnings

CREATE ROLE 'manager';
GRANT ALL ON employees.* TO 'manager';
CREATE ROLE 'webdeveloper';
GRANT ALL ON ebike.* TO 'webdeveloper';
CREATE ROLE 'appdeveloper';
GRANT ALL ON mobileapp.* TO 'appdeveloper';

CREATE USER 'linda'@'%' IDENTIFIED BY 'AkFernyeisjegs' DEFAULT ROLE manager;
CREATE USER 'john'@'%' IDENTIFIED BY 'owvurewJatkinyegod' DEFAULT ROLE manager;
CREATE USER 'vladimir'@'%' IDENTIFIED BY 'rusvawfyoaw' DEFAULT ROLE appdeveloper;
CREATE USER 'jack'@'%' IDENTIFIED BY 'joigowInladdIc6' DEFAULT ROLE webdeveloper;

GRANT manager, webdeveloper, appdeveloper TO 'patrick'@'%';
ALTER USER 'patrick'@'%' DEFAULT ROLE manager;
GRANT webdeveloper, appdeveloper TO 'mike'@'%';
ALTER USER 'mike'@'%' DEFAULT ROLE webdeveloper, appdeveloper;
GRANT webdeveloper, appdeveloper TO 'sarah'@'%';
ALTER USER 'sarah'@'%' DEFAULT ROLE webdeveloper, appdeveloper;
