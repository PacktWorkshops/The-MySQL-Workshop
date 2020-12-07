USE world_simple;

SELECT * FROM city WHERE ID=2460;
EXPLAIN SELECT * FROM city WHERE ID=2460;

ALTER TABLE city ADD PRIMARY KEY (ID);
EXPLAIN SELECT * FROM city WHERE ID=2460;

EXPLAIN SELECT * FROM country co LEFT JOIN city ci
ON ci.CountryCode=co.Code WHERE ci.ID=540\G

ALTER TABLE country ADD PRIMARY KEY (Code);

EXPLAIN SELECT * FROM country co LEFT JOIN city ci
ON ci.CountryCode=co.Code WHERE ci.ID=540\G

EXPLAIN FORMAT=JSON SELECT * FROM country co
LEFT JOIN city ci ON ci.CountryCode=co.Code WHERE ci.ID=540\G

EXPLAIN FORMAT=TREE SELECT * FROM country co 
LEFT JOIN city ci ON ci.CountryCode=co.Code
WHERE ci.ID=540\G

EXPLAIN ANALYZE SELECT * FROM country co 
LEFT JOIN city ci ON ci.CountryCode=co.Code
WHERE ci.ID=540\G
