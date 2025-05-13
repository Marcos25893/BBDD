/*Manejo de Errores*/
/*1. Crea una base de datos llamada test que contenga una tabla llamada alumno. La tabla debe tener
cuatro columnas:
• id: entero sin signo (clave primaria).
• nombre: cadena de 50 caracteres.
• apellido1: cadena de 50 caracteres.
• apellido2: cadena de 50 caracteres.
Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado insertar_alumno con
las siguientes características. El procedimiento recibe cuatro parámetros de entrada (id, nombre, apellido1,
apellido2) y los insertará en la tabla alumno. El procedimiento devolverá como salida un parámetro llamado
error que tendrá un valor igual a 0 si la operación se ha podido realizar con éxito y un valor igual a 1 en caso
contrario.
Deberá manejar los errores que puedan ocurrir cuando se intenta insertar una fila que contiene una clave pri-
maria repetida*/
create database if not exists test;
use test;
create table if not exists alumno(
id int unsigned primary key,
nombre varchar(50),
apellido1 varchar(50),
apellido2 varchar(50)
)Engine=InnoDB;

delimiter $$
drop procedure if exists insertar_alumnos$$
create procedure insertar_alumnos(in id int unsigned, in nombre varchar(50), 
in apellido1 varchar(50), in apellido2 varchar(50), out error varchar(50))
begin
declare continue handler for 1062
	begin
    set error = '1';
    end;
set error = '0';
insert into alumno values (id, nombre, apellido1, apellido2);
end
$$
call insertar_alumnos(1, 'Catalina', 'Flores', 'Cazorla', @error);
select @error;