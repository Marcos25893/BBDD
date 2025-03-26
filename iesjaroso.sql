create database iesjaroso;	/*Crea la base de datos*/
use iesjaroso;	/*Comando para utilizar la base de datos*/
create table alumno(	/*Crea la tabla*/ 
codalumno numeric(4),
nombre varchar(35),
apellido1 varchar(35),
apellido2 varchar(35),
fechaalta date,
primary key(codalumno)
);
describe alumno;
create table if not exists ciudad(	/*Crea la tabla si no existe ya*/ 
nomciudad varchar(50) not null,
poblacion int null default 10000);
describe ciudad;/*Me describe la base de datos*/
drop database prueba;	/*Borra la base de datos*/
show tables;