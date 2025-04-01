create database if not exists Games;
use Games;
create table if not exists Juego(
id_juego int not null auto_increment,
nombre_juego varchar(255) default null,
primary key (id_juego)
)Engine=InnoDB;

create table if not exists Usuario(
id_usuario int not null,
username varchar(255) default null,
primary key (id_usuario)
) Engine=InnoDB;

create table if not exists juegoyusuario(
id_usuario int not null,
id_juego int not null auto_increment,
primary key (id_usuario, id_juego),
foreign key (id_usuario) references Usuario(id_usuario) on delete cascade on update cascade,
foreign key (id_juego) references Juego(id_juego) on delete cascade on update cascade
)Engine=InnoDB;

Insert into Usuario values 
(1, "vichaunter"),
(2, "pepito"),
(3, "jaimito"),
(4, "ataulfo");

Insert into Juego (nombre_juego) values 
("Final Fantasy VII"),
("Zelda: A link to the past"),
("Crazy Taxy"),
("Donkey Kong Country"),
("Fallout 4"),
("Saints Row III"),
("La taba");

Insert into juegoyusuario values
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 6),
(1, 7),
(2, 3),
(2, 7),
(4, 1),
(4, 2),
(4, 4),
(4, 7);

/*A) Cuántos juegos tiene asignados cada usuario*/
select u.id_usuario, username, count(id_juego) as 'nºJuegos'
from Usuario u
left join juegoyusuario j
on u.id_usuario=j.id_usuario
group by u.id_usuario;

/*B) Queremos saber todos los juegos que tenemos, y a qué usuarios pertenecen*/
select ju.id_juego, j.id_usuario, ju.nombre_juego
from juegoyusuario j
right join Juego ju
on ju.id_juego=j.id_juego;

select ju.nombre_juego , username
from juegoyusuario j
right join Juego ju
on ju.id_juego=j.id_juego
left join Usuario u
on u.id_usuario=j.id_usuario;

/*C) Mostrar todos los usuarios que tienen asignados al menos un juego.*/
select u.*, count(j.id_juego) as 'nºJuegos'
from Usuario u
inner join juegoyusuario j
on u.id_usuario=j.id_usuario
group by j.id_usuario
having count(j.id_juego)>=1