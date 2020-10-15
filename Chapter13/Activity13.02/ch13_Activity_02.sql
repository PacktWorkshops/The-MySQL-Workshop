RESET MASTER;
-- This works after bat first is run
USE world;
UPDATE city SET Population=123456789 WHERE name = 'Toulouse';
DELETE FROM city;
SHOW MASTER LOGS;
SHOW BINLOG EVENTS IN 'binlog.000001';
-- this is ran after restore.