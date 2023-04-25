USE sakila;	
# 1
SELECT first_name, last_name 
FROM actor A
WHERE EXISTS (
        SELECT * 
        FROM actor A2
        WHERE A.last_name = A2.last_name
        AND A.actor_id <> A2.actor_id
	)
ORDER BY A.last_name;

# 2
SELECT
    A.first_name,
    A.last_name
FROM actor A
WHERE NOT EXISTS (
        SELECT *
        FROM film_actor FA
        WHERE A.actor_id = FA.actor_id
    	);

# 3
SELECT C.first_name, C.last_name
FROM customer C
WHERE 1 = (
        SELECT COUNT(*)
        FROM rental R
        WHERE C.customer_id = R.customer_id
    	);

# 4
SELECT C.first_name, C.last_name
FROM customer C
WHERE 1 < (
        SELECT COUNT(*)
        FROM rental R
        WHERE C.customer_id = R.customer_id
    	);

# 5
SELECT A.actor_id, A.first_name, A.last_name
FROM actor A
WHERE EXISTS(
        SELECT title
        FROM film F
        JOIN film_actor FA ON F.film_id = FA.film_id
        WHERE F.film_id = FA.film_id
        AND A.actor_id = FA.actor_id
        AND ( F.title = 'BETRAYED REAR'
              OR F.title = 'CATCH AMISTAD'
            )
    	);

# 6
SELECT actor_id, first_name, last_name
FROM actor A
WHERE EXISTS(
        SELECT title
        FROM film F
        JOIN film_actor FA ON F.film_id = FA.film_id
        WHERE F.film_id = FA.film_id
        AND A.actor_id = FA.actor_id
        AND F.title = 'BETRAYED REAR'
	)
AND NOT EXISTS (
        SELECT title
        FROM film F
        JOIN film_actor FA ON F.film_id = FA.film_id
        WHERE F.film_id = FA.film_id
        AND A.actor_id = FA.actor_id
        AND F.title = 'CATCH AMISTAD'
	);

# 7
SELECT actor_id, first_name, last_name
FROM actor A
WHERE EXISTS(
        SELECT title
        FROM film F
        JOIN film_actor FA ON F.film_id = FA.film_id
        WHERE F.film_id = FA.film_id
        AND A.actor_id = FA.actor_id
        AND F.title = 'BETRAYED REAR'
	)
AND EXISTS (
	SELECT title
        FROM film F
        JOIN film_actor FA ON F.film_id = FA.film_id
        WHERE F.film_id = FA.film_id
        AND A.actor_id = FA.actor_id
        AND F.title = 'CATCH AMISTAD'
	);

# 8
SELECT actor_id, first_name, last_name
FROM actor A
WHERE NOT EXISTS (
        SELECT title
        FROM film F
        JOIN film_actor FA ON F.film_id = FA.film_id
        WHERE F.film_id = FA.film_id
        AND A.actor_id = FA.actor_id
        AND ( F.title = 'BETRAYED REAR'
              OR F.title = 'CATCH AMISTAD'
            )
    	);
