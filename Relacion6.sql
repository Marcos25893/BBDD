create database if not exists Relacion6;
use Relacion6;

create table if not exists Departamento(
cddep char(2),
nombre varchar(30),
ciudad varchar(20),
primary key (cddep)
)engine=InnoDB;

create table if not exists Proyecto(
cdpro char(3),
nombre varchar(30),
cddep char(2),
primary key (cdpro),
foreign key (cddep) references Departamento(cddep) on update cascade on delete restrict
)engine=InnoDB;

create table if not exists Empleado(
cdemp char(3),
nombre varchar(30),
fecha_ingreso date,
cdjefe char(3),
cddep char(2),
primary key (cdemp),
foreign key (cdjefe) references Empleado(cdemp) on update cascade on delete set null,
foreign key (cddep) references Departamento(cddep) on update cascade on delete restrict
)engine=InnoDB;

create table if not exists Trabaja(
cdemp char(3),
cdpro char(3),
nhoras integer,
primary key (cdemp, cdpro),
foreign key (cdemp) references Empleado(cdemp) on update cascade on delete cascade,
foreign key (cdpro) references Proyecto(cdpro) on update cascade on delete cascade
)engine=InnoDB;

Insert into Departamento values
('01', "Contabilidad-1", "Almería"),
('02', "Ventas", "Almería"),
('03', "I+D", "Málaga"),
('04', "Gerencia", "Córdoba"),
('05', "Administración", "Córdoba"),
('06', "Contabilidad-2", "Córdoba");

insert into Empleado values
('A11', "Esperanza Amarillo", '1993-09-23', null, '04'),
('A03', "Pedro Rojo", '1995-03-07', 'A11', '01'),
('A07', "Elena Blanco", '1994-04-09', 'A11', '02'),
('B09', "Pablo Verde", '1998-10-12', 'A11', '03'),
('A10', "Dolores Blanco", '1998-11-15', 'A11', '04'),
('B12', "Juan Negro", '1997-02-03', 'A11', '05'),
('A13', "Jesús Marrón", '1999-02-21', 'A11', '05'),
('A14', "Manuel Amarillo", '2000-09-01', 'A11', null),
('C01', "Juan Rojo", '1997-02-03', 'A03', '01'),
('B02', "María Azul", '1996-01-09', 'A03', '01'),
('C04', "Ana Verde", null, 'A07', '02'),
('B06', "Carmen Violeta", '1997-02-03', 'A07', '02'),
('C05', "Alfonso Amarillo", '1998-12-03', 'B06', '02'),
('C08', "Javier Naranja", null, 'B09', '03');

insert into Proyecto values
('GRE', "Gestión residuos", '03'),
('DAG', "Depuración de aguas", '03'),
('AEE', "Análisis económico energías", '04'),
('MES', "Marketing de energía solar", '02');

insert into Trabaja values
('C01', 'GRE', 10),
('C08', 'GRE', 54),
('C01', 'DAG', 5),
('C08', 'DAG', 150),
('B09', 'DAG', 100),
('A14', 'DAG', 10),
('A11', 'AEE', 15),
('C04', 'AEE', 20),
('A11', 'MES', 0),
('A03', 'MES', 0);

/*1. Nombre de los empleados que han trabajado más de 50 horas en proyectos.*/
select e.nombre, t.nhoras, t.cdpro
from Empleado e
inner join Trabaja t
on e.cdemp=t.cdemp
where nhoras>='50';

/*2.Nombre de los departamentos que tienen empleados con apellido “Verde”.*/
select d.nombre, e.nombre
from Departamento d
inner join Empleado e
on d.cddep=e.cddep
where e.nombre like ('%Verde%');

/*3.Nombre de los proyectos en los que trabajan más de dos empleados*/
select p.nombre, count(t.cdemp) as 'nºtrabajadores'
from Proyecto p
inner join Trabaja t
on p.cdpro=t.cdpro
inner join Empleado e
on e.cdemp=t.cdemp
group by t.cdpro
having count(t.cdemp)>2;

/*4.Lista de los empleados y el departamento al que pertenecen, con indicación del dinero total que
deben percibir, a razón de 35 euros la hora. La lista se presentará ordenada por orden alfabético
de nombre de empleado, y en caso de que no pertenezcan a ningún departamento (NULL) debe
aparecer la palabra “DESCONOCIDO”.*/
select e.nombre as 'Empleado', ifnull(d.nombre, 'DESCONOCIDO') as 'Departamento', (t.nhoras*35) as 'Dinero'
from Empleado e
left join Departamento d
on d.cddep=e.cddep
inner join Trabaja t
on e.cdemp=t.cdemp
order by e.nombre;

/*5.Lista de los nombres de todos los empleados, y el número de proyectos en los que está
trabajando (ten en cuenta que algunos empleados no trabajan en ningúb proyecto).*/
select e.nombre as 'Empleado', count(t.cdpro) as 'nºProyectos'
from Empleado e
left join Trabaja t
on e.cdemp=t.cdemp
group by e.cdemp;

/*6. Lista de empleados que trabajan en Málaga o en Almería.*/
select e.*
from Empleado e
inner join Departamento d
on e.cddep=d.cddep
where ciudad in ('Málaga', 'Almería');

/*7.Lista alfabética de los nombres de empleado y los nombres de sus jefes. Si el empleado no tiene
jefe debe aparecer la cadena “Sin Jefe”.*/
select Empleado.nombre, ifnull(jefe.nombre, 'Sin jefe') as 'Jefe'
from Empleado
left join Empleado as jefe
on Empleado.cdjefe = jefe.cdemp
order by nombre;

/*8. Fechas de ingreso mínima. y máxima, por cada departamento.*/
select min(fecha_ingreso), max(fecha_ingreso), d.nombre
from Empleado e
right join Departamento d
on e.cddep=d.cddep
group by d.cddep;

/*9. Nombres de empleados que trabajan en el mismo departamento que Carmen Violeta.*/
select e.nombre, ciudad
from Empleado e
inner join Departamento d
on e.cddep=d.cddep
where ciudad=(select ciudad
				from Departamento d, Empleado e
				where e.cddep=d.cddep and e.nombre like 'Carmen Violeta')
and e.nombre <>'Carmen Violeta';

/*10. Media del año de ingreso en la empresa de los empleados que trabajan en algún proyecto.*/
/*round redondea*/
select round(avg(year(fecha_ingreso))) as 'Media Ingreso' , cdpro as 'Proyecto'
from Empleado e
inner join Trabaja t
on e.cdemp=t.cdemp
group by cdpro;

/*11. Nombre de los empleados que tienen de apellido Verde o Rojo, y simultáneamente su jefa es 
Esperanza Amarillo.*/
select nombre, cdemp, cdjefe
from Empleado 
where (nombre like '%Verde' or nombre like '%Rojo')
and cdjefe=(select e.cdemp
			from Empleado e
			where e.nombre like ('Esperanza Amarillo'));
            
select distinct e.nombre
from Empleado as e, Empleado as jefe
where e.cdjefe=jefe.cdemp
and (e.nombre like '%Verde%' or e.nombre like '%Rojo%')
and jefe.nombre like 'Esperanza Amarillo';
          
/*12. Suponiendo que la letra que forma parte del código de empleado es la categoría laboral, listar los
empleados de categoría B que trabajan en algún proyecto.*/
select e.*
from Empleado e
inner join Trabaja t
on e.cdemp=t.cdemp
where t.cdemp like ('B%');

/*13. Listado de nombres de departamento, ciudad del departamento y número de empleados del
departamento. Ordenada por nombre de ciudad y a igualdad de esta por el nombre del
departamento.*/
select d.nombre, ciudad, count(cdemp) as 'nºempleados'
from Departamento d
left join Empleado e
on d.cddep=e.cddep
group by d.cddep
order by ciudad, d.nombre;

/*14. Lista de nombres de proyecto y suma de horas trabajadas en él, de los proyectos en los que se ha
trabajado más horas de la media de horas trabajadas en todos los proyectos.*/
select p.nombre, sum(nhoras)
from Proyecto p
right join Trabaja t
on p.cdpro=t.cdpro
group by t.cdpro
having sum(nhoras)>=(select avg(nhoras)
					from Trabaja);

/*15. Nombre de proyecto y horas trabajadas, del proyecto en el que más horas se ha trabajado.*/
select p.nombre, sum(nhoras)
from Proyecto p
right join Trabaja t
on p.cdpro=t.cdpro
group by t.cdpro
having sum(nhoras)=(select sum(nhoras)
					from Trabaja
                    group by cdpro
                    order by 1 desc limit 1);

/*16. Lista de nombres de empleado que hayan trabajado entre 15 y 100 horas, entre todos los
proyectos en los que trabajan.*/
select e.nombre, sum(nhoras) as 'nºhoras'
from Empleado e
inner join Trabaja t
on e.cdemp=t.cdemp
group by t.cdemp
having sum(nhoras) between 15 and 100;

/*17. Lista de empleados que no son jefes de ningún otro empleado.*/
select e.*
from Empleado e
where cdemp not in (select cdjefe
				from Empleado
                where cdjefe is not null);
                
/*18. Se quiere premiar a los empleados del departamento que mejor productividad tenga. Para ello se
decide que una medida de la productividad puede ser el número de horas trabajadas por
empleados del departamento en proyectos, dividida por los empleados de ese departamento.
¿Qué departamento es el más productivo?*/
select p.*, sum(nhoras)/count(cdemp) as 'Productividad'
from Trabaja t
inner join Proyecto p
on t.cdpro=p.cdpro
group by t.cdpro
having sum(nhoras)/count(cdemp)=(select sum(nhoras)/count(cdemp)
										from Trabaja
                                        group by cdpro
                                        order by 1 desc limit 1);


/*19. Lista donde aparezcan los nombres de empleados, nombres de sus departamentos y nombres de
proyectos en los que trabajan. Los empleados sin departamento, o que no trabajen en proyectos
aparecerán en la lista y en lugar del departamento o el proyecto aparecerá “*****”.*/
select e.cdemp, e.nombre, ifnull(d.nombre, '*****') as 'Departamento', ifnull(p.nombre, '*****') as 'Proyecto'
from Empleado e
left join Trabaja t
on t.cdemp=e.cdemp 
left join Departamento d
on e.cddep=d.cddep
left join Proyecto p
on p.cddep=d.cddep and t.cdpro=p.cdpro;

/*20. Lista de los empleados indicando el número de días que llevan trabajando en la empresa.*/
select cdemp, nombre, ifnull(datediff(now(), fecha_ingreso), 'no ha trabajado') as 'Dias'
from Empleado;
 
/*21. Número de proyectos en los que trabajan empleados de la ciudad de Córdoba.*/
select count(p.cdpro) as 'nºProyectos'
from Proyecto p
inner join Departamento d
on d.cddep=p.cddep
inner join Trabaja t
on t.cdpro=p.cdpro
where nhoras <>0 and ciudad like 'Córdoba';

/*22. Lista de los empleados que son jefes de más de un empleado, junto con el número de empleados
que están a su cargo.*/
select jefe.nombre, count(e.cdemp) as 'nºEmpleados'
from Empleado e
inner join Empleado as jefe
on e.cdjefe=jefe.cdemp
group by e.cdjefe
having count(e.cdemp)>1;

/*23. Listado que indique años y número de empleados contratados cada año, todo ordenado por orden
ascendente de año.*/
select year(fecha_ingreso) as 'Ingreso', count(cdemp) as 'nºEmpleados'
from Empleado
group by year(fecha_ingreso)
order by year(fecha_ingreso) asc;

/*24. Listar los nombres de proyectos en los que aparezca la palabra “energía”, indicando también el
nombre del departamento que lo gestiona.*/
select p.nombre, d.nombre
from Proyecto p
inner join Departamento d
on p.cddep=d.cddep
where p.nombre like '%energía%';

/*25. Lista de departamentos que están en la misma ciudad que el departamento “Gerencia”.*/
select *
from Departamento
where ciudad = (select ciudad
				from Departamento
				where nombre like 'Gerencia');

/*26. Lista de departamentos donde exista algún trabajador con apellido “Amarillo”.*/
select d.*, e.nombre
from Departamento d
inner join Empleado e
on e.cddep=d.cddep
where e.nombre like '%Amarillo%';

/*27. Lista de los nombres de proyecto y departamento que los gestiona, de los proyectos que tienen 0
horas de trabajo realizadas.*/
select p.nombre, d.nombre
from Departamento d
inner join Proyecto p
on p.cddep=d.cddep
inner join Trabaja t
on t.cdpro=p.cdpro
where nhoras=0;

/*28. Asignar el empleado “Manuel Amarillo” al departamento “05”*/
update Empleado
set cddep='05'
where nombre like 'Manuel Amarillo';

select * from Empleado;

/*29. Borrar los departamentos que no tienen empleados.*/
Delete from Departamento where cddep not in(select distinct cddep
											from Empleado);

select * from Departamento;

/*30. Añadir todos los empleados del departamento 02 al proyecto MES.*/
insert into Trabaja(cdemp, cdpro)
select cdemp, 'MES'
from Empleado
where cddep='02';

select * from Trabaja order by cdpro;