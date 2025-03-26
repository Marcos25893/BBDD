/*Relacion 3 sql Crear tablas*/

/*Ejercicio numero 1*/
create database if not exists carteros;
use carteros;
create table  if not exists Provincia(
id_prov char(3) not null,
nom_prov varchar(15) not null,
primary key(id_prov) 
)
engine=Innodb;

create table if not exists Ciudad(
id_ciud char(3) not null,
nom_ciud varchar(20) not null,
num_hab int not null,
id_prov char(3) not null,
primary key(id_ciud),
foreign key(id_prov) references Provincia(id_prov) on delete cascade
on update cascade
)
engine=Innodb;

create table if not exists zona(
id_zona char(3) not null,
nom_zona varchar(10) not null,
id_ciud char(3) not null,
primary key(id_zona,id_ciud),
foreign key (id_ciud) references Ciudad(id_ciud) on delete cascade
on update cascade
)
engine=Innodb;

create table  if not exists cartero(
id_cart char(3) not null,
nom_cart varchar(25) not null,
sueldo int,
primary key(id_cart)
)
engine=Innodb;

create table if not exists periodos(
id_per char(3) not null,
fecha_ini date not null,
fecha_fin date not null,
primary key(id_per)
)
engine=Innodb;

create table  if not exists Relacion3(
id_ciud char(3) not null,
id_zona char(3) not null,
id_cart char(3) not null,
id_per char(3) not null,
primary key (id_ciud,id_cart,id_per,id_zona),
foreign key (id_zona,id_ciud) references zona(id_zona,id_ciud) on delete cascade on update cascade,
foreign key (id_cart) references cartero(id_cart) on delete cascade on update cascade,
foreign key (id_per) references periodos(id_per) on delete cascade on update cascade
)
engine=Innodb;


insert into Provincia values('P01','Sevilla');
insert into Provincia values('P02','Granada');
insert into Provincia values('P03','Almeria');

select * from Provincia;

insert into Ciudad values('C01','Ciudad1','890000','P01');
insert into Ciudad values('C02','Ciudad2','110000','P02');
insert into Ciudad values('C03','Ciudad3','98000','P03');
insert into Ciudad values('C04','Ciudad4','65000','P01');

select * from Ciudad;
insert into zona values('Z01','Centro','C01');
insert into zona values('Z02','Este','C01');
insert into zona values('Z03','Oeste','C01');
insert into zona values('Z04','Norte','C01');
insert into zona values('Z05','Sur','C01');
insert into zona values('Z01','Centro','C02');
insert into zona values('Z02','Poligono','C02');
insert into zona values('Z03','Oeste','C02');
insert into zona values('Z04','Norte','C02');
insert into zona values('Z05','Sur','C02');
insert into zona values('Z01','Centro','C03');
insert into zona values('Z02','Este','C03');
insert into zona values('Z03','Barriadas','C03');
insert into zona values('Z04','Norte','C03');
insert into zona values('Z05','Sur','C03');
insert into zona values('Z01','Centro','C04');
insert into zona values('Z02','Bulevard','C04');
insert into zona values('Z03','Oeste','C04');
insert into zona values('Z04','Norte','C04');
insert into zona values('Z05','Rivera','C04');

select * from zona;

insert into cartero values('CT1','Juan Perez',1100);
insert into cartero values('CT2','Ana Torres',1080);
insert into cartero values('CT3','Pepa Fernandez',1100);
insert into cartero values('CT4','Vicente Valles',1790);
insert into cartero values('CT5','Fernando Gines',1013);
insert into cartero values('CT6','Lisa Tormes',897);
insert into cartero values('CT7','Waldo Perez',899);
insert into cartero values('CT8','Kika Garcia',987);
insert into cartero values('CT9','Lola Jimenez',1123);

select * from cartero;

insert into periodos values('PE1','2000/05/01','2000/03/30');
insert into periodos values('PE2','2000/03/30','2000/08/15');
insert into periodos values('PE3','2000/08/15','2000/11/20');
insert into periodos values('PE4','2000/11/20','2000/12/25');
insert into periodos values('PE5','2000/12/25','2001/03/03');

select * from periodos;

insert into Relacion3 values ('C01','Z01','CT1','PE1');
insert into Relacion3 values('C02','Z01','CT2','PE1');
insert into Relacion3 values('C03','Z01','CT3','PE1');
insert into Relacion3 values('C04','Z01','CT4','PE1');
insert into Relacion3 values('C01','Z02','CT5','PE1');
insert into Relacion3 values('C02','Z02','CT6','PE1');
insert into Relacion3 values('C03','Z02','CT7','PE1');
insert into Relacion3 values('C04','Z02','CT8','PE1');
insert into Relacion3 values('C01','Z03','CT9','PE1');
insert into Relacion3 values('C02','Z03','CT1','PE2');
insert into Relacion3 values('C03','Z03','CT2','PE2');
insert into Relacion3 values('C04','Z03','CT3','PE2');
insert into Relacion3 values('C01','Z04','CT4','PE2');
insert into Relacion3 values('C02','Z04','CT5','PE2');
insert into Relacion3 values('C03','Z04','CT6','PE2');
insert into Relacion3 values('C04','Z04','CT7','PE2');
insert into Relacion3 values('C01','Z05','CT8','PE2');
insert into Relacion3 values('C02','Z05','CT9','PE2');
insert into Relacion3 values('C03','Z05','CT1','PE3');
insert into Relacion3 values('C04','Z05','CT2','PE3');
insert into Relacion3 values('C01','Z01','CT3','PE3');
insert into Relacion3 values('C02','Z02','CT4','PE3');
insert into Relacion3 values('C01','Z03','CT5','PE3');
insert into Relacion3 values('C01','Z04','CT6','PE3');
insert into Relacion3 values('C01','Z05','CT7','PE3');
insert into Relacion3 values('C01','Z01','CT8','PE4');
insert into Relacion3 values('C03','Z02','CT9','PE3');
insert into Relacion3 values('C04','Z03','CT1','PE4');
insert into Relacion3 values('C01','Z04','CT2','PE4');
insert into Relacion3 values('C01','Z05','CT3','PE4');

/*1.-NOMBRE DE CIUDAD CON MÁS HABITANTES.*/
select nom_ciud, num_hab
from Ciudad
where num_hab=(select max(num_hab) from Ciudad);
/*2.- NOMBRE DEL CARTERO CON MAYOR SUELDO*/
select nom_cart
from cartero
where sueldo=(select max(sueldo) from cartero);
/*3.- NOMBRE CIUDADES, Nº HABITANTES DE LA PROVINCIA DE SEVILLA*/
select c.nom_ciud, c.num_hab
from Ciudad c, Provincia p
where c.id_prov=p.id_prov and p.nom_prov='Sevilla';
/*4.- CARTEROS ORDENADOS POR SULEDO.*/
select *
from cartero
order by sueldo;
/*5.- NOMBRE DE CIUDAD Y NOMBRE DE ZONA*/
select nom_ciud, nom_zona
from Ciudad c, zona z
where c.id_ciud=z.id_ciud;
/*6.- ZONAS DE LA „C02‟*/
select *
from zona 
where id_ciud='C02';
/*7.- ZONAS DE LA CIUDAD “CIUDAD3”.*/
select z.id_zona, z.nom_zona
from Ciudad c, zona z
where c.id_ciud=z.id_ciud and c.nom_ciud='CIUDAD3';
/*8.- NOMBRE DE LOS CARTEROS QUE HAN TRABAJADO EN LA ZONA “Z01,C02”*/
select c.nom_cart
from cartero c, Relacion3 r
where c.id_cart=r.id_cart
and id_zona='Z01' and id_ciud='C02';
/*9.- NOMBRE DE LOS CARTEROS QUE HAN TRABAJADO EN LA ZONA CENTRO DE LA CIUDAD1*/
select c.nom_cart
from cartero c, Relacion3 r, zona z
where c.id_cart=r.id_cart and z.id_zona=r.id_zona
and r.id_ciud='C01' and z.nom_zona='Centro'
and r.id_ciud=z.id_ciud;
/*10.- NOMBRE DE LOS CARTEROS (Y FECHAS DE INICIO Y FIN) QUE HAN TRABAJADO EN LA RIVERA
DE LA CIUDAD 4.*/
select c.nom_cart, p.fecha_ini, p.fecha_fin
from cartero c, periodos p, Relacion3 r, zona z, Ciudad m
where c.id_cart=r.id_cart and r.id_per=p.id_per
and z.id_zona=r.id_zona and z.id_ciud=r.id_ciud
and z.id_ciud=m.id_ciud and z.nom_zona='Rivera'
and m.nom_ciud='CIUDAD4';
/*11.- NOMBRE DE LOS CARTEROS QUE HAN TRABAJADO EN LA PROVINCIA DE SEVILLA*/
select distinct c.nom_cart
from cartero c, Relacion3 r, Ciudad m,  Provincia p
where c.id_cart=r.id_cart and p.id_prov=m.id_prov
and r.id_ciud=m.id_ciud and p.nom_prov='Sevilla';
/*12.- NOMBRE DE LOS CARTEROS QUE HAN TRABAJADO EN EL PERIODO PE4 Y NOMBRE DE LA
CIUDAD EN QUE ESTABAN TRABAJANDO.*/
select c.nom_cart, m.nom_ciud
from cartero c, Ciudad m, Relacion3 r, periodos p
where c.id_cart=r.id_cart and m.id_ciud=r.id_ciud
and r.id_per=p.id_per and p.id_per='PE4';
/*13.- CARTEROS QUE HAN TRABAJADO EN LA CIUDAD CIUDAD1 Y FECHA DE INICIO Y FIN EN QUE
LO HAN HECHO.*/
select c.nom_cart, p.fecha_ini, p.fecha_fin
from cartero c, Ciudad m, Relacion3 r, periodos p
where c.id_cart=r.id_cart and m.id_ciud=r.id_ciud
and r.id_per=p.id_per and m.nom_ciud='Ciudad1';
/*14.- CARTEROS QUE HAN TRABAJADO EN LA PROVINCIA DE ALMERIA NOMBRE DE ZONA Y
CIUDAD Y FECHAS EN QUE LO HAN HECHO.*/
select c.nom_cart, z.nom_zona, m.nom_ciud, t.fecha_ini, t.fecha_fin
from cartero c, zona z, Ciudad m, periodos t, Relacion3 r, Provincia p
where c.id_cart=r.id_cart and r.id_ciud=z.id_ciud and z.id_ciud=m.id_ciud
and r.id_zona=z.id_zona and r.id_per=t.id_per
and p.id_prov=m.id_prov and p.nom_prov='Almeria'
and z.id_ciud=m.id_ciud;
/*15.- NUMERO DE HABITANTES DE CADA PROVINCIA.*/
select sum(num_hab)
from Ciudad c, Provincia p
where c.id_prov=p.id_prov
group by c.id_prov;
/*16.- NOMBRE Y SUELDO DEL CARTERO QUE MÁS PERIODOS HA TRABAJADO*/
select count(id_per), id_cart 
from Relacion3 group by id_cart having count(id_per)=(select count(id_per)
from Relacion3 group by id_cart order by 1 desc limit 1);
/*averigua cuantos periodos ha trabajado cada cartero*/
select count(id_per) as 'Periodos Trabajos', r.id_cart, sueldo, c.nom_cart
from Relacion3 r, cartero c
where r.id_cart=c.id_cart
group by r.id_cart
having count(id_per)=(select count(id_per)
					from Relacion3
					group by id_cart
                    order by 1 desc limit 1);
/*17.- NOMBRE DE LACIUDAD QUE MAS CARTEROS HA TENIDO.*/
select m.nom_ciud
from Ciudad m, Relacion3 r, cartero c
where m.id_ciud = r.id_ciud
and r.id_cart = c.id_cart
group by m.nom_ciud
order by COUNT(r.id_cart) desc limit 1;
/*18.- NOMBRE DE LA ZONA QUE MAS CARTEROS HA TENIDO (Y Nº DE CARTEROS)*/

select count(id_cart), id_zona
from Relacion3
group by id_zona, id_ciud
order by 1 desc;
/*Con inner join*/
select count(id_cart), nom_zona
from Relacion3
inner join zona
on Relacion3.id_zona=zona.id_zona
and Relacion3.id_ciud=zona.id_ciud
group by Relacion3.id_zona, Relacion3.id_ciud
having count(id_cart)=(select count(id_cart)
						from Relacion3
						group by id_zona, id_ciud
						order by 1 desc limit 1);
/*Sin el inner join*/
select count(id_cart), nom_zona
from Relacion3, zona
where Relacion3.id_zona=zona.id_zona
and Relacion3.id_ciud=zona.id_ciud
group by Relacion3.id_zona, Relacion3.id_ciud
having count(id_cart)=(select count(id_cart)
						from Relacion3
						group by id_zona, id_ciud
						order by 1 desc limit 1);

/*19.- NOMBRE/S Y SUELDO/S DEL CARTERO QUE HA REPARTIDO EN EL ESTE DE LA CIUDAD3.*/
select c.nom_cart, c.sueldo, z.nom_zona, m.nom_ciud
from cartero c, Relacion3 r, zona z, Ciudad m
where c.id_cart=r.id_cart and z.id_zona=r.id_zona
and z.id_ciud=r.id_ciud and z.id_ciud=m.id_ciud 
and z.nom_zona='ESTE' and m.nom_ciud='CIUDAD3';  
                    
/*20.- NOMBRE DE LOS CARTEROS QUE NO HAN TRABAJADO EN LA PROVINCIA DE SEVILLA*/
select nom_cart
from cartero
where id_cart not in(select id_cart
					from Relacion3 r, Ciudad c, Provincia p
                    where r.id_ciud=c.id_ciud and c.id_prov=p.id_prov
					and p.nom_prov='Sevilla');
                    

/*21.- NOMBRE Y SUELDO DE LOS CARTEROS QUE NO HAN TRABAJADO EN LA RIVERA DE LA CIUDAD4*/
select distinct c.nom_cart, sueldo
from cartero c, Relacion3 r, Ciudad m, zona z
where c.id_cart=r.id_cart and r.id_zona=z.id_zona
and m.id_ciud=z.id_ciud and z.nom_zona!='RIVERA'
and m.nom_ciud!='CIUDAD4';
