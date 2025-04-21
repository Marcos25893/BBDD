Create database if not exists Relacion5;
use Relacion5;

Create table if not exists tipoart(
id_tipo char(3),
nom_tipo varchar(50),
primary key (id_tipo)
)Engine=InnoDB;

Create table if not exists ciudad(
id_ciudad char(3),
nom_ciudad varchar(50),
primary key (id_ciudad)
)Engine=InnoDB;

create table if not exists tienda(
id_tienda char(3) primary key,
nom_tienda varchar(25) not null,
id_ciudad char(3) not null,
foreign key (id_ciudad) references ciudad(id_ciudad)
on delete cascade on update cascade)
engine = InnoDB;

/*Creamos la tabla Articulos*/
create table if not exists articulos(
id_art char(3) primary key,
nom_art varchar(25) not null,
precio double not null,
id_tipo char(3) not null,
foreign key (id_tipo) references tipoart(id_tipo)
on delete cascade on update cascade)
engine=InnoDB;

/*Creamos la tabla vendedores*/
create table if not exists vendedores(
id_vend char(3) primary key,
nom_vend varchar(25) not null,
salario double not null,
id_tienda char(3) not null,
foreign key (id_tienda) references tienda(id_tienda)
on delete cascade on update cascade)
engine=InnoDB;

/*Creamos la tabla Vendart*/
create table if not exists vendart(
id_vend char(3) not null,
id_art char(3) not null,
fech_venta date not null,
primary key (id_vend, id_art, fech_venta),
foreign key (id_art) references articulos(id_art)
on delete cascade on update cascade,
foreign key (id_vend) references vendedores(id_vend)
on delete cascade on update cascade)
engine=InnoDB;

insert into ciudad values('CI1','SEVILLA');
insert into ciudad values('CI2','ALMERIA');
insert into ciudad values('CI3','GRANADA');

insert into tipoart values('TI1','BAZAR');
insert into tipoart values('TI2','COMESTIBLES');
insert into tipoart values('TI3','PAPELERIA');

insert into tienda values('TD1','BAZARES S.A.','CI1');
insert into tienda values('TD2','CADENAS S.A..','CI1');
insert into tienda values('TD3','MIRROS S.L.','CI2');
insert into tienda values('TD4','LUNA','CI2');
insert into tienda values('TD5','MAS S.A.','CI3');
insert into tienda values('TD6','JOYMON','CI2');

insert into vendedores values('VN1','JUAN',1090,'TD1');
insert into vendedores values('VN2','PEPE',1034,'TD1');
insert into vendedores values('VN3','LUCAS',1100,'TD2');
insert into vendedores values('VN4','ANA',890,'TD2');
insert into vendedores values('VN5','PEPA',678,'TD3');
insert into vendedores values('VN6','MANUEL',567,'TD2');
insert into vendedores values('VN7','LORENA',1100,'TD3');

insert into articulos values('AR1','RADIO',78,'TI1');
insert into articulos values('AR2','CARNE',15,'TI2');
insert into articulos values('AR3','BLOC',5,'TI3');
insert into articulos values('AR4','DVD',24,'TI1');
insert into articulos values('AR5','PESCADO',23,'TI2');
insert into articulos values('AR6','LECHE',2,'TI2');
insert into articulos values('AR7','CAMARA',157,'TI1');
insert into articulos values('AR8','LAPIZ',1,'TI3');
insert into articulos values('AR9','BOMBILLA',2,'TI1');

insert into vendart values('VN1','AR1','2005/02/01');
insert into vendart values('VN1','AR2','2005/02/01');
insert into vendart values('VN2','AR3','2005/03/01');
insert into vendart values('VN1','AR4','2005/04/01');
insert into vendart values('VN1','AR5','2005/06/01');
insert into vendart values('VN3','AR6','2005/07/01');
insert into vendart values('VN3','AR7','2005/08/01');
insert into vendart values('VN3','AR8','2001/09/12');
insert into vendart values('VN4','AR9','2005/10/10');
insert into vendart values('VN4','AR8','2005/11/01');
insert into vendart values('VN5','AR7','2005/10/01');
insert into vendart values('VN5','AR6','2005/11/02');
insert into vendart values('VN6','AR5','2005/11/03');
insert into vendart values('VN6','AR4','2005/11/04');
insert into vendart values('VN7','AR3','2005/11/05');
insert into vendart values('VN7','AR2','2005/11/07');
insert into vendart values('VN1','AR2','2005/11/06');
insert into vendart values('VN2','AR1','2004/10/08');
insert into vendart values('VN3','AR2','1999/01/01');
insert into vendart values('VN4','AR3','2005/10/25');
insert into vendart values('VN5','AR4','2005/10/26');
insert into vendart values('VN5','AR5','2005/10/27');
insert into vendart values('VN6','AR6','2005/10/28');
insert into vendart values('VN5','AR7','2005/10/28');
insert into vendart values('VN4','AR8','2005/10/30');
insert into vendart values('VN3','AR9','2005/08/24');
insert into vendart values('VN7','AR9','2005/08/25');

/*1.- CIUDAD DONDE MAS SE VENDIO*/
select nom_ciudad, count(va.id_vend) as 'nºventas'
from ciudad c
inner join tienda t
on t.id_ciudad=c.id_ciudad
inner join vendedores v
on v.id_tienda=t.id_tienda
inner join vendart va
on v.id_vend=va.id_vend
group by c.id_ciudad
having count(va.id_vend)=(select count(va.id_vend)
					from ciudad c
					inner join tienda t
					on t.id_ciudad=c.id_ciudad
					inner join vendedores v
					on v.id_tienda=t.id_tienda
					inner join vendart va
					on v.id_vend=va.id_vend
					group by c.id_ciudad 
                    order by 1 desc limit 1);
					
/*2.- TIENDA DONDE MAS SE VENDIO*/
select nom_tienda, count(va.id_vend) as 'nºventas'
from tienda t
inner join vendedores v
on v.id_tienda=t.id_tienda
inner join vendart va
on v.id_vend=va.id_vend
group by t.id_tienda
having count(va.id_vend)=(select count(va.id_vend)
					from tienda t
					inner join vendedores v
					on v.id_tienda=t.id_tienda
					inner join vendart va
					on v.id_vend=va.id_vend
					group by t.id_tienda 
                    order by 1 desc limit 1);

/*3.- VENDEDOR QUE MAS VENDIO*/
select nom_vend, count(va.id_vend) as 'nºventas'
from vendedores v
inner join vendart va
on v.id_vend=va.id_vend
group by v.id_vend
having count(va.id_vend)=(select count(va.id_vend)
					from vendedores v
					inner join vendart va
					on v.id_vend=va.id_vend
					group by v.id_vend 
                    order by 1 desc limit 1);
                    
/*4.-NOMBRE DE CIUDAD, VENDEDOR, ARTICULO, TIENDA TIPO Y PRECIO DE TODO LO VENDIDO*/
select nom_ciudad, nom_vend, nom_art, nom_tienda, nom_tipo, precio
from ciudad c
inner join tienda t
on t.id_ciudad=c.id_ciudad
inner join vendedores v
on v.id_tienda=t.id_tienda
inner join vendart va
on v.id_vend=va.id_vend
inner join articulos a
on a.id_art=va.id_art
inner join tipoart ta
on ta.id_tipo=a.id_tipo;

/*5.- NOMBRE DEL TIPO DE ARTICULO MAS CARO*/
select nom_tipo, nom_art, precio
from articulos a
inner join tipoart t
on t.id_tipo=a.id_tipo
where precio=(select precio
				from articulos
				order by precio desc limit 1);

/*6.- DATOS DEL VENDEDOR QUE MAS GANA*/
select * 
from vendedores
where salario=(select salario
				from vendedores
				order by salario desc limit 1);
                
/*7.- MONTANTE DE TODOS LOS ARTICULOS DE TIPO BAZAR*/
select sum(precio)
from articulos a
inner join tipoart ta
on a.id_tipo=ta.id_tipo
where nom_tipo like 'BAZAR'
group by a.id_tipo;

/*8.- MONTANTE DE TODO LO QUE SE VENDIO EN ALMERIA*/
select sum(precio)
from ciudad c
inner join tienda t
on t.id_ciudad=c.id_ciudad
inner join vendedores v
on v.id_tienda=t.id_tienda
inner join vendart va
on v.id_vend=va.id_vend
inner join articulos a
on a.id_art=va.id_art
where nom_ciudad like 'ALMERIA'
group by c.id_ciudad;

/*9.- MONTANTE DE TODO LO QUE SE VENDIO EN LUNA*/
select sum(precio)
from articulos a
inner join vendart va
on a.id_art=va.id_art
inner join vendedores v
on v.id_vend=va.id_vend
inner join tienda t
on t.id_tienda=v.id_tienda
where nom_tienda like 'LUNA'
group by t.id_tienda;
                    
/*10.- NOMBRE DE ARTICULO, TIPO PRECIO, TIENDA, CIUDAD Y FECHA DE LO QUE VENDIO MANUEL*/
select nom_art, precio, nom_tienda, nom_ciudad, fech_venta
from ciudad c
inner join tienda t
on t.id_ciudad=c.id_ciudad
inner join vendedores v
on v.id_tienda=t.id_tienda
inner join vendart va
on v.id_vend=va.id_vend
inner join articulos a
on a.id_art=va.id_art
where nom_vend like 'MANUEL';

/*11.- TOTAL DEL SALARIO DE TODOS LOS TRABAJADORES DFE ALMERIA*/
select v.*
from ciudad c
inner join tienda t
on t.id_ciudad=c.id_ciudad
inner join vendedores v
on v.id_tienda=t.id_tienda
where nom_ciudad like 'ALMERIA';

/*12.- NOMBRE DE LOS QUE VENDIERON LECHE*/
select nom_vend
from vendedores v
inner join vendart va
on v.id_vend=va.id_vend
inner join articulos a
on a.id_art=va.id_art
where nom_art like 'LECHE';

/*13.- NOMBRE DE LOS QUE VENDIERON ARTICULOS DE TIPO BAZAR.*/
select nom_vend
from vendedores v
inner join vendart va
on v.id_vend=va.id_vend
inner join articulos a
on a.id_art=va.id_art
inner join tipoart ta
on ta.id_tipo=a.id_tipo
where nom_tipo like 'BAZAR';

/*14.- ARTICULOS DE TIPO BAZAR MAS VENDIDOS*/
select nom_art, count(a.id_art) as 'veces vendido'
from vendart va
inner join articulos a
on a.id_art=va.id_art
inner join tipoart ta
on ta.id_tipo=a.id_tipo
where nom_tipo like 'BAZAR'
group by a.id_art
having count(a.id_art)=(select count(a.id_art)
						from vendart va
						inner join articulos a
						on a.id_art=va.id_art
						inner join tipoart ta
						on ta.id_tipo=a.id_tipo
						where nom_tipo like 'BAZAR'
						group by a.id_art
                        order by 1 desc limit 1);
                        
/*15.- NOMBRE DEL TIPO CON QUE MAS SE GANA*/
select nom_tipo, sum(precio) as 'Total dinero'
from vendart va
inner join articulos a
on a.id_art=va.id_art
inner join tipoart ta
on ta.id_tipo=a.id_tipo
group by ta.id_tipo
having sum(precio)=(select sum(precio)
						from vendart va
						inner join articulos a
						on a.id_art=va.id_art
						inner join tipoart ta
						on ta.id_tipo=a.id_tipo
						group by ta.id_tipo
                        order by 1 desc limit 1);
                        
/*16.- SALARIO Y NOMBRE DE TODOS LOS QUE VENDIERON BOMBILLA*/
select nom_vend, salario
from vendedores v
inner join vendart va
on v.id_vend=va.id_vend
inner join articulos a
on a.id_art=va.id_art
where nom_art like 'BOMBILLA';

/*17.- TIENDAS Y CIUDAD DONDE SE VENDIO ALGUNA RADIO*/
select distinct nom_tienda, nom_ciudad
from ciudad c
inner join tienda t
on t.id_ciudad=c.id_ciudad
inner join vendedores v
on v.id_tienda=t.id_tienda
inner join vendart va
on v.id_vend=va.id_vend
inner join articulos a
on a.id_art=va.id_art
where nom_art like 'RADIO';

/*18.- SUBIR EL SUELDO UN 2% A LOS EMPLEADOS DE SEVILLA*/
create view empleados_Sevilla (id_tienda) as 
select id_tienda
from ciudad, tienda
where ciudad.id_ciudad=tienda.id_ciudad
and nom_ciudad like 'SEVILLA';
select * from empleados_Sevilla;

update vendedores set salario=salario*1.02
where id_tienda in (select id_tienda
					from empleados_Sevilla);
                    
/*19.- BAJA EL SUELDO UN 1% A LOS QUE NO HAYAN VENDIDO LECHE*/
update vendedores set salario=salario*0.99
where id_vend in (select id_vend
				from articulos a
				inner join vendart va
                on va.id_art=a.id_art
                where nom_art like 'LECHE');
                        
/*20.- SUBIR EL PRECIO UN 3% AL ARTICULO MAS VENDIDO*/
create view articuloMasVendido (id_art) as
select id_art
from vendart va
group by id_art
having count(id_art)=(select count(id_art)
						from vendart va
						group by id_art
                        order by 1 desc limit 1);
                        
update articulos set precio=precio*1.03
where id_art = (select id_art
				from articuloMasVendido);
                
/*21.- SUBIR EL SUELDO UN 2% A LOS ARTICULOS DE TIPO MAS VENDIDO*/
create view articuloTipoMasVendido (id_tipo) as
select ta.id_tipo
from vendart va
inner join articulos a
on a.id_art=va.id_art
inner join tipoart ta
on ta.id_tipo=a.id_tipo
group by a.id_tipo
having count(a.id_tipo)=(select count(a.id_tipo)
						from vendart va
						inner join articulos a
						on a.id_art=va.id_art
						inner join tipoart ta
						on ta.id_tipo=a.id_tipo
						group by a.id_tipo
                        order by 1 desc limit 1);
                        
update articulos set precio=precio*1.02
where id_tipo = (select id_tipo
				from articuloTipoMasVendido);
                   
/*22.- BAJAR UN 3% TODOS LOS ARTICULOS DE PAPELERIA*/
update articulos set precio=precio*0.97
where id_tipo = (select id_tipo
				from tipoart
                where nom_tipo like 'PAPELERIA');
                    
/*23.- SUBIR EL PRECIO UN 1% A TODOS LOS ARTICULOS VENDIDOS EN ALMERIA*/
update articulos set precio=precio*1.01
where id_art IN (select id_art
				from vendart va
                inner join vendedores v
                on v.id_vend=va.id_vend
                inner join tienda t
                on t.id_tienda=v.id_tienda
                inner join ciudad c
                on c.id_ciudad=t.id_ciudad
                where nom_ciudad like 'ALMERIA');

/*24.- BAJAR EL PRECIO UN 5% AL ARTICULO QUE MAS HACE QUE NO SE VENDE*/
/*
update articulos set precio=precio*1.01
where id_art = ();
*/

/*24 bajar el precio un 5%  al articulo que mas 
 hace que no se vende*/
update articulos set  precio=precio-(precio*5/100)
where id_art in (select id_art
				from vendart
				where fech_venta=(select min(fech_venta) 
                from vendart));

/*averiguo el articulo que hace mas tiempo se vendio*/
select id_art
				from vendart
				where fech_venta=(select min(fech_venta) 
                from vendart);


/*25 cerrar la tienda que menos ha vendido*/
delete from tienda
where id_tienda in (select id_tienda
					from vendart, vendedores
					where vendart.id_vend=vendedores.id_vend
					group by id_tienda
					having count(*)=(select count(*)
									from vendart, vendedores
									where vendart.id_vend=vendedores.id_vend
									group by id_tienda
									order by 1 limit 1));

/*tienda que menos ha vendido*/

select id_tienda
from vendart, vendedores
where vendart.id_vend=vendedores.id_vend
group by id_tienda
having count(*)=(select count(*)
		from vendart, vendedores
		where vendart.id_vend=vendedores.id_vend
		group by id_tienda
        order by 1 limit 1);

/*compruebo que he borrado la tienda o cerrado la tienda*/
select * from tienda;

/* la puedo hacer creando una vista*/
create view cerrartienda as
select id_tienda
from vendart, vendedores
where vendart.id_vend=vendedores.id_vend
group by id_tienda
having count(*)=(select count(*)
		from vendart, vendedores
		where vendart.id_vend=vendedores.id_vend
		group by id_tienda
        order by 1 limit 1);
        
select * from cerrartienda;
/*para borrarla*/
delete from tienda
where id_tienda in (select id_tienda from cerrartienda);

select * from tienda;

/*26 la tienda luna pasa a llamarse sol y luna*/

update tienda set nom_tienda='Sol y Luna'
where nom_tienda like 'Luna';
 
 select * from tienda;
/*27 despedir al trabajador que mas vendio*/
/*trabajajador que mas vendio*/
select id_vend
from vendart
group by id_vend
having count(*)=(select count(*)
				from vendart
				group by id_vend
                order by 1 desc limit 1);
       /*lo elimino*/         
delete from vendedores
where id_vend in (select id_vend
					from vendart
					group by id_vend
					having count(*)=(select count(*)
									from vendart
									group by id_vend
									order by 1 desc limit 1));
                                    
                                    
/*tambien lo podeis hacer con una vista*/
/*28 las tiendas que no vendieron lapices 
pasan todas a sevilla*/

update tienda set id_ciudad=(select id_ciudad
							from ciudad
                            where nom_ciudad like 'Sevilla')
where id_tienda not in(select distinct id_tienda
						from vendart,vendedores,articulos
						where vendart.id_vend=vendedores.id_vend
						and vendart.id_art=articulos.id_art
						and nom_art like 'Lapiz');

/*tiendas que vendieron lapices*/
select distinct id_tienda
from vendart,vendedores,articulos
where vendart.id_vend=vendedores.id_vend
and vendart.id_art=articulos.id_art
and nom_art like 'Lapiz';

/*29 depedir al vendedore que menos dinero ha hecho vendiendo*/
/*averiguo quien es el vendedor*/
select id_vend 
from vendart,articulos
where vendart.id_art=articulos.id_art
group by id_vend
having sum(precio)=(select sum(precio)
				from vendart,articulos
				where vendart.id_art=articulos.id_art
				group by id_vend
                order by 1 limit 1);


delete from vendedores
where id_vend in (select id_vend 
					from vendart,articulos
					where vendart.id_art=articulos.id_art
					group by id_vend
					having sum(precio)=(select sum(precio)
										from vendart,articulos
										where vendart.id_art=articulos.id_art
										group by id_vend
										order by 1 limit 1));
/* pendiente hacerla con una vista*/
                
                
select * from vendedores;

/*30 el articulo que menos se ha vendido deja de estar en stock*/

select id_art, count(*)
from vendart
group by id_art
having count(*)=(select count(*)
				from vendart
				group by id_art
				order by 1 limit 1);

select * from vendart;

delete from articulos
where id_art in (select id_art
from vendart
group by id_art
having count(*)=(select count(*)
		from vendart
		group by id_art
        order by 1 limit 1));
        
select * from articulos;
/*31 el articulo que menos
 dinero ha generado deja de estar en stock*/
/*creaNDO UNA VISTA*/

create view articulosstock as 
select vendart.id_art
from vendart,articulos
where vendart.id_art=articulos.id_art
group by vendart.id_art
having sum(precio)=(select sum(precio)
					from vendart,articulos
                    where vendart.id_art=articulos.id_art
					group by vendart.id_art
                    order by 1 limit 1);
                    
select * from articulosstock;
                    
                    
delete from articulos
where id_art in (select id_art
				from articulosstock);



                    
                    
select * from articulosstock;
   /* sin vista*/
   
delete from articulos
where id_art in( select vendart.id_art
				from vendart,articulos
				where vendart.id_art=articulos.id_art
				group by vendart.id_art
				having sum(precio)=(select sum(precio)
									from vendart,articulos
									where vendart.id_art=articulos.id_art
									group by vendart.id_art
									order by 1 limit 1));                
                    
/*32 el tipo de articulo menos vendido deja de estar en stock*/

delete from tipoart
where id_tipo in (select id_tipo
				from vendart,articulos
				where vendart.id_art=articulos.id_art
				group by id_tipo
				having count(*)=(select count(*)
								from vendart,articulos
								where vendart.id_art=articulos.id_art
								group by id_tipo
								order by 1 limit 1));
                
                
//*CREADO VISTA*/
CREATE VIEW ARTICULOMENOSVENDIDO AS
select id_tipo
from vendart,articulos
where vendart.id_art=articulos.id_art
group by id_tipo
having count(*)=(select count(*)
				from vendart,articulos
				where vendart.id_art=articulos.id_art
				group by id_tipo
                order by 1 limit 1);


DELETE FROM ARTICULOS 
WHERE id_tipo in (select id_tipo from articulomenosvendido);
                
/*33 el tipo con el que menos se ha ganado deja de estar en stock
*/
create view  tipostock as
select id_tipo
from vendart,articulos
where vendart.id_art=articulos.id_art
group by id_tipo
having sum(precio)=(select sum(precio)
				from vendart,articulos
				where vendart.id_art=articulos.id_art
				group by id_tipo
                order by 1 limit 1);
                
delete from tipoart
where id_tipo in (select id_tipo from tipostock);
/*sin vista*/
delete from tipoart
where id_tipo in(select id_tipo
					from vendart,articulos
					where vendart.id_art=articulos.id_art
					group by id_tipo
					having sum(precio)=(select sum(precio)
									from vendart,articulos
									where vendart.id_art=articulos.id_art
									group by id_tipo
									order by 1 limit 1));

/*34 se despide a todos los 
trabajadores que no han vendido articulos  de bazar*/

delete from vendedores
where id_vend not in (select id_vend
					from vendart,articulos,tipoart
					where vendart.id_art=articulos.id_art
					and articulos.id_tipo=tipoart.id_tipo
					and nom_tipo like 'Bazar');


select id_vend
from vendart,articulos,tipoart
where vendart.id_art=articulos.id_art
and articulos.id_tipo=tipoart.id_tipo
and nom_tipo like 'Bazar';

/*35 se cierra LA TIENDA QUE MENOS DINERO HA GANADO*/

delete from tienda
where id_tienda in (select id_tienda
				from vendart,vendedores,articulos
				where vendart.id_vend=vendedores.id_vend
			and vendart.id_art=articulos.id_art
			group by id_tienda
			having sum(precio)=(select sum(precio)
								from vendart,vendedores,articulos
								where vendart.id_vend=vendedores.id_vend
								and vendart.id_art=articulos.id_art
								group by id_tienda
								order by 1 limit 1));

/*averiguo la tienda que menos ha vendido*/
select id_tienda
from vendart,vendedores,articulos
where vendart.id_vend=vendedores.id_vend
and vendart.id_art=articulos.id_art
group by id_tienda
 having sum(precio)=(select sum(precio)
					from vendart,vendedores,articulos
					where vendart.id_vend=vendedores.id_vend
					and vendart.id_art=articulos.id_art
					group by id_tienda
					order by 1 limit 1);
/*36 Todos los trabajadores de sevilla
 pasan a la tienda de Joymon*/
 
update vendedores set id_tienda=(select 
								id_tienda from tienda
                                where nom_tienda like 
								'Joymon')
where id_tienda in (select id_tienda
					from ciudad, tienda
					where ciudad.id_ciudad=tienda.id_ciudad
					and  nom_ciudad like 'Sevilla');
