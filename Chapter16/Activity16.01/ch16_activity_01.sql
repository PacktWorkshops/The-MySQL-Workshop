--disable_warnings
DROP ROLE IF EXISTS 'manager';
DROP ROLE IF EXISTS 'language_expert';
DROP USER IF EXISTS 'webserver'@'%';
DROP USER IF EXISTS 'intranet'@'%';
DROP USER IF EXISTS 'stewart'@'%';
DROP USER IF EXISTS 'sue'@'%';
--enable_warnings

CREATE ROLE 'manager';
GRANT ALL ON world.* TO 'manager';
CREATE ROLE 'language_expert';
GRANT ALL ON world.countrylanguage TO 'language_expert';

CREATE USER 'webserver'@'%' IDENTIFIED BY '1twedByutGiawWy';
GRANT SELECT ON world.* TO 'webserver'@'%';

CREATE USER 'intranet'@'%' IDENTIFIED BY 'JiarjOodVavit';
GRANT INSERT, UPDATE, SELECT ON world.* TO 'intranet'@'%';

CREATE USER 'stewart'@'%'
IDENTIFIED BY 'UkfejmuniadBekMow4'
DEFAULT ROLE manager;

CREATE USER 'sue'@'%'
IDENTIFIED BY 'WrawdOpAncy'
DEFAULT ROLE language_expert;
