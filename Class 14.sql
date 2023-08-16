#1
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS CustomerName,
    a.address AS CustomerAddress,
    ct.city AS CustomerCity
FROM customer AS c
JOIN store AS s ON c.store_id = s.store_id
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ct ON a.city_id = ct.city_id
JOIN country AS co ON ct.country_id = co.country_id
WHERE co.country = 'Argentina';
#2

SELECT
    f.title,
    l.name AS language,
    f.rating,
    CASE
        WHEN f.rating = 'G' THEN 'All ages admitted'
        WHEN f.rating = 'PG' THEN 'Some material may not be suitable for children'
        WHEN f.rating = 'PG-13' THEN 'Some material may be inappropriate for children under 13'
        WHEN f.rating = 'R' THEN 'Under 17 requires accompanying parent or adult guardian'
        WHEN f.rating = 'NC-17' THEN 'No one 17 and under admitted'
    END AS 'Rating Text'
FROM film AS f
INNER JOIN language AS l ON f.language_id = l.language_id;

#3

SELECT
    CONCAT(ac.first_name, ' ', ac.last_name) AS actor,
    f.title AS film,
    f.release_year AS release_year
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor ac ON fa.actor_id = ac.actor_id
WHERE CONCAT(ac.first_name, ' ', ac.last_name) LIKE CONCAT('%', UPPER(TRIM('KIRSTEN AKROYD')), '%');

#4

SELECT
    f.title,
    r.rental_date,
    c.first_name AS customer_name,
    CASE
        WHEN r.return_date IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS 'Returned'
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN customer c ON r.customer_id = c.customer_id
WHERE MONTH(r.rental_date) = 5 OR MONTH(r.rental_date) = 6
ORDER BY r.rental_date;

#5
/*
Función de CAST: Utilizamos la función de CAST con el propósito de transformar un valor que pertenece a un tipo de datos en otro tipo específico. Esto resulta particularmente beneficioso cuando surge la necesidad de modificar el tipo de datos de una columna o expresión en una consulta.

Función de CONVERSIÓN: En contraste, la función de CONVERSIÓN también cumple la tarea de transformar tipos de datos, pero va un paso más allá en términos de funcionalidad. Además de llevar a cabo cambios en los tipos, CONVERSIÓN permite efectuar modificaciones en conjuntos de caracteres, posibilitando así el ajuste del juego de caracteres asociado a los datos. Esta función se torna invaluable cuando se requiere la modificación tanto del tipo de datos como del juego de caracteres.

Distinciones clave:
La diferencia primordial radica en la capacidad de CONVERSIÓN para gestionar la transformación de conjuntos de caracteres. Mediante esta función, es posible alterar la representación de caracteres en una columna específica. Por otra parte, el uso de CAST se limita exclusivamente a la modificación del tipo de datos de un valor.
*/

#Ejemplos de CAST
#Supongamos que queremos la duracion de las rentas en horas y no en minutos
SELECT title, CAST(rental_duration / 60.0 AS DECIMAL(5,2)) AS duration_in_hours
FROM film;
#Ejemplos CONVERT
#Mostrar fecha en dia mes año
SELECT payment_id,
       CONVERT(payment_date, CHAR) AS original_date,
       DATE_FORMAT(payment_date, '%W, %M %e %Y') AS custom_date_format
FROM payment;
#Mostrar el id de los clientes, convertir el mail a mayúsculas y mostrar la fecha de la última actualización en dia mes año:
SELECT customer_id,
       CONVERT(UPPER(email) USING utf8) AS formatted_email,
       DATE_FORMAT(last_update, '%d-%m-%Y') AS custom_last_update_format
FROM customer;

#6
/*
Estas funciones, como NVL, ISNULL, IFNULL y COALESCE, permiten devolver un valor alternativo cuando una expresión es NULL en una consulta SQL.

Diferencias entre ellas:
Cada función se usa en diferentes sistemas de administración de bases de datos (DBMS). Por ejemplo, en MySQL, solo estan IFNULL y COALESCE, 
NVL e ISNULL no están disponibles.

Ejemplos de uso:

IFNULL:
Supongamos que queremos mostrar información sobre las direcciones, pero si la dirección 2 es null, queremos mostrar un valor alternativo:
*/
SELECT address_id, address, IFNULL(address2, "No tiene direccion") AS direccion_alternativa
FROM address;

#COALESCE:
#Si queremos mostrar lo mismo pero usando la función COALESCE:

SELECT address_id, address, COALESCE(address2, "No tiene direccion") AS direccion_alternativa
FROM address;
