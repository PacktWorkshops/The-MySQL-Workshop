:: Backup the schema
mysqldump -u root -p world > "C:\Temp\world_backup.sql"
:: continue with sql file
:: restore schema
mysql -u root -p world < "C:\Temp\world_backup.sql"