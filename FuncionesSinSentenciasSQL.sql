/*Funciones Sin Sentencias SQL*/
use procedimiento;
/*1. Escribe una función que reciba un número entero de entrada y devuelva TRUE si el número es par o FALSE
en caso contrario.*/
set GLOBAL log_bin_trust_function_creators =1;/*Poder ejecutar funciones*/
delimiter $$
drop function if exists Es_Par $$
create function Es_Par(numero int)
returns boolean
begin
declare par boolean;
if (numero%2=0) then
	set par=true;
else
	set par=false;
end if;
return par;
end
$$
select Es_Par(8);

/*2. Escribe una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus
lados*/
drop function if exists hipotenusa$$
create function hipotenusa(lado1 float, lado2 float)
returns float
begin
declare hipotenusa float;
set hipotenusa = sqrt(pow(lado1,2)+pow(lado2,2));
return hipotenusa;
end
$$
select hipotenusa(8,9);
/*. Escribe una función que reciba como parámetro de entrada un valor numérico que represente un día de
la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente.
Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.*/
drop function if exists diaSemana$$
create function diaSemana(numero int)
returns varchar(20)
begin
declare dia varchar(20);
case
	when numero = 1 then 
	set dia = 'Lunes';
    when numero = 2 then 
	set dia = 'Martes';
    when numero = 3 then 
	set dia = 'Miercoles';
    when numero = 4 then 
	set dia = 'Jueves';
    when numero = 5 then 
	set dia = 'Viernes';
    when numero = 6 then 
	set dia = 'Sabado';
    when numero = 7 then 
	set dia = 'Domingo';
    else 
	set dia = 'Numero no valido';
	end case;
return dia;
end
$$
select diaSemana(6);

/*4. Escribe una función que reciba tres números reales como parámetros de entrada y devuelva el mayor de
los tres.*/
drop function if exists Mayor$$
create function Mayor(num1 int, num2 int, num3 int)
returns int
begin
declare mayor int;
	if num1 > num2 and num1 > num3 then
    set mayor=num1;
    elseif num2 > num1 and num2 > num3 then
	set mayor=num2;
    elseif num3 > num1 and num3 > num2 then
    set mayor=num3;
    end if;
return mayor;
end
$$
select Mayor(17,15,8);

/*5. Escribe una función que devuelva el valor del área de un círculo a partir del valor del radio que se recibirá
como parámetro de entrada.*/
drop function if exists AreaCirculo$$
create function AreaCirculo(radio double)
returns double
begin
	declare area double;
    set area = 3.14 * pow(radio,2);
    return area;
end
$$
select AreaCirculo(2.5);

/*6. Escribe una función que devuelva como salida el número de años que han transcurrido entre dos fechas
que se reciben como parámetros de entrada. Por ejemplo, si pasamos como parámetros de entrada las
fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que han pasado 10 años.*/
drop function if exists DiferenciaAnos$$
create function DiferenciaAnos(fecha1 date, fecha2 date)
returns int
begin
	declare anos int;
    /*set anos = datediff(fecha2, fecha1)/365;*/
    set anos = year(fecha2) - year(fecha1);/*Otra forma de hacerlo*/
    return anos;
end
$$
select DiferenciaAnos('2008-01-01', '2018-01-01');