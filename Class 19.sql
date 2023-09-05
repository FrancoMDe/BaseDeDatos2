#1
CREATE USER data_analyst IDENTIFIED BY 'password';
SELECT User, Host, plugin FROM mysql.user;  #mostrar todos lo usuarios

#2

GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'%';
SHOW GRANTS FOR 'data_analyst'@'%'; # ver los permisos

#3
#mysql -udata_analyst -ppassword; 

CREATE TABLE filmFake(
	film_id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(30) NOT NULL,
	description VARCHAR(30),
	release_year YEAR NOT NULL,
	PRIMARY KEY (film_id)
);

#ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'filmFake'

#4
SELECT title, film_id FROM film order by film_id;

UPDATE film SET title = 'INTERESTELAR' WHERE film_id = 3;#film_id=3 es adaptation holes
#film_id=3 es INTERESTELAR

#5
# sudo mysql -u root --Comando para ser root

REVOKE UPDATE ON sakila.* FROM data_analyst;
SHOW GRANTS FOR 'data_analyst'@'%'; # ver que ya no aparece UPDATE
#6
#mysql -udata_analyst -ppassword
use sakila;
UPDATE film SET title = 'OPPENHEIMER' WHERE film_id = 3;
#ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'
#ya no tenemos los permisos para hacer un update de title