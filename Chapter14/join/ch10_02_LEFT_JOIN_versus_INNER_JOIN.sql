USE world_simple;

INSERT INTO city VALUES(2460, 'Skopje', 'MKD');

SELECT ci.Name, co.Code AS CountryCode, co.Name  AS CountryName 
FROM city ci JOIN country co ON ci.CountryCode=co.Code;

SELECT ci.Name, co.Code AS CountryCode, co.Name  AS CountryName 
FROM city ci LEFT JOIN country co ON ci.CountryCode=co.Code;

SELECT co.Name, COUNT(*) FROM country co
LEFT JOIN city ci ON ci.CountryCode=co.Code
GROUP BY co.Name;

SELECT co.Name, COUNT(*) FROM country co
RIGHT JOIN city ci ON ci.CountryCode=co.Code GROUP BY co.Name;
