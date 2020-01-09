USE world_simple;

SELECT * FROM city WHERE ID=2460;
EXPLAIN SELECT * FROM city WHERE ID=2460;

ALTER TABLE city ADD PRIMARY KEY (ID);
EXPLAIN SELECT * FROM city WHERE ID=2460;

EXPLAIN SELECT * FROM country co LEFT JOIN city ci
ON ci.CountryCode=co.Code WHERE ci.ID=540;

ALTER TABLE country ADD PRIMARY KEY (Code);

EXPLAIN SELECT * FROM country co LEFT JOIN city ci
ON ci.CountryCode=co.Code WHERE ci.ID=540;

EXPLAIN FORMAT=JSON SELECT * FROM country co
LEFT JOIN city ci ON ci.CountryCode=co.Code WHERE ci.ID=540;

EXPLAIN FORMAT=TREE SELECT * FROM country co 
LEFT JOIN city ci ON ci.CountryCode=co.Code
WHERE ci.ID=540;

# Requires MySQL 8.0.18 or newer
# Replace column 1 as it has timing info that differs
# per run.
--replace_column 1 OUTPUT
EXPLAIN ANALYZE SELECT * FROM country co 
LEFT JOIN city ci ON ci.CountryCode=co.Code
WHERE ci.ID=540;
