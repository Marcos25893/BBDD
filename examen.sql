create database if not exists examenMarcos;
use examenMarcos;

create table if not exists Usuario(
id_user char(3),
nom_user varchar(25),
email_user varchar(50),
telefono_user varchar(9),
primary key (id_user)
)Engine=InnoDB;

create table if not exists Region(
id_reg char(2),
nom_reg varchar(25),
primary key (id_reg)
)Engine=InnoDB;

create table if not exists Ciudad(
codigo_postal char(5),
nom_ciudad varchar(25),
id_reg char(2),
primary key (codigo_postal),
foreign key (id_reg) references Region (id_reg) on delete cascade on update cascade
)Engine=InnoDB;

create table if not exists Hoteles(
id_hotel char(3),
nom_hotel varchar(25),
habitaciones int,
categoria varchar(5),
codigo_postal char(5),
primary key (id_hotel)
)engine=InnoDB;

create table if not exists Reservas(
id_user char(3),
id_hotel char(3),
fecha_llegada date,
fecha_salida date,
costo double,
primary key (id_user, id_hotel),
foreign key (id_user) references Usuario(id_user) on delete cascade on update cascade,
foreign key (id_hotel) references Hoteles(id_hotel) on delete cascade on update cascade
)Engine=InnoDB;

create table if not exists Empleado(
id_emp char(3),
nom_emp varchar(25),
salario double,
id_hotel char(3),
primary key (id_emp),
foreign key (id_hotel) references Hoteles(id_hotel) on delete cascade on update cascade
)Engine=InnoDB;

insert into Usuario values
('U01', 'PEDRO PÉREZ', 'pedro@example.com', '654321987'),
('U02', 'MARÍA MARTÍNEZ', 'maria@example.com', '612345678'),
('U03', 'LUIS FERNÁNDEZ', 'luis@example.com', '687654321'),
('U04', 'ANA LÓPEZ', 'ana@example.com', '699876543'),
('U05', 'JUAN GARCÍA', 'juan@example.com', '623456789'),
('U06', 'SARA TORRES', 'sara@example.com', '655432198'),
('U07', 'CARLOS RODRÍGUEZ', 'carlos@example.com', '661234567'),
('U08', 'LAURA FERRER', 'laura@example.com', '677654321'),
('U09', 'PABLO HERNÁNDEZ', 'pablo@example.com', '690987654'),
('U10', 'NATALIA PASCUAL', 'natalia@example.com', '645678321');

insert into Region values
('01', 'MADRID'),
('02', 'BARCELONA'),
('03', 'SEVILLA'),
('04', 'VALENCIA');

insert into Ciudad values
('28001', 'MADRID', '01'),
('28002', 'MADRID', '01'),
('08001', 'BARCELONA', '02'),
('08002', 'BARCELONA', '02'),
('41001', 'SEVILLA', '03'),
('46001', 'VALENCIA', '04');

insert into Hoteles values
('H01', 'HOTEL CASTILLA', 150, '****', '28001'),
('H02', 'HOTEL CATALUNYA', 200, '***', '08001'),
('H03', 'HOTEL SEVILLANO', 120, '*****', '41001'),
('H04', 'HOTEL MEDITERRÁNEO', 180, '***', '46001'),
('H05', 'HOTEL ANDALUCÍA', 100, '***', '41001'),
('H06', 'HOTEL SOL', 250, '*****', '08002'),
('H07', 'HOTEL DELUXE', 50, '*****', '28002');

insert into Reservas values
('U01', 'H01', '2024/05/01', '2024/05/05', 500),
('U02', 'H01', '2024/06/10', '2024/06/15', 600),
('U03', 'H02', '2024/07/01', '2024/07/05', 450),
('U04', 'H03', '2024/08/15', '2024/08/20', 900),
('U05', 'H03', '2024/09/10', '2024/09/12', 850),
('U06', 'H04', '2024/10/05', '2024/10/08', 300),
('U07', 'H05', '2024/11/12', '2024/11/15', 400),
('U08', 'H06', '2024/12/01', '2024/12/05', 1000),
('U09', 'H07', '2024/12/10', '2024/12/12', 1500),
('U10', 'H06', '2025/01/15', '2025/01/20', 1200),
('U03', 'H03', '2025/02/10', '2025/02/15', 750),
('U04', 'H02', '2025/03/01', '2025/03/06', 550),
('U05', 'H01', '2025/04/20', '2025/04/25', 620),
('U06', 'H02', '2025/05/10', '2025/05/15', 700),
('U07', 'H03', '2025/06/20', '2025/06/25', 650),
('U08', 'H05', '2025/07/01', '2025/07/05', 550);

insert into Empleado values
('E01', 'ANDRÉS TORRES', 1400, 'H01'),
('E02', 'BEATRIZ ROJAS', 1300, 'H02'),
('E03', 'CARLOS FERNÁNDEZ', 1100, 'H03'),
('E04', 'DIANA LÓPEZ', 1250, 'H04'),
('E05', 'EDUARDO SÁNCHEZ', 1500, 'H05'),
('E06', 'FÁTIMA PÉREZ', 1600, 'H06'),
('E07', 'GABRIEL MARTÍN', 1200, 'H06'),
('E08', 'HUGO GONZÁLEZ', 1700, 'H07');

/*1.​ Nombre del hotel o de los hoteles con cinco estrellas que tienen mayor número
de habitaciones.*/
select nom_hotel, habitaciones
from Hoteles
where categoria like '*****' 
group by id_hotel
having habitaciones=(select habitaciones
						from Hoteles
                        where categoria like '*****' 
						group by id_hotel
                        order by 1 desc limit 1);
                        
select nom_hotel, habitaciones
from Hoteles
where categoria like '*****'
order by habitaciones desc limit 1;                        
                        
/*2.​ Datos de los empleados cuyo salario está entre 1200 y 1600 euros, ordenados de
mayor a menor salario.*/
select *
from Empleado
where salario between 1200 and 1600
order by salario desc;

/*3.​ Datos de los empleados cuyo salario es mayor que el salario medio de todos los
empleados.*/
select *
from Empleado
where salario>(select avg(salario)
				from Empleado);

/*4.​ Nombre de los usuarios que se han hospedado en la región de Barcelona.*/
select nom_user
from Usuario u, Region l, Reservas r, Hoteles h, Ciudad c
where u.id_user=r.id_user and r.id_hotel=h.id_hotel
and h.codigo_postal=c.codigo_postal and c.id_reg=l.id_reg
and nom_reg like 'BARCELONA';

/*5.​ Nombre de los usuarios y dinero total gastado en alojarse cada uno de ellos.*/
select nom_user, sum(costo)
from Usuario u, Reservas r
where u.id_user=r.id_user
group by r.id_user;

/*6.​ Nombre de los hoteles y fechas en que se ha hospedado el usuario PEDRO
PÉREZ, ordenados por nombre del hotel.*/
select nom_user, nom_hotel, fecha_llegada, fecha_salida
from Hoteles h, Reservas r, Usuario u
where h.id_hotel=r.id_hotel and r.id_user=u.id_user
and nom_user like 'PEDRO PÉREZ'
order by nom_hotel;

/*7.​ Datos del usuario que ha visitado más hoteles.*/
select count(id_hotel) as 'veces', u.*
from Usuario u, Reservas r
where u.id_user=r.id_user
group by r.id_user
having count(id_hotel)=(select count(id_hotel)
						from Reservas
                        group by id_user
						order by 1 desc limit 1); 

/*8.​ Listado de hoteles con el nombre del hotel y el dinero ganado en los hospedajes,
ordenados por nombre del hotel.*/
select nom_hotel, sum(costo) as 'dinero ganado'
from Hoteles h, Reservas r
where h.id_hotel=r.id_hotel
group by r.id_hotel
order by nom_hotel;

/*9.​ Nombre del empleado y nombre del hotel donde trabaja el empleado con mayor
salario.*/
select nom_emp, nom_hotel, max(salario)
from Empleado e, Hoteles h
where e.id_hotel=h.id_hotel
group by id_emp
having max(salario)=(select max(salario)
					from Empleado
                    group by id_emp
                    order by 1 desc limit 1);

/*10.​Nombre del hotel con mayor número de empleados.*/
select nom_hotel, count(id_emp)
from Hoteles h, Empleado e
where e.id_hotel=h.id_hotel
group by e.id_hotel
having count(id_emp)=(select count(id_emp)
					from Empleado
					group by id_hotel
                    order by 1 desc limit 1);

/*11.​Nombre de la región con menor número de hoteles.*/
select nom_reg, count(id_hotel)
from Region r, Hoteles h, Ciudad c
where h.codigo_postal=c.codigo_postal
and c.id_reg=r.id_reg
group by c.id_reg
having count(id_hotel)=(select count(id_hotel)
						from Region r, Hoteles h, Ciudad c
						where h.codigo_postal=c.codigo_postal
						and c.id_reg=r.id_reg
						group by c.id_reg
                        order by 1 asc limit 1);

/*12.​Número de hoteles por cada región. Mostrar el nombre de la región y el número
de hoteles.*/
select count(id_hotel) as 'nºhoteles', nom_reg
from Region r, Hoteles h, Ciudad c
where h.codigo_postal=c.codigo_postal
and c.id_reg=r.id_reg
group by c.id_reg;

/*13.​Media del salario de los empleados por cada hotel. Mostrar el nombre del hotel y
la media del salario de sus empleados.*/
select nom_hotel, avg(salario)
from Hoteles h, Empleado e
where e.id_hotel=h.id_hotel
group by e.id_hotel;

/*14.​Actualiza la tabla empleados para incrementar el salario de los empleados de la
región de Madrid en un 10%.*/
update Empleado
set salario=salario*1.1
where id_hotel IN (select id_hotel
				from Hoteles h, Ciudad c, Region r
				where h.codigo_postal=c.codigo_postal
                and c.id_reg=r.id_reg and nom_reg like 'MADRID');
                
                select * from Empleado;

/*15.​Actualiza la tabla hoteles para incrementar las habitaciones del "Hotel
Mediterráneo" a 200.*/
update Hoteles
set habitaciones=habitaciones+200
where nom_hotel like 'HOTEL MEDITERRÁNEO';

/*16.​Borra a los empleados que trabajen en el "Hotel Castilla".*/
delete from Empleado where id_hotel in (select id_hotel from Hoteles where nom_hotel like 'HOTEL CASTILLA');
