--disable_warnings
CREATE SCHEMA IF NOT EXISTS employees;
CREATE SCHEMA IF NOT EXISTS ebike;
DROP USER IF EXISTS 'patrick'@'%';
DROP USER IF EXISTS 'mike'@'%';
DROP USER IF EXISTS 'webserver'@'%';
--enable_warnings

CREATE USER 'patrick'@'%' IDENTIFIED BY 'NijTaseirpyocyea';
CREATE USER 'mike'@'%' IDENTIFIED BY 'MyhafDixByej';
CREATE USER 'webserver'@'%' IDENTIFIED BY 'augJigFevni' WITH MAX_USER_CONNECTIONS 300;
GRANT ALL ON employees.* TO 'patrick'@'%';
GRANT ALL ON ebike.* TO 'patrick'@'%';
GRANT ALL ON ebike.* TO 'mike'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON ebike.* TO 'webserver'@'%';
