DROP DATABASE IF EXISTS imdb;
CREATE DATABASE imdb;
USE imdb;

CREATE TABLE film (
	id INT NOT NULL auto_increment PRIMARY KEY,
  	title VARCHAR(50),
  	description VARCHAR(50),
  	releaseYear year
);

CREATE TABLE actor (
	id INT NOT NULL auto_increment PRIMARY KEY,
  	firstName VARCHAR(50),
  	lastName VARCHAR(50)
);

CREATE TABLE film_actor (
	id INT NOT NULL auto_increment PRIMARY KEY,
  	idFilm INT,
  	idActor INT
);

-- Alter 

ALTER TABLE film ADD lastUpdate INT;
ALTER TABLE actor ADD lastUpdate INT;
ALTER TABLE film_actor ADD FOREIGN KEY (idFilm) REFERENCES film(id);
ALTER TABLE film_actor ADD FOREIGN KEY (idActor) REFERENCES actor(id);

-- Insert film

INSERT INTO film (title, description, releaseYear) VALUES ('Piratas del caribe', 'una pelicula de piratas', 2003);
INSERT INTO film (title, description, releaseYear) VALUES ('El lobo de wall street', 'una pelicula sobre la bolsa', 2013);
INSERT INTO film (title, description, releaseYear) VALUES ('8 Mile', 'una pelicula de eminem', 2002);

-- Insert actor

INSERT INTO actor (firstName, lastName) VALUES ('Johnny', 'Depp');
INSERT INTO actor (firstName, lastName) VALUES ('Leonardo', 'DiCaprio');
INSERT INTO actor (firstName, lastName) VALUES ('Jimmy', 'Smith Jr.');

-- Insert film_actor

INSERT INTO film_actor (idActor, idFilm) VALUES (1, 1); 
INSERT INTO film_actor (idActor, idFilm) VALUES (2, 2); 
INSERT INTO film_actor (idActor, idFilm) VALUES (3, 3); 

