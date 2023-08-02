#1
CREATE
OR
REPLACE
    VIEW list_of_customer AS
SELECT
    cu.customer_id,
    CONCAT(
        cu.first_name,
        ' ',
        cu.last_name
    ) AS full_name,
    a.`address`,
    a.postal_code as zip_code,
    a.phone,
    ci.city,
    co.country,
    if(cu.active, 'active', '') AS `status`,
    cu.store_id
FROM customer cu
    JOIN `address` a using(address_id)
    JOIN city ci using(city_id)
    JOIN country co using(country_id);

SELECT * FROM list_of_customer;

#2
CREATE
OR
REPLACE VIEW film_details AS
SELECT
    f.film_id,
    f.title,
    f.description,
    ca.name AS category,
    f.rental_rate AS price,
    f.length,
    f.rating,
    group_concat(
        concat(
            ac.first_name,
            ' ',
            ac.last_name
        )
        ORDER BY
            ac.first_name SEPARATOR ', '
    ) as actors
FROM film f
    JOIN film_category using(film_id)
    JOIN category ca using(category_id)
    JOIN film_actor using(film_id)
    JOIN actor ac using(actor_id)
GROUP BY f.film_id, ca.name;

SELECT * FROM film_details;

#3
CREATE
OR
REPLACE
    VIEW sales_by_film_category AS
SELECT
    ca.name AS category,
    sum(pa.amount) AS total_sales
from payment pa
    JOIN rental using(rental_id)
    JOIN inventory using(inventory_id)
    JOIN film using(film_id)
    JOIN film_category USING(film_id)
    JOIN category ca using(category_id)
GROUP BY ca.`name`
ORDER BY total_sales;

SELECT * FROM sales_by_film_category;

#4.
CREATE
OR
REPLACE
    VIEW actor_information AS
SELECT
    ac.actor_id as actor_id,
    ac.first_name as first_name,
    ac.last_name as last_name,
    COUNT(film_id) as films
FROM actor ac
    JOIN film_actor using(actor_id)
GROUP BY
    ac.actor_id,
    ac.first_name,
    ac.last_name;

SELECT * FROM actor_information;

#5
/*
 La query devuelve: 
 - id de actor
 - nombre de actor
 - apellido de actor
 - lista de peliculas que actuo, mostrado categoria-pelicula alfabeticamente
 */
/*
 #6.
 Una vista materializada es una copia almacenada de los resultados de una consulta en una base de datos. 
 Esto se usa para acelerar las consultas y reducir el trabajo de la base de datos. Cuando creamos una vista materializada, los resultados de la consulta se calculan una vez y se guardan, evitando tener que volver a calcularlos cada vez que se haga la consulta.
 */