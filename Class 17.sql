#1
-- in
SELECT a.address, a.postal_code, ci.city, co.country
FROM address AS a
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE a.postal_code IN ('35200', '17886', '83579');
#12ms
-- Not In
SELECT a.address, a.postal_code, ci.city, co.country
FROM address AS a
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE a.postal_code NOT IN ('35200', '17886', '83579');
#5ms
CREATE INDEX PostalCode ON address(postal_code);
#Primera query despues del index =4ms, la segunda = 4ms
#Explicacion: El index crea una lista que permite a la base de datos ir directamente al index enves de ir uno por uno

#2
SELECT first_name
FROM actor
ORDER BY first_name;
#12ms

SELECT last_name
FROM actor
ORDER BY last_name;
#4ms
# la diferencia en el tiempo de ejecucion esta en que, existe
# precargado en sakila, un index para "last_name" y no para "first_name"

SHOW INDEX FROM actor; #la query para mostrar los index existentes

#3

SELECT description
FROM film
WHERE description LIKE "%Character%"
ORDER BY description;
# 80ms

#para usar match y against, si o si hay que tener un index llamado "Fulltext"
CREATE FULLTEXT INDEX FullText_idx ON film(description);

SELECT description
FROM film
WHERE MATCH(description) AGAINST("Character")
ORDER BY description;
# 13ms
#una vez runeada la query con el index ya hecho, se ve que es sustancialmente mas rapida la ejecucion