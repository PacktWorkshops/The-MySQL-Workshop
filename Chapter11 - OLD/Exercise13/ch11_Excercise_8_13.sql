USE world;
SELECT * FROM city_export WHERE District='Moskova';
# Now modify the city_export.CSV file
FLUSH TABLE city_export;
SELECT * FROM city_export WHERE District='Moskova';

