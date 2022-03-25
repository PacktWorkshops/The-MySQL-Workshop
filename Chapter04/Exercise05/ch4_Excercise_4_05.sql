SELECT Name, CASE WHEN population < 100000 THEN 'small'
WHEN population < 500000 then 'medium'
ELSE 'large' END AS countrySize
FROM world.country;