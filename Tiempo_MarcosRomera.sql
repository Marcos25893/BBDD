create database if not exists tiempo;
use tiempo;
create table if not exists Estacion(
identificador mediumint unsigned not null,
latitud varchar(14),
longitud varchar(15),
altitud mediumint not null,
primary key(identificador));

create table if not exists Muestra(
identificadorEstacion mediumint unsigned not null,
fecha date,
temperaturaMinima tinyint,
temperaturaMaxima tinyint,
precipitaciones smallint unsigned,
humedadMinima tinyint unsigned,
humedadMaxima tinyint unsigned,
velocidadVientoMinima smallint unsigned,
velocidadVientoMaxima smallint unsigned,
primary key(identificadorEstacion),
foreign key(identificadorEstacion) references Estacion(identificador) on delete no action on update cascade);