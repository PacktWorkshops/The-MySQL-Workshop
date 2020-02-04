--disable_warnings
DROP USER IF EXISTS 'sarah'@'%';
--enable_warnings

CREATE USER 'sarah'@'%' IDENTIFIED BY 'IkbyewUgJeuj8';
GRANT ALL ON ebike.* TO 'sarah'@'%';
GRANT ALL ON mobileapp.* TO 'sarah'@'%';

GRANT ALL ON mobileapp.* TO 'mike'@'%';
GRANT ALL ON mobileapp.* TO 'patrick'@'%';
GRANT ALL ON mobileapp.* TO 'webserver'@'%';

ALTER USER 'patrick'@'%' IDENTIFIED BY 'WimgeudJa';
