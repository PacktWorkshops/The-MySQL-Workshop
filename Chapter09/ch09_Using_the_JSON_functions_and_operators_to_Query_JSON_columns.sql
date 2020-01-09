USE world;

SELECT doc->>'$.name' FROM worldcol LIMIT 5;

SELECT JSON_UNQUOTE(JSON_EXTRACT(doc, '$.name')) FROM worldcol LIMIT 5;

SELECT JSON_OBJECT('name', Name, 'continent', Continent) FROM country LIMIT 5;

SELECT Continent, JSON_ARRAYAGG(name) AS countries 
FROM country GROUP BY continent;

--error 1091
ALTER TABLE worldcol DROP COLUMN district;
ALTER TABLE worldcol
ADD COLUMN district VARCHAR(255) AS (doc->>'$.district') NOT NULL;

--error 1048
INSERT INTO worldcol(doc) VALUES('{"_id": 999999 }');

ALTER TABLE worldcol ADD INDEX(district);

--error 1091
ALTER TABLE worldcol DROP COLUMN name;
ALTER TABLE worldcol
ADD COLUMN name VARCHAR(255) AS (doc->>'$.name') STORED NOT NULL;
