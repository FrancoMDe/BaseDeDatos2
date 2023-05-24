#1
SELECT title, length
FROM film
WHERE length = (SELECT MIN(length) FROM film);

#2
select title, length
FROM film AS f1
WHERE length <= (SELECT MIN(length) FROM film)
AND NOT EXISTS(SELECT * FROM film AS f2 WHERE f2.film_id != f1.film_id AND f2.length <= f1.length);

#3
SELECT c.first_name AS nombre,c.last_name AS apellido, a.address AS direccion,
	(SELECT MIN(amount) FROM payment p WHERE c.customer_id = p.customer_id ) AS min
FROM customer c
JOIN address a ON c.address_id = a.address_id
ORDER BY c.first_name;

#4
SELECT c.first_name AS nombre,c.last_name AS apellido, a.address AS direccion,
	(SELECT MIN(amount) FROM payment p WHERE c.customer_id = p.customer_id ) AS min, 
	(SELECT MAX(amount) FROM payment p WHERE c.customer_id = p.customer_id ) AS max
FROM customer c
JOIN address a ON c.address_id = a.address_id
ORDER BY c.first_name;