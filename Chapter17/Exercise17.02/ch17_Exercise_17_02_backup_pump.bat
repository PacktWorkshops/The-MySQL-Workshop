mysqlpump -u root -p --single-transaction --set-gtid-purged=OFF --compress-output zlib coffeeprefs --result-file="C:\Temp\coffeeprefs.sql.gz"

zlib_decompress 
"C:\Temp\coffeeprefs.sql.gz" 
"C:\Users\BHAVESH\Desktop\Coffee\coffeeprefs.sql"