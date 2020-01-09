USE test;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
  employee_id INT PRIMARY KEY,
  region CHAR(5),
  city VARCHAR(15),
  sales INT
);

INSERT INTO sales VALUES
  (1, 'EMEA', 'London', 300000),
  (2, 'EMEA', 'Milan', 250000),
  (3, 'APAC', 'Singapore', 350000),
  (4, 'APAC', 'Jakarta', 100000);


SELECT region, SUM(sales) FROM sales GROUP BY region;

--error 1055
SELECT city, SUM(sales) FROM sales GROUP BY region;

SELECT city, SUM(sales) FROM sales GROUP BY city;

SELECT region, AVG(sales)
FROM sales
GROUP BY region
HAVING AVG(sales) > 230000;
