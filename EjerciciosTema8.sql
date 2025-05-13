/*1. Crea una base de datos llamada procedimientos que contenga una tabla llamada
Operaciones. La tabla debe de contener cuatro columnas de tipo int unsigned,
cuatro columnas llamadas num1, num2, suma y producto.
Una vez creada la base de datos y la tabla crear un procedimiento llamado
Calcular_Operaciones con las siguientes características. El procedimiento recibe
dos parámetro, uno llamado número y otro tope de tipo int unsigned y calculara
el valor de la suma y del producto de los números naturales comprendidos entre
número y tope.
Ten en cuenta que el procedimiento deberá eliminar el contenido actual de la
tabla antes de insertar los nuevos valores de la suma y el producto que va a
calcular*/
Create database if not exists procedimiento;
use procedimiento;
create table if not exists operaciones(
num1 int unsigned,
num2 int unsigned,
suma int unsigned,
producto int unsigned
)Engine=InnoDB;

delimiter $$
drop procedure if exists Calcular_Operaciones $$
create procedure Calcular_Operaciones(in numero int unsigned, in tope int unsigned)
begin
    delete from operaciones;
    while numero <= tope do
		insert into operaciones values(numero, tope, numero+tope, numero*numero);
        set numero=numero+1;
	end while;
end
$$
call Calcular_Operaciones(5, 10);
select * from operaciones;

/*3. Utiliza un bucle REPEAT para resolver el procedimiento del ejercicio anterior.*/

delimiter $$
drop procedure if exists Calcular_Operaciones $$
create procedure Calcular_Operaciones(in numero int unsigned, in tope int unsigned)
begin
    delete from operaciones;
    repeat
		insert into operaciones values(numero, tope, numero+tope, numero*numero);
        set numero=numero+1;
        until tope < numero
	end repeat;
end
$$
call Calcular_Operaciones(5, 10);
select * from operaciones;

/*4. Utiliza un bucle LOOP para resolver el procedimiento del ejercicio anterior.*/
delimiter $$
drop procedure if exists Calcular_Operaciones $$
create procedure Calcular_Operaciones(in numero int unsigned, in tope int unsigned)
begin
    delete from operaciones;
    bucleloop:loop
    if numero <= tope then
		insert into operaciones values(numero, tope, numero+tope, numero*numero);
        set numero=numero+1;
		iterate bucleloop;
        end if;
	leave bucleloop;
	end loop;
end
$$
call Calcular_Operaciones(5, 10);
select * from operaciones;
/*5. Escribe un procedimiento que reciba el nombre de un departamento como
parámetro de entrada y realice una consulta para obtener todos los empleados
de ese departamento. Usa base de datos relacion6.*/
$$
use Relacion6;
delimiter $$
drop procedure if exists empleados $$
create procedure empleados(in nombre varchar(50))
begin
    select count(cdemp) from Empleado e group by cddep having cddep=nombre;
end
$$
call empleados(1);



