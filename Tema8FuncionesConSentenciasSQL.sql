/*Funciones con Sentencias SQL*/
use Tienda;
/*1. Escribe una función para la base de datos tienda que devuelva el número total de productos que hay en
la tabla productos.*/
delimiter $$
drop function if exists calcular_total_productos$$
create function calcular_total_productos()
returns int
begin
declare total int;
set total=(select count(*) as cuantos from articulos);
return total;
end 
$$
select calcular_total_productos();

/*2. Escribe una función para la base de datos tienda que devuelva el valor medio del precio de los productos
de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será
el nombre del fabricante*/
delimiter $$
drop function if exists calcular_precio_medio$$
create function calcular_precio_medio(fabricante varchar(50))
returns float
begin
	declare media float;
    set media = (select avg(precio) from articulos a, fabricantes f 
    where a.clave_fabricante=f.clave_fabricante and f.nombre=fabricante);
    return media;
end
$$
select calcular_precio_medio('Lexar');

/*3. Escribe una función para la base de datos tienda que devuelva el valor máximo del precio de los produc-
tos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada
será el nombre del fabricante.*/
drop function if exists maximo_producto$$
create function maximo_producto(fabricante varchar(20))
returns int
begin
	declare maximo int;
	set maximo = (select max(precio) from articulos a, fabricantes f
		where a.clave_fabricante=f.clave_fabricante and f.nombre=fabricante);
        return maximo;
end
$$
select maximo_producto('Logitech');

/*4. Escribe una función para la base de datos tienda que devuelva el valor mínimo del precio de los produc-
tos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada
será el nombre del fabricante.*/
drop function if exists minimo_producto$$
create function minimo_producto(fabricante varchar(20))
returns int
begin
	declare minimo int;
	set minimo = (select min(precio) from articulos a, fabricantes f
		where a.clave_fabricante=f.clave_fabricante and f.nombre=fabricante);
        return minimo;
end
$$
select minimo_producto('Logitech');

