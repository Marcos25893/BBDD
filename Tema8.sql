/*Ejercicios tema 8*/

create database if not exists ejercicios_tema8;
use ejercicios_tema8;

/*PROCEDIMIENTOS SIN SENTENCIAS SQL*/

/*1. Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida y que muestre el texto
¡Hola mundo!.*/
delimiter $$
drop procedure if exists HolaMundo $$
create procedure HolaMundo()
begin
	select 'Hola Mundo!';
end
$$
call HolaMundo();

/*2. Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje indicando si el
número es positivo, negativo o cero.*/
delimiter $$
drop procedure if exists ComprobarNumero $$
create procedure ComprobarNumero(in numero float)
begin
	if numero > 0 then 
		select 'El numero es positivo';
    elseif numero < 0 then 
		select 'El numero es negativo';
    else 
		select 'El numero es cero';
	end if;
end
$$
call ComprobarNumero(10);

/*3. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada,
con el valor un número real, y un parámetro de salida, con una cadena de caracteres indicando si el nú-
mero es positivo, negativo o cero*/
delimiter $$
drop procedure if exists ComprobarNumeroEje3 $$
create procedure ComprobarNumeroEje3(in numero float, out signo varchar(25))
begin
		if numero > 0 then 
		set signo = 'El numero es positivo';
    elseif numero < 0 then 
		set signo = 'El numero es negativo';
    else 
		set signo = 'El numero es cero';
	end if;
end
$$
call ComprobarNumeroEje3(15, @signo);
select @signo;

/*4. Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de
un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes
condiciones:
• [0,5) = Insuficiente
• [5,6) = Aprobado
• [6, 7) = Bien
• [7, 9) = Notable
• [9, 10] = Sobresaliente
• En cualquier otro caso la nota no será válida.*/
delimiter $$
drop procedure if exists Ejercicio4 $$
create procedure Ejercicio4(in numero float)
begin
/*Para declarar variable 'declare nombreVariable varchar(20);'*/
	if numero < 5 then 
		select 'Insuficiente';
    elseif numero < 6 then 
		select 'Aprobado';
	elseif numero < 7 then 
		select 'Bien';
    elseif numero < 9 then 
		select 'Notable';
    elseif numero <=10 then 
		select 'Sobresaliente';    
    else 
		select 'Nota no valida';
	end if;
end
$$
call Ejercicio4(9);

/*5. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada,
con el valor de la nota en formato numérico y un parámetro de salida, con una cadena de texto indicando
la nota correspondiente*/
delimiter $$
drop procedure if exists Ejercicio5 $$
create procedure Ejercicio5(in numero float, out salida varchar(30))
begin
	if numero < 5 then 
		set salida = 'Insuficiente';
    elseif numero < 6 then 
		set salida = 'Aprobado';
	elseif numero < 7 then 
		set salida = 'Bien';
    elseif numero < 9 then 
		set salida = 'Notable';
    elseif numero <=10 then 
		set salida = 'Sobresaliente';    
    else 
		set salida = 'Nota no valida';
	end if;
end
$$
call Ejercicio5(6, @salida);
select @salida;

/*6. Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura de control CASE*/
delimiter $$
drop procedure if exists Ejercicio6 $$
create procedure Ejercicio6(in numero float, out salida varchar(30))
begin

case
	when numero < 5 then 
	set salida = 'Insuficiente';
    when numero < 6 then 
		set salida = 'Aprobado';
	when numero < 7 then 
		set salida = 'Bien';
    when numero < 9 then 
		set salida = 'Notable';
    when numero <=10 then 
		set salida = 'Sobresaliente';    
    else 
		set salida = 'Nota no valida';
	end case;

end
$$
call Ejercicio6(10, @salida);
select @salida;

/*PROCEDIMIENTOS CON SENTENCIAS SQL*/

use jardineria;
/*1. Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada y realice una
consulta sobre la tabla cliente para obtener todos los clientes que existen en la tabla de ese país*/
delimiter $$
drop procedure if exists Ejercicio7 $$
create procedure Ejercicio7(in pais2 varchar(50))
begin
	select * from cliente where cliente.pais=pais2;
end
$$
call Ejercicio7('Spain');

/*2. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cade-
na de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida el pago de máximo va-
lor realizado para esa forma de pago. Deberá hacer uso de la tabla pago de la base de datos jardineria.*/
delimiter $$
drop procedure if exists Ejercicio8 $$
create procedure Ejercicio8(in formaPago varchar(50), out maximo float)
begin
	set maximo = (select max(total) from pago where pago.forma_pago=formaPago);
end
$$
call Ejercicio8('PayPal', @maximo);
select @maximo;

/*3. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cade-
na de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida los siguientes valores
teniendo en cuenta la forma de pago seleccionada como parámetro de entrada:
• el pago de máximo valor,
• el pago de mínimo valor,
• el valor medio de los pagos realizados
• la suma de todos los pagos,
• el número de pagos realizados para esa forma de pago*/
delimiter $$
drop procedure if exists Ejercicio9 $$
create procedure Ejercicio9(in formaPago varchar(50), out maximo float, out minimo float, out media float, 
out suma float, out cantidad float)
begin
	set maximo = (select max(total) from pago where pago.forma_pago=formaPago);
    set minimo = (select min(total) from pago where pago.forma_pago=formaPago);
    set media = (select avg(total) from pago where pago.forma_pago=formaPago);
    set suma = (select sum(total) from pago where pago.forma_pago=formaPago);
    set cantidad = (select count(total) from pago where pago.forma_pago=formaPago);
end
$$
call Ejercicio9('PayPal', @maximo, @minimo, @media, @suma, @cantidad);
select @maximo, @minimo, @media, @suma, @cantidad;
