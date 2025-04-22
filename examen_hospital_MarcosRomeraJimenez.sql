Create database if not exists Hospitales;
use Hospitales;

Create table if not exists clinica(
idClinica char(2),
nombre varchar(30),
ciudad varchar(20),
primary key (idClinica)
)Engine=InnoDB;

Create table if not exists investigacion(
idInvestigacion char(3),
nombre varchar(60),
idClinica char(2),
primary key (idInvestigacion),
foreign key (idClinica) references clinica(idClinica) on delete restrict on update cascade
)Engine=InnoDB;

Create table if not exists doctor(
idDoctor char(3),
nombre varchar(30),
fechaIngreso date,
salario double,
idSupervisor char(3),
idClinica char(2),
primary key (idDoctor),
foreign key (idSupervisor) references doctor(idDoctor) on delete set null on update cascade,
foreign key (idClinica) references clinica(idClinica) on delete restrict on update cascade
)Engine=InnoDB;

Create table if not exists participa(
idDoctor char(3),
idInvestigacion char(3),
horas integer,
primary key (idDoctor, idInvestigacion),
foreign key (idDoctor) references doctor(idDoctor) on delete cascade on update cascade,
foreign key (idInvestigacion) references investigacion(idInvestigacion) on delete cascade on update cascade
)Engine=InnoDB;

Insert into clinica values
('01', "Clínica Central", "Madrid"),
('02', "Clínica Universitaria", "Salamanca"),
('03', "Clínica del Sur", "Valencia"),
('04', "Clínica General", "Bilbao"),
('05', "Clínica del Mar", "Barcelona"),
('06', "Clínica Horizonte", "Sevilla");

Insert into doctor values
('D01', "Ana Gómez", '2000-05-10', 2700, null, '03'),
('D02', "Luis Torres", '2003-07-12', 1800, 'D01', '03'),
('D03', "Eva Sánchez", '2008-09-15', 2200, 'D01', '03'),
('D04', "Daniel Pérez", '2010-01-01', 1600, 'D01', '03'),
('D05', "Marta Ruiz", '2012-02-20', 1500, 'D01', '03'),
('D08', "Jorge Molina", '1995-03-30', 3000, null, '01'),
('D06', "Iván Herrera", '2005-11-11', 2400, 'D08', '01'),
('D07', "Nuria Morales", '2007-06-08', 2300, 'D08', '01'),
('D09', "Teresa Lázaro", '1999-12-25', 2900, null, '06'),
('D10', "Elena Cano", '2004-10-10', 1800, 'D09', '06'),
('D11', "Raúl Muñoz", '2011-09-09', 2100, null, '02'),
('D12', "Clara Navas", null, 1700, 'D11', '02'),
('D13', "Hugo García", '2001-08-08', 2400, 'D09', '06'),
('D14', "Javier Romero", '2016-04-04', 1900, 'D08', null),
('D15', "Patricia Díaz", '2018-12-01', 1700, null, '05'),
('D16', "Adrián Gil", '2019-03-15', 2000, 'D15', '05');

Insert into investigacion values
('GEN', "Genética y Cáncer", '05'),
('NEU', "Neurodegenerativas", '01'),
('SAL', "Saluud Pública", '01'),
('ALM', "Alimentación y Diabetes", '03'),
('TRS', "Trasplantes", '06');

Insert into participa values
('D01', 'ALM', 110),
('D01', 'NEU', 25),
('D02', 'ALM', 40),
('D04', 'ALM', 70),
('D08', 'SAL', 50),
('D07', 'SAL', 10),
('D06', 'SAL', 140),
('D08', 'NEU', 20),
('D09', 'TRS', 160),
('D13', 'TRS', 190),
('D14', 'GEN', 20),
('D15', 'GEN', 15),
('D16', 'GEN', 45);

/*1.​ Nombres de doctores que han trabajado más de 200 horas en total.*/
select nombre, sum(horas)
from doctor d
inner join participa p
on d.idDoctor=p.idDoctor
group by p.idDoctor
having sum(horas) > 200;

/*2.​ Nombre de las clínicas que tienen doctores cuyo apellido sea “García”.*/
select c.nombre
from clinica c
inner join doctor d
on d.idClinica=c.idClinica
where d.nombre like '%Garcia';

/*3.​ Nombre de las investigaciones en las que participan más de dos doctores.*/
select i.nombre, count(idDoctor) as 'nºDoctores'
from investigacion i
inner join participa p
on i.idInvestigacion=p.idInvestigacion
group by p.idInvestigacion
having count(idDoctor) > 2;

/*4.​ Lista de todos los doctores junto al nombre de la clínica a la que pertenecen y el
total de dinero que reciben por participar en investigaciones (a razón de 50 €
por hora).Si no pertenecen a ninguna clínica, debe aparecer el texto “Sin Clínica
Asignada”. Ordenar alfabéticamente por el nombre del doctor.*/
select d.*, ifnull(c.nombre, 'Sin Clínica Asignada') as 'Clinica', (horas*50) as 'Total dinero'
from participa p
inner join doctor d
on d.idDoctor=p.idDoctor
left join clinica c
on c.idClinica=d.idClinica
order by d.nombre;

/*5.​ Lista con el nombre de todos los doctores y el número de investigaciones en las
que participan. Si no participa en ninguna, debe aparecer la frase “Sin
investigación asignada”.*/
select d.nombre, ifnull(count(idInvestigacion), 'Sin investigación asignada') as 'nºInvestigaciones'
from doctor d
left join participa p
on d.idDoctor=p.idDoctor
group by d.idDoctor
having count(idInvestigacion);

/*6.​ Lista de los doctores que trabajan en clínicas ubicadas en Madrid o Valencia.*/
select d.*, c.ciudad
from doctor d
inner join clinica c
on d.idClinica=c.idClinica
where c.ciudad in ('Madrid','Valencia');

/*7.​ Lista alfabética de nombres de doctores y nombres de sus supervisores.
●​ Si el doctor no tiene supervisor, debe aparecer el texto “Sin Supervisor”.*/
select d.nombre as 'Doctor', ifnull(supervisor.nombre, 'Sin Supervisor') as 'Supervisor'
from doctor d
left join doctor as supervisor
on d.idSupervisor=supervisor.idDoctor;

/*8.​ Calcular el promedio del año de ingreso de los doctores que participan en al
menos una investigación.*/
select round(avg(year(fechaIngreso))) as 'Media del año'
from doctor d
inner join participa p 
on d.idDoctor=p.idDoctor
where p.idDoctor in (select idDoctor from participa);

/*9.​ Nombres de los doctores cuyo apellido sea “Díaz” o “Morales” y
simultáneamente su supervisor sea Jorge Molina.*/
select d.nombre
from doctor d
inner join doctor as supervisor
on d.idSupervisor=supervisor.idDoctor
where d.nombre like '%Díaz' or d.nombre like '%Morales'
and d.idSupervisor=(select idDoctor from doctor where nombre like 'Jorge Molina');

/*10.​Listado de todas las clínicas, mostrando:
●​ nombre de la clínica,
●​ ciudad,
●​ número de doctores que trabajan allí.
Ordenar por nombre de clínica y en caso de coincidencia por ciudad.*/
select c.nombre, ciudad, count(idDoctor) as 'nºDoctores'
from clinica c
inner join doctor d
on d.idClinica=c.idClinica
group by c.idClinica
having count(idDoctor)
order by c.nombre, ciudad; 

/*11.​Nombres de los doctores que han trabajado entre 10 y 100 horas en total
sumando todas sus investigaciones.*/
select d.nombre
from doctor d
inner join participa p
on d.idDoctor=p.idDoctor
group by p.idDoctor
having sum(horas) between 10 and 100;

/*12.​Nombres de los doctores que no son supervisores de ningún otro doctor.*/
select d.nombre
from doctor d
where idDoctor in (select d.idDoctor
						from doctor d
						inner join doctor as supervisor
                        on d.idSupervisor=supervisor.idDoctor);

/*13.​Determinar qué clínica es la más productiva, entendiendo productividad como
el número total de horas trabajadas por los doctores en investigaciones dividido
entre el número de doctores de la clínica.*/
select c.*
from clinica c
where idClinica = (select idClinica
					from doctor d
                    inner join participa p
                    on d.idDoctor=p.idDoctor
                    group by idClinica
                    order by count(d.idDoctor)/sum(horas) limit 1);

/*14.​Listado de todos los doctores. En el listado debe aparecer el nombre de los doctores,
nombres de sus clínicas y nombres de las investigaciones en las que participan. Los
doctores sin clínica aparecerán “Sin centro Hospitalario”, y los que no participen en
investigaciones aparecerán “Sin Investigación”.*/
select d.nombre, ifnull(c.nombre, 'Sin centro Hospitalario'), ifnull(i.nombre, 'Sin Investigacion')
from clinica c
right join doctor d
on d.idClinica=c.idClinica
inner join participa p
on d.idDoctor=p.idDoctor
left join investigacion i
on p.idInvestigacion=i.idInvestigacion
and i.idClinica=c.idClinica;

/*15.​ Lista de los doctores con el número de días que llevan trabajando. Si no tienen
fecha, mostrar “Sin fecha de ingreso”. Ordenar por días trabajados y nombre.*/
select d.nombre, ifnull(datediff(now(), fechaIngreso), 'Sin fecha de ingreso')
from doctor d;

/*16.​Lista de doctores que son supervisores de más de dos doctores, junto con el
número de doctores que supervisan.*/
select supervisor.idDoctor, d.idDoctor
from doctor d
inner join doctor as supervisor
on d.idSupervisor=supervisor.idDoctor
group by supervisor.idDoctor
having count(d.idDoctor) > 2;

/*17.​Nombre de las investigaciones que contienen “Neuro”, junto con el nombre de
la clínica organizadora.*/
select i.nombre, c.nombre
from investigacion i
inner join clinica c
on i.idClinica=c.idClinica
where i.nombre like 'Neuro%';

/*18.​Asignar al doctor Javier Romero a la clínica que más gasta en sueldos.*/
update doctor set idClinica = (select c.idClinica from clinica c inner join doctor d
on d.idClinica=c.idClinica group by d.idClinica having sum(salario) order by 1 desc limit 1)
where nombre like 'Javier Romero';

/*19.​Eliminar todas las clínicas sin ningún doctor asignado.*/
delete from clinica where idClinica not in (select idClinica from doctor);

/*20.​Asignar a todos los doctores de la clínica 02 a la investigación SAL*/
/*insert into investigacion
select * from doctor where idClinica='02';*/








