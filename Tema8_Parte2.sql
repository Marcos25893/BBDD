/*4. Crea una base de datos llamada procedimientos que contenga una tabla llamada cuadrados. La ta-
bla cuadrados debe tener dos columnas de tipo INT UNSIGNED, una columna llamada número y otra
columna llamada cuadrado.
Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_cuadrados
con las siguientes características. El procedimiento recibe un parámetro de entrada llamado tope de tipo INT
UNSIGNED y calculará el valor de los cuadrados de los primeros números naturales hasta el valor introducido
como parámetro. El valor del números y de sus cuadrados deberán ser almacenados en la tabla cuadrados
que hemos creado previamente.
Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los
nuevos valores de los cuadrados que va a calcular.
Utilice un bucle WHILE para resolver el procedimiento.*/
drop database if exists procedimientos;
create database if not exists procedimientos;
use procedimientos;
create table if not exists cuadrados(
numero int unsigned,
cuadrado int unsigned
);


delimiter $$
drop procedure if exists Ejercicio4 $$
create procedure Ejercicio4(in tope int unsigned)
begin
	declare numero int unsigned;
    delete from cuadrados;
    set numero=1;
    while numero <= tope do
		insert into cuadrados values(numero, numero*numero);
        set numero=numero+1;
	end while;
end
$$
call Ejercicio4(10);
select * from cuadrados;

/*5. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior*/
delimiter $$
drop procedure if exists Ejercicio5 $$
create procedure Ejercicio5(in tope int unsigned)
begin
	declare numero int unsigned;
    delete from cuadrados;
    set numero=1;
    repeat
		insert into cuadrados values(numero, numero*numero);
        set numero=numero+1;
        until numero > tope
	end repeat;
end
$$
call Ejercicio5(10);
select * from cuadrados;

/*6. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.*/
delimiter $$
drop procedure if exists Ejercicio6 $$
create procedure Ejercicio6(in tope int unsigned)
begin
	declare numero int unsigned;
    delete from cuadrados;
    set numero=1;
    bucleloop:loop
		if numero <= tope then
			insert into cuadrados values(numero, numero*numero);
			set numero=numero+1;
			iterate bucleloop;
        end if;
	leave bucleloop;
	end loop;
end
$$
call Ejercicio6(10);
select * from cuadrados;

/*7. Crea una base de datos llamada procedimientos que contenga una tabla llamada ejercicio. La tabla
debe tener una única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED
.
Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_números con
las siguientes características. El procedimiento recibe un parámetro de entrada llamado valor_inicial de
tipo INT UNSIGNED y deberá almacenar en la tabla ejercicio toda la secuencia de números desde el valor
inicial pasado como entrada hasta el 1.
Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los
nuevos valores.
Utilice un bucle WHILE para resolver el procedimiento.*/
Create database if not exists procedimientos;
use procedimientos;
Create table if not exists ejercicio(
numero int unsigned
);

delimiter $$
drop procedure if exists calcular_numeros $$
create procedure calcular_numeros(in valor_inicial int unsigned)
begin
    delete from ejercicio;
    while valor_inicial >= 1 do
		insert into ejercicio values(valor_inicial);
        set valor_inicial=valor_inicial-1;
	end while;
end
$$
call calcular_numeros(20);
select * from ejercicio;

/*8. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.*/