USE sakila;

WITH films_in_range AS (
SELECT * FROM film
WHERE release_year BETWEEN 2005 AND 2010)

SELECT release_year, COUNT(release_year)
FROM films_in_range;