USE sakila;

SELECT COUNT(*)
FROM film f
JOIN inventory i ON f.film_id=i.film_id
WHERE f.rating='PG';

SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id=fa.film_id
JOIN actor a ON a.actor_id=fa.actor_id
WHERE a.first_name='EMILY' AND a.last_name='DEE';

SELECT c.first_name, c.last_name, COUNT(*) FROM rental r
JOIN customer c ON r.customer_id=c.customer_id
GROUP BY c.customer_id ORDER BY COUNT(*) DESC LIMIT 1;

SELECT f.title, SUM(p.amount)
FROM payment p
JOIN rental r ON p.rental_id=r.rental_id
JOIN inventory i ON i.inventory_id=r.inventory_id
JOIN film f ON f.film_id=i.film_id
GROUP by f.film_id
ORDER BY SUM(p.amount) DESC LIMIT 1;

SELECT email
FROM customer cu
JOIN address a ON cu.address_id=a.address_id
JOIN city ci ON ci.city_id=a.city_id
JOIN country co ON co.country_id=ci.country_id
WHERE country='Turkmenistan'\G
