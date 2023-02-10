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

`SHOW TABLES;` `DESCRIBE <table>;`

	SHOW TABLES;
	DESCRIBE user;

### Exiting mariadb

	exit

## Creating data stores and actors

### User Creation

`CREATE [IF NOT EXISTS] USER '<user>'[@'<host>'] [IDENTIFIED BY '<password>']`

#### No password

	CREATE USER hirohiko;

#### With password and host

	CREATE USER hitori@localhost IDENTIFIED BY 'b0cchiZa6';

#### More

* [CREATE USER](https://dev.mysql.com/doc/refman/8.0/en/create-user.html)
(mysql documentation)

### Database Creation

`CREATE DATABASE [IF NOT EXISTS] <database>;`

	CREATE DATABASE characters;

#### More

* [CREATE DATABASE](https://dev.mysql.com/doc/refman/5.7/en/create-database.html)
(mysql documentation)
* [Character sets](https://dev.mysql.com/doc/refman/5.7/en/charset.html)
(mysql documentation)

### Table Creation

`
CREATE TABLE [IF NOT EXISTS] <table>
(<col1> <type1> [<constraints>], 
<col2> <type2> [<constraints>],
...
);
`

```
USE characters;

CREATE TABLE Crusaders (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL
);
```

#### More

* [CREATE TABLE](https://dev.mysql.com/doc/refman/5.7/en/create-table.html)
(mysql documentation)
* [mysql datatypes](https://www.w3schools.com/mysql/mysql_datatypes.asp)
(W3Schools)
* [mysql contraints](https://www.w3schools.com/mysql/mysql_constraints.asp)
(W3Schools)

## Updating data stores and actors

### User Privileges Update

`GRANT <privilege> ON <database[.<table>]> TO <user>[@<host>]
[WITH GRANT OPTION];`
`FLUSH PRIVILEGES;`

	GRANT CREATE, SELECT, UPDATE, DROP, DELETE 
	ON Characters.Crusaders TO hirohiko;
	FLUSH PRIVILEGES;

#### More
* [Privileges](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html)
(mysql documentation)
* [GRANT](https://dev.mysql.com/doc/refman/5.7/en/grant.html)
(mysql documentation)
* [FLUSH PRIVILEGES](https://dev.mysql.com/doc/refman/5.7/en/flush.html#flush-privileges)
(mysql documentation)

### Table Update

#### Renaming tables

`ALTER TABLE <table> RENAME [TO | AS] <table>;`

```
ALTER TABLE Crusaders RENAME TO Jojos;
ALTER TABLE Crusaders RENAME TO Crusaders;
```

#### Adding tables

`ALTER TABLE <table> ADD [COLUMN] <coln> <typen> [<constraints>] [FIRST |
AFTER <col> | <coln1> <typen1>...];`

```
ALTER TABLE Crusaders ADD sex CHAR(1) LAST last_name;
```

#### Adding table contraints

`ALTER TABLE <table> ADD [CONSTRAINT '<key_name>'] {PRIMARY KEY | UNIQUE}
(<col>[,...]);`

```
ALTER TABLE Crusaders ADD UNIQUE (first_name, last_name);
```

`ALTER TABLE <table> ADD [CONSTRAINT '<key_name>'] FOREIGN KEY (<col>[,...])
REFERENCES [<dabatase>.]<table> (<col>[,...]);`

```
CREATE TABLE Alive (
	id INT(7) UNSIGNED NOT NULL,
	alive BOOL
);

ALTER TABLE Alive ADD FOREIGN KEY (id) REFERENCES Crusaders (id);
```

#### Modifying tables definitions

`ALTER TABLE <table> CHANGE [COLUMN] <old_coln> <new_coln> <typen> [<constraints>] [FIRST | AFTER <col>];`

```
ALTER TABLE Crusaders CHANGE sex gender CHAR(1);
```

`ALTER TABLE <table> MODIFY [COLUMN] <coln> <typen> [<constraints>] [FIRST |
AFTER <col>];`

```
ALTER TABLE Crusaders MODIFY first_name VARCHAR(50) NOT NULL;
ALTER TABLE Crusaders MODIFY last_name VARCHAR(50);
```

#### Removing tables columns

`ALTER TABLE <table> DROP [COLUMN];`

```
ALTER TABLE Crusaders ADD fuckable BOOL NOT NULL;
ALTER TABLE Crusaders DROP fuckable;
```

#### Removing tables

`ALTER TABLE <table> DROP { PRIMARY KEY | FOREIGN KEY <key_name>};`

```
-- Use SHOW CREATE TABLE to get the foreign key's name.
SHOW CREATE TABLE Alive;

ALTER TABLE Alive ADD PRIMARY KEY (alive);
ALTER TABLE Alive DROP PRIMARY KEY;
```

### More 

* [ALTER TABLE](https://dev.mysql.com/doc/refman/5.7/en/alter-table.html)
(mysql documentation)

## Writing into data stores 

### Writing data for the first time

`INSERT INTO <table> [(<col1>, <col2>...)] VALUES
(<val_col1>, <val_col2>...)[, (<val_col1>, <val_col2>)...];`

```
INSERT INTO Crusaders (first_name, last_name, gender) VALUES
('Dio', 'Brando', M);

INSERT INTO Students VALUES 
	(2, 'Jotaro', 'Kujou', 'M'),
	(3, 'Muhammad', 'Avdol', 'M'),
	(4, 'Jean-Pierre', 'Polnareff', 'M'),
	(5, 'Joseph', 'Joestar', 'M'), 
	(6, 'Noriaki', 'Kakyoin', 'M'),
	(7, 'Hitori', 'Gotou', 'F');
```

#### More

* [INSERT](https://dev.mysql.com/doc/refman/5.7/en/insert.html)
(mysql documentation)

### Modifying a specific row

`UPDATE <table> SET <col1>=<value1>[, <col2>=<value2>...]
[WHERE <condition(s)>] [ORDER BY <col> [ASC | DESC]] [LIMIT <nb_rows>];`

```
UPDATE Crusaders SET first_name='Iggy', last_name=NULL, gender='M' WHERE id=7; 
```

#### More

* [UPDATE](https://dev.mysql.com/doc/refman/5.7/en/update.html)
(mysql documentation)

## Reading data stores

### Get the statement that created the table

`SHOW CREATE TABLE <table>;`

```
SHOW CREATE TABLE Alive;
```

#### More

* [SHOW CREATE TABLE](https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html)
(mysql documentation)

### Read rows on the table

`SELECT [ALL | DISTINCT] (* | <table1>[, <table2>...] | <expr>) FROM <database_expr> 
[WHERE [NOT] <condition>] [ORDER BY <coln> [ASC|DESC]]
[LIMIT <row_count>];`

```
SELECT * FROM Crusaders;

SELECT first_name, last_name, gender FROM Crusaders WHERE 
first_name='Dio' or first_name='Joseph';

SELECT id, first_name FROM Crusaders WHERE last_name IS NULL;

SELECT id, first_name, last_name FROM Crusaders WHERE NOT first_name='Dio'
ORDER BY last_name ASC LIMIT 2;
```

#### More

* [SELECT](https://dev.mysql.com/doc/refman/5.7/en/select.html)
(mysql documentation)

## Deleting data stores and actores

### User deletion

`DROP USER '<user>'[@'<host>';`

	DROP USER hirohiko;
	DROP USER hitori@localhost;

### Table deletion

`DROP TABLE [IF EXISTS] <table1> [<table2>...] [CASCADE];`

### Database deletion

`DROP DATABASE [IF EXISTS] <database>`

## Live examples

* [https://github.com/Ludophilia/P5](https://github.com/Ludophilia/P5)
* [https://github.com/Ludophilia/P6](https://github.com/Ludophilia/P6)
* ...
