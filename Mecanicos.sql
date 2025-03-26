create database if not exists mecanicos;
use mecanicos;

create table if not exists mecanico(
id_mec char(3) not null,
nom_mec varchar(25) not null,
sueldo int not null,
fec_nac date not null,
primary key (id_mec)
)
engine=Innodb;

create table if not exists coche(
mat_co char(8) not null,
mod_co varchar(25) not null,
color varchar(20) not null,
tipo varchar(20) not null,
primary key(mat_co)
)
engine=Innodb;

create table if not exists periodos(
id_per char(3) not null,
fec_ini date not null,
fec_fin date not null,
primary key(id_per)
)
engine=Innodb;
 
 create table if not exists tipo(
 id_tipo char(3) not null,
 nom_tipo varchar(30) not null,
 primary key(id_tipo)
 )
 engine=Innodb;
 
 create table if not exists pieza(
 id_piez char(3) not null,
 nom_piez varchar(30) not null,
 id_tipo char(3) not null,
 primary key(id_piez),
 foreign key (id_tipo) references tipo(id_tipo) on update cascade on delete cascade
 )
 engine=Innodb;
 
 create table if not exists relacion(
 id_mec char(3) not null,
 mat_co char(8) not null,
 id_per char(3) not null,
 id_piez char(3) not null,
 precio int not null,
 primary key(id_mec,mat_co,id_per,id_piez),
 foreign key (id_mec) references mecanico(id_mec) on update cascade on delete cascade,
 foreign key (mat_co) references coche(mat_co) on update cascade on delete cascade,
 foreign key (id_per) references periodos(id_per) on update cascade on delete cascade,
 foreign key (id_piez) references pieza(id_piez) on update cascade on delete cascade
 )
  engine=Innodb;
 
 insert into mecanico values
 ('ME1','JUAN ROMUALDO',1289,'1970-09-05'),
 ('ME2', 'RAMON FERNANDEZ', 1678, '1976-07-05'),
 ('ME3', 'ANA LUCAS', 1100, '1968-09-04');
 
 insert into coche values
 ('1234-CDF','SEAT LEON','GRIS','DIESEL'),
 ('0987-CCC','RENAULT MEGANE','BLANCO','GASOLINA'),
 ('0123-BVC','OPEL ASTRA','AZUL','DIESEL'),
 ('1456-BNL','FORD FOCUS','VERDE','DIESEL'),
 ('1111-CSA','SEAT TOLEDO','ROJO','GASOLINA'),
 ('4567-BCB','VOLKSWAGEN POLO','BLANCO','DIESEL'),
 ('0987-BFG','FORD FIESTA','NEGRO','GASOLINA');
 
insert into periodos values
('PE1','2003-04-09','2003-04-10'),
('PE2','2004-05-12','2004-05-17'),
('PE3','2004-06-17','2004-06-27'),
('PE4','2005-08-22','2005-09-1'),
('PE5','2005-09-10','2005-09-15'),
('PE6','2005-10-1','2005-10-17');

insert into tipo values
('TI1','CHAPA'),
('TI2','MECANICA'),
('TI3','ELECTRICIDAD'),
('TI4','ACCESORIOS');

insert into pieza values
('PI1','FILTRO','TI4'),
('PI2','BATERIA','TI3'),
('PI3','ACEITE','TI2'),
('PI4','RADIO','TI4'),
('PI5','EMBRAGUE','TI2'),
('PI6','ALETA','TI1'),
('PI7','PILOTO','TI3'),
('PI8','CALENTADOR','TI2'),
('PI9','CORREAS','TI4');

insert into relacion values
('ME1','1234-CDF','PE1','PI1',23),
('ME1','0123-BVC','PE2','PI2',98),
('ME1','1456-BNL','PE3','PI6',124),
('ME1','4567-BCB','PE4','PI5',245),
('ME2','0987-CCC','PE1','PI9',345),
('ME2','0987-CCC','PE1','PI8',232),
('ME2','0987-BFG','PE2','PI1',17),
('ME2','4567-BCB','PE3','PI7',99),
('ME2','1111-CSA','PE4','PI4',124),
('ME2','1111-CSA','PE4','PI2',153),
('ME3','1456-BNL','PE6','PI3',89),
('ME3','1456-BNL','PE1','PI4',232),
('ME3','1234-CDF','PE2','PI8',235),
('ME3','1111-CSA','PE3','PI9',567),
('ME3','0123-BVC','PE5','PI6',232),
('ME3','0987-CCC','PE4','PI2',78),
('ME1','0987-BFG','PE5','PI3',64),
('ME2','1234-CDF','PE6','PI5',234),
('ME1','0987-BFG','PE6','PI9',345),
('ME2','1234-CDF','PE6','PI1',12),
('ME1','1234-CDF','PE1','PI6',187),
('ME3','1111-CSA','PE3','PI4',345),
('ME1','0123-BVC','PE2','PI3',72),
('ME2','0123-BVC','PE6','PI3',89);


/*1.- DATOS DEL EMPLEADO DE MAYOR SUELDO.*/
select *
from mecanico
where sueldo=(select max(sueldo) from mecanico);
/*2.- DATOS DEL EMPLEADO MAYOR*/
 select *
from mecanico
where fec_nac=(select min(fec_nac) from mecanico);
/*3.- DATOS DEL EMPLEADO MENOR.*/
 select *
from mecanico
where fec_nac=(select max(fec_nac) from mecanico);
/*4.- DATOS DE TODOS LOS COCHES DIESEL.*/
select * 
from coche
where tipo='DIESEL';
/*5.- DATOS DEL COCHE QUE MAS HA IDO AL TALLER.*/
select count(r.mat_co) as 'nº veces', c.*
from relacion r, coche c
where r.mat_co=c.mat_co 
group by r.mat_co
having count(r.mat_co)=(select count(mat_co)
from relacion
group by mat_co
order by 1 desc limit 1);

/*6.- PRECIO TOTAL DE TODAS LAS REPARACIONES.*/
select sum(precio)
from relacion;
/*7.- NOMBRE DE PIEZA Y TIPO DE LA PIEZA MAS USADA.*/
select p.nom_piez, nom_tipo, COUNT(r.id_piez) as 'nºveces'
from pieza p, relacion r, tipo t
where p.id_piez = r.id_piez
and p.id_tipo=t.id_tipo
group by r.id_piez
having count(r.id_piez)=(select COUNT(id_piez)
						from relacion 
						group by id_piez
						order by count(id_piez) desc
						limit 1);

/*8.NOMBRE Y TIPO DE LA PIEZA MENOS USADA.*/
select p.nom_piez, p.id_tipo, COUNT(r.id_piez) as 'nºveces'
from pieza p, relacion r
where p.id_piez = r.id_piez
group by r.id_piez
having count(r.id_piez)=(select COUNT(id_piez)
						from relacion 
						group by id_piez
						order by count(id_piez) asc
						limit 1);
/*9.- MATRICULA, MARCA, MODELO COLOR PIEZA Y TIPO DE TODOS LOS COCHES REPARADOS.*/
select c.mat_co, mod_co, color, tipo, p.nom_piez, id_tipo
from coche c, relacion r, pieza p
where c.mat_co=r.mat_co
and r.id_piez=p.id_piez
order by r.mat_co;
/*10.- MODELO DE PIEZA Y TIPO PUESTAS A ‘0123-BVC’*/
select distinct p.nom_piez, id_tipo
from relacion r, pieza p
where r.id_piez=p.id_piez
and r.mat_co='0123-BVC';
/*11.-DINERO QUE HA GASTADO EN REPARACIONES 1234-CDF*/
select sum(precio)
from relacion
where mat_co='1234-CDF';
/*12.- DATOS DEL COCHE QUE MAS HA GASTADO EN REPARACIONES*/
select c.*, sum(precio)
from coche c, relacion r
where c.mat_co=r.mat_co
group by r.mat_co
having sum(precio)=(select sum(precio)
					from relacion r
					group by r.mat_co
					order by sum(precio)
					desc limit 1);
/*13- DATOS DEL COCHE QUE MENOS HA GASTADO EN REPARACIONES.*/
select c.mat_co, mod_co, color, tipo, sum(precio)
from coche c, relacion r
where c.mat_co=r.mat_co
group by r.mat_co
having sum(precio)=(select sum(precio)
					from relacion r
					group by r.mat_co
					order by sum(precio)
					asc limit 1);
/*15.- TOTAL DE TODAS LAS REPARACIONES DE ‘ANA LUCAS’.*/
select count(r.id_mec)
from relacion r, mecanico m
where r.id_mec=m.id_mec
and nom_mec='ANA LUCAS';
/*16.- DATOS DE LOS COCHES Y LAS PIEZAS PUESTAS POR ‘JUAN ROMUALDO’*/
select c.mat_co, mod_co, color, tipo, nom_piez
from relacion r, coche c, mecanico m, pieza p
where r.mat_co=c.mat_co and r.id_mec=m.id_mec
and p.id_piez=r.id_piez and nom_mec='JUAN ROMUALDO';
/*17.- FECHA DE INICIO Y FIN DEL PERIODO EN QUE MAS SE HA TRABAJADO.*/
select count(r.id_per) as 'Veces tranajadas', fec_ini, fec_fin
from periodos p, relacion r
where p.id_per=r.id_per
group by r.id_per
having count(r.id_per)=(select count(id_per)
						from relacion
						group by id_per
						order by count(id_per)
						desc limit 1 );

/*18.- FECHA DE INICIO Y FIN DEL PERIODO QUE MENOS SE HA TRABAJADO.*/
select count(r.id_per) as 'Veces tranajadas', fec_ini, fec_fin
from periodos p, relacion r
where p.id_per=r.id_per
group by r.id_per
having count(r.id_per)=(select count(id_per)
						from relacion
						group by id_per
						order by count(id_per)
						asc limit 1 );
/*19.-DINERO QUE SE HA HECHO EN EL PERIODO PE2*/
select sum(precio)
from relacion
where id_per like 'PE2'; 
/*20.- DATOS DE LOS COCHES LA QUE SE LE HALLA PUESTO UN EMBRAGE*/    
select c.mat_co, mod_co, color, tipo, nom_piez
from coche c, relacion r, pieza p
where c.mat_co=r.mat_co
and r.id_piez=p.id_piez
and nom_piez like 'EMBRAGUE';
/*21.- DATOS DE LOS COCHES A LOS QUE SE LES HALLA CAMBIADO EL ACEITE.*/
select distinct c.mat_co, mod_co, color, tipo, nom_piez
from coche c, relacion r, pieza p
where c.mat_co=r.mat_co
and r.id_piez=p.id_piez
and nom_piez='ACEITE';
/*22.- DATOS DE LOS MECANICOS QUE HALLAN PUESTO ALGUNA PIEZA DE TIPO ‘ELECTRICIDAD’.*/
select distinct m.id_mec, nom_mec
from mecanico m, relacion r, pieza p, tipo t
where m.id_mec=r.id_mec and r.id_piez=p.id_piez
and p.id_tipo=t.id_tipo and nom_tipo='ELECTRICIDAD';
/*23.- MONTANTE ECONOMICO DE TODAS LAS PIEZAS DE TIPO CHAPA.*/
select sum(precio)
from relacion r, pieza p, tipo t
where r.id_piez=p.id_piez and p.id_tipo=t.id_tipo
and nom_tipo like 'CHAPA';
/*24.- TIPODE PIEZA QUE MAS DINERO HA DEJADO EN EL TALLER.*/
select sum(precio), nom_tipo, t.id_tipo
from relacion r, pieza p, tipo t
where r.id_piez=p.id_piez and p.id_tipo=t.id_tipo
group by t.id_tipo
having sum(precio)=(select sum(precio)
					from relacion r, pieza p, tipo t
					where r.id_piez=p.id_piez and p.id_tipo=t.id_tipo
					group by p.id_tipo
					order by 1 desc limit 1);
/*25.-DATOS DEL MECANICO QUE MENOS HA TRABAJADO.*/
/*Esta es la que menos trabajos a realizado*/
select count(r.id_mec) as 'Trabajos', m.*
from mecanico m, relacion r
where m.id_mec=r.id_mec
group by r.id_mec
having count(r.id_mec)=(select count(id_mec)
						from relacion
						group by id_mec
						order by 1 asc limit 1);
                        
/*Y este seria el que menos dias a trabajado*/                        
select sum(datediff(fec_fin, fec_ini)) as 'Dias', m.* /*(datediff)Calcula diferencias entre fechas*/                        
from mecanico m, relacion r, periodos p
where m.id_mec=r.id_mec
and r.id_per=p.id_per
group by r.id_mec
having sum(datediff(fec_fin,fec_ini))=(select sum(datediff(fec_fin,fec_ini))
										from  relacion r, periodos p
										where r.id_per=p.id_per
										group by id_mec
										order by 1 asc limit 1);