# MariaDB + SQL Basics

## Initial Setup

### Installation
	apt install mariadb-server
	mysql_basic_installation

### Service management

`sytemctl (status|reload|restart) mariadb`

	sytemctl status mariadb

## Navigation

### Launching mariadb

#### As root (via unix_socket):

`(mariadb | sudo mariadb)`

	mariadb

#### As a registered database user :

`mariadb -u <user> [-p] [<database>]`

	mariadb -u <user>

### Selecting Databases

```SHOW DATABASES;```
```USE <database>;```

	SHOW TABLES;
	USE mysql;

### Consulting Tables

`SHOW TABLES;`
`DESCRIBE <table>;`

	SHOW TABLES;
	DESCRIBE user;

### Exiting mariadb

	exit

## Creating data stores and actors

### User Creation

`CREATE USER '<user>'[@'<host>'] [IDENTIFIED BY '<password>']`

#### No password

	CREATE USER hirohiko;

#### With password and host

	CREATE USER hitori@localhost IDENTIFIED BY 'b0cchiZa6';

### Database Creation

`CREATE DATABASE [IF NOT EXISTS] <database>;`

	CREATE DATABASE characters;

### Table Creation

`
CREATE TABLE [IF NOT EXISTS] <table>
(<col1> <type1> [<constraints>], 
<col2> <type2> [<constraints>],
...,
[<constraints>]
);
`
```
USE characters;

CREATE TABLE Crusaders (
	id UNSIGNED INT(7) UNSIGNED AUTO_INCREMENT, 
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	PRIMARY KEY (id)
);
```

Find more on w3schools and further : 
* [mysql datatypes](https://www.w3schools.com/mysql/mysql_datatypes.asp) 
* [mysql contraints](https://www.w3schools.com/mysql/mysql_constraints.asp)


## Updating data stores and actors

`GRANT <privilege> ON `


	FLUSH PRIVILEGES;

## Writing data

`INSERT INTO <table> VALUES
(<val_col1>, <val_col2>...), (<val_col1>, <val_col2>)...;`

ex : `INSERT INTO Students VALUES (1, 'Dio', 'Brando');`
ex : `INSERT INTO Students VALUES (2, 'Jotaro', 'Kujou'), 
(3, 'Mohammad', 'Avdol'), (4, 'Jean-Pierre', 'Polnareff'), 
(5, 'Joseph', 'Joestar'), (6, 'Noriaki', 'Kakyoin');`

## Fetching data

`SELECT <table> FROM <database> 
[WHERE [NOT] <coln>=<value> [or <coln>=<value>...]] 
[ORDER BY <coln> [ASC|DESC]];`

ex : 

## Deleting data

## Deleting data stores and actores

### User deletion

`DROP USER '<user>'[@'<host>';`

	DROP USER hirohiko;
	DROP USER hitori@localhost;

### Table deletion


### Database deletion

`DROP DATABASE [IF EXISTS] <database>`

## More

* [https://github.com/Ludophilia/P5](https://github.com/Ludophilia/P5)
* [https://github.com/Ludophilia/P6](https://github.com/Ludophilia/P6)
