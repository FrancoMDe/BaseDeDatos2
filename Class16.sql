#1
CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle) 
VALUES 
  (1002, 'Murphy', 'Diane', 'x5800', 'dmurphy@classicmodelcars.com', '1', NULL, 'President'),
  (1056, 'Patterson', 'Mary', 'x4611', 'mpatterso@classicmodelcars.com', '1', 1002, 'VP Sales'),
  (1076, 'Firrelli', 'Jeff', 'x9273', 'jfirrelli@classicmodelcars.com', '1', 1002, 'VP Marketing');


INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES (1077, 'Carranza', 'Santiago', 'lllll', NULL, '2', 1002, 'Pepe');
#como fue declarado en la definicion de la tabla, la columna email no puede ser null "`email` varchar(100) NOT NULL"

#2
UPDATE employees SET employeeNumber = employeeNumber - 20
# se restan 20 unidades a cada employeeNumber

UPDATE employees SET employeeNumber = employeeNumber + 20
/*
  (1056, 'Patterson', 'Mary', 'x4611', 'mpatterso@classicmodelcars.com', '1', 1002, 'VP Sales'),
  (1076, 'Firrelli', 'Jeff', 'x9273', 'jfirrelli@classicmodelcars.com', '1', 1002, 'VP Marketing');
*/ #como se llevan una diferencia de 20, cuando intenta sumarle 20 a Patterson, no puede porque ya esta firelli 
   # que tiene una id de 1076, a diferencia de cuando resta, que primero le resta a patterson y despues a firelli 

#3
ALTER TABLE employees
ADD COLUMN age INT CHECK (age >= 16 AND age <= 70);

#4
# la tabla film_actor funciona como tabla intermedia entre film y actor, permitiendo que la relacion 
# muchos a muchos que existe entre ambas tablas funcione. Un actor actua en muchas peliculas, no solo una,
# mientras que una pelicula tiene varios actores. dentro de la tabla film_actor, film_id conecta la pelicula con
# actor_id, indicando que en tal pelicula actuó tal actor, asi con todos los registros de film_actor

#5
ALTER TABLE employees
ADD COLUMN lastUpdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
ADD COLUMN lastUpdateUser VARCHAR(50);
#inserts de nuevos empleados
DELIMITER //
CREATE TRIGGER employee_insert_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

#updates de empleados
DELIMITER //
CREATE TRIGGER employee_update_trigger
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

Show TRIGGERS;

#6
Show TRIGGERS;
#muestra todos los triggers, 

# Ins_film es el primer TRIGGER
BEGIN     INSERT INTO film_text (film_id, title, description)         VALUES (new.film_id, new.title, new.description);   END
#Ins_film copia automáticamente los valores de film_id, title, y description de una fila recién insertada en otra tabla llamada film_text. Sirve para mantener sincronizados los datos entre las dos tablas.

#upd_film es el segundo trigger que se muestra
BEGIN     IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)     THEN         UPDATE film_text             SET title=new.title,                 description=new.description,                 film_id=new.film_id         WHERE film_id=old.film_id;     END IF;   END
#updatea automáticamente los valores en la tabla film_text cuando se modifica una fila en otra tabla. 
#Se asegura que los datos en las dos tablas esten sincronizados, reflejando los cambios realizados en la fila original en la tabla film_text.

#del_film es el tercer trigger relacionado con film_text
BEGIN     DELETE FROM film_text WHERE film_id = old.film_id;   END
#borra automáticamente filas en la tabla film_text cuando se elimina una fila correspondiente en otra tabla. 