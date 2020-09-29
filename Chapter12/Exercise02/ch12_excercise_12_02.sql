--disable_warnings
DROP USER IF EXISTS 'sarah'@'%';
DROP USER IF EXISTS 'webserver2'@'%';
--enable_warnings

CREATE USER 'sarah'@'%' IDENTIFIED BY 'IkbyewUgJeuj8';
GRANT ALL ON ebike.* TO 'sarah'@'%';
GRANT ALL ON mobileapp.* TO 'sarah'@'%';

GRANT ALL ON mobileapp.* TO 'mike'@'%';
GRANT ALL ON mobileapp.* TO 'patrick'@'%';
GRANT ALL ON mobileapp.* TO 'webserver'@'%';

REVOKE ALL ON ebike.* FROM 'mike'@'%';

ALTER USER 'patrick'@'%' IDENTIFIED BY 'WimgeudJa';

# SHOW GRANTS FOR 'webserver'@'%';

CREATE USER 'webserver2'@'%' IDENTIFIED BY 'dutPyicloHi' WITH MAX_USER_CONNECTIONS 300;
GRANT SELECT, INSERT, UPDATE, DELETE ON `ebike`.* TO `webserver2`@`%`;
GRANT ALL PRIVILEGES ON `mobileapp`.* TO `webserver2`@`%`;

ALTER USER 'webserver'@'%' ACCOUNT LOCK;
