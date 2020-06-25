/*Set the default collation on the database schema*/
ALTER DATABASE `ms_access_migration`  CHARACTER SET utf8mb4 COLLATE = utf8mb4_unicode_ci ;

/*Set the default collation on the tables, using convert will also set it for the fields in each table*/
ALTER TABLE ms_access_migration.badbits CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
ALTER TABLE ms_access_migration.capacityindicatorsstats CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
ALTER TABLE ms_access_migration.country CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
ALTER TABLE ms_access_migration.errorlog CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
ALTER TABLE ms_access_migration.genderstats CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
ALTER TABLE ms_access_migration.jobstats CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
ALTER TABLE ms_access_migration.lookups CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
ALTER TABLE ms_access_migration.series CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
ALTER TABLE ms_access_migration.users CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;