mysqldump --master-data=2 -u root -p world > "C:\Temp\backup_world_pitr.sql"
:: this is done later
mysqlbinlog -u root -p -–skip-gtids --stop-position=522 "C:\ProgramData\MySQL\MySQL Server 8.0\Data\PPMUMCPU0032-bin.000001" > "C:\Temp\restore_world_pitr.sql"
mysql -u root -p world < "C:\Temp\backup_world_pitr.sql"
mysql -u root -p < "C:\Temp\restore_world_pitr.sql"