create database if not exists Relacion1;
use Relacion1;
create table if not exists alumno(
id_al char(3),
nom_al varchar(40),
fech_al date,
telf_al varchar(9),
primary key (id_al)
)engine=InnoDB;
create table if not exists profesor(
id_prof char(3),
nom_prof varchar(40),
fech_prof date,
telf_prof varchar(9),
primary key (id_prof)
)engine=InnoDB;
create table if not exists relacion(
id_al char(3),
id_prof char(3),
nota double,
primary key (id_al, id_prof),
foreign key (id_al) references alumno(id_al) on delete cascade on update cascade,
foreign key (id_prof) references profesor(id_prof) on delete cascade on update cascade
)engine=InnoDB;

insert into alumno values
('A01','JUAN MUÑOZ','1978/09/04','676543456'),
('A02','ANA TORRES','1980/12/05','654786756'),
('A03','PEPE GARCIA','1982/08/09','950441234'),
('A04','JULIO GOMEZ','1983/12/23','678909876'),
('A05','KIKO ANDRADES','1979/01/30','666123456');

insert into profesor values
('P01','CARMEN TORRES','1966-09-08','654789654'),
('P02','FERNANDO GARCIA','1961/07/09','656894123');

insert into relacion values
('A01','P01',3.56),
('A01','P02',4.57),
('A02','P01',5.78),
('A02','P02',7.80),
('A03','P01',4.55),
('A03','P02',5),
('A04','P02',10),
('A05','P01',2.75),
('A05','P02',8.45);
/*3)Mostrar todos los nombres de los alumnos con sus teléfonos*/
select nom_al, telf_al from alumno;
/*4)Mostrar los nombres de los alumnos ordenados en orden creciente y decreciente*/
select nom_al from alumno order by nom_al asc;
select nom_al from alumno order by nom_al desc;
/*5)Mostrar los alumnos ordenados por edad*/
select * from alumno order by fech_al asc;
/*6)Mostrar nombre de alumnos que contengan alguna ‘A’ en el nombre*/
select * from alumno where nom_al like'%a%';
/*7)Mostrar id_al ordenado por nota*/
select id_al, nota from relacion order by nota desc;
/*8)Mostrar nombre alumno y nombre de sus respectivos profesores.*/
select nom_al, nom_prof from relacion r, alumno a, profesor p where r.id_al=a.id_al and r.id_prof=p.id_prof;
/*9.- Mostrar el nombre de los alumnos que les de clase el profesor P01*/
select nom_al from relacion r, alumno a where r.id_al=a.id_al and r.id_prof='P01';
/*10.- Mostrar el nombre y la nota de los alumnos que les de clase el profesor ‘FERNAND0 GARCIA’.*/
select a.nom_al, r.nota from alumno a, relacion r, profesor p where r.id_al=a.id_al 
and r.id_prof=p.id_prof and p.nom_prof='FERNANDO GARCIA';
/*11.- Mostrar todos los alumnos (codigo) que hayan aprobado con el profesor P01*/
select a.id_al, r.nota from alumno a, relacion r where r.id_al=a.id_al and r.nota>=5 and r.id_prof='P01';
/*12.- Mostrar todos los alumnos (nombre) que hayan aprobado con el profesor P01*/
select a.nom_al, r.nota from alumno a, relacion r where r.id_al=a.id_al and r.nota>=5 and r.id_prof='P01';
/*13.- Mostrar todos los alumnos (nombre) que hayan aprobado con el profesor ‘CARMEN TORRES’*/
select a.nom_al, r.nota
from alumno a, relacion r, profesor p 
where r.id_al=a.id_al
and r.id_prof=p.id_prof 
and r.nota>=5 
and p.nom_prof like'CARMEN TORRES' ;
/*14.- Mostrar el alumno/s que haya obtenido la nota más alta con ‘P01’,*/
select max(r.nota) from relacion r where r.id_prof='P01';
select a.nom_al, r.nota 
from alumno a, relacion r 
where nota=(select max(nota) from relacion where id_prof like'P01') 
and a.id_al=r.id_al;
/*15.- Mostrar los alumnos (nombre y codigo) que hayan aprobado todo.*/
select nom_al
from alumno
where id_al not in (select id_al from relacion where nota<5);

/*Muestrame cuantos alumnos tiene asignado cada profesor pero que muestre el nombre del profesor*/
select count(id_al), p.nom_prof 
from relacion r, profesor p 
where r.id_prof=p.id_prof 
group by r.id_prof;

/*media de nota que han sacado los alumnos con cada id_profesor*/
select avg(nota) as 'media', id_prof from relacion group by id_prof;
/*nota media de cada alumno(id_al)*/
select avg(nota) as media, id_al from relacion group by id_al;
/*nota media de cada alumno, que muestre la nota media y el nombre del alumno*/
select avg(r.nota) as 'media', a.nom_al as 'nombre'
from relacion r, alumno a
where r.id_al=a.id_al
group by r.id_al;
/*nota media de los alumno que obtienen una media mayor que 7*/
select avg(r.nota) as 'media', a.nom_al as 'nombre'
from relacion r, alumno a
where r.id_al=a.id_al
group by r.id_al
having avg(nota)>7;
/*nombre del profesor que tiene a su cargo mas de 4 alumnos*/
select p.nom_prof, count(id_al)
from relacion r, profesor p
where r.id_prof=p.id_prof
group by r.id_prof
having	count(r.id_al)>4;
/*cual es el profesor o profesores que tiene mas alumnos*/
