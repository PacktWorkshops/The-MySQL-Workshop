USE world_simple;

SELECT Name FROM country WHERE Code='ROM'
UNION
SELECT Name FROM country WHERE Code='BGR';

WITH RECURSIVE numbers AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n+1 FROM numbers WHERE n<12
)
SELECT 
  n,
  monthname(CONCAT("2019-",n,"-01"))
FROM numbers;

WITH RECURSIVE numbers AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n+1 FROM numbers WHERE n<12
),
months AS (
  SELECT n, monthname(CONCAT("2019-",n,"-01"))
  FROM numbers
)
SELECT * FROM months;
