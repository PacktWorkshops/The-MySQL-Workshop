USE sakila;

SELECT 
  f.title, release_year,
  count(fa.film_id) 'actors',
  count(fc.film_id) 'categories' 
FROM film f
LEFT JOIN inventory i ON f.film_id=i.film_id
JOIN film_actor fa ON fa.film_id=f.film_id
JOIN film_category fc ON fc.film_id=f.film_id
WHERE i.film_id IS NULL AND f.release_year=2006
GROUP BY f.film_id;

START TRANSACTION;

DELETE fc
FROM film f
LEFT JOIN inventory i ON f.film_id=i.film_id
JOIN film_actor fa ON fa.film_id=f.film_id
JOIN film_category fc ON fc.film_id=f.film_id
WHERE i.film_id IS NULL AND f.release_year=2006;
DELETE fa
FROM film f
LEFT JOIN inventory i ON f.film_id=i.film_id
JOIN film_actor fa ON fa.film_id=f.film_id
JOIN film_category fc ON fc.film_id=f.film_id
WHERE i.film_id IS NULL AND f.release_year=2006;
DELETE f
FROM film f
LEFT JOIN inventory i ON f.film_id=i.film_id
JOIN film_actor fa ON fa.film_id=f.film_id
JOIN film_category fc ON fc.film_id=f.film_id
WHERE i.film_id IS NULL AND f.release_year=2006;

ROLLBACK;
