create database if not exists Biblioteca;
use Biblioteca;
create table if not exists Editorial(
claveEditorial smallint not null,
nombre varchar(60),
direccion varchar(60),
telefono varchar(15),
primary key(claveEditorial));

create table if not exists Libro(
claveLibro int not null,
titulo varchar(60),
idioma varchar(15),
formato varchar(15),
categoria char,
claveEditorial smallint,
primary key(claveLibro),
foreign key(claveEditorial) references Editorial(claveEditorial));

create table if not exists Tema(
claveTema smallint not null,
nombre varchar(40),
primary key(claveTema));

create table if not exists Autor(
claveAutor int not null,
nombre int not null,
primary key(claveAutor));

create table if not exists Ejemplar(
claveLibro int not null,
numeroOrden smallint,
edicion smallint,
ubicacion varchar(15),
primary key(claveLibro, numeroOrden),
foreign key(claveLibro) references Libro(claveLibro) on delete cascade on update cascade);

create table if not exists Socio(
claveSocio int not null,
nombre varchar(60),
direccion varchar(60),
telefono varchar(15),
categoria char,
primary key(claveSocio));

create table if not exists Prestamo(
claveSocio int not null,
claveLibro int not null,
numeroOrden smallint,
fechaPrestamo date,
fechaDevolucion date,
notas blob,
foreign key(claveSocio) references Socio(claveSocio) on delete cascade on update cascade,
foreign key(claveLibro) references Libro(claveLibro) on delete cascade on update cascade);

create table if not exists Trata_sobre(
claveLibro INT not null,
claveTema smallint not null,
foreign key(claveLibro) references Libro(claveLibro) on delete cascade on update cascade,
foreign key(claveTema) references Tema(claveTema) on delete cascade on update cascade);

create table if not exists Escrito_por(
claveLibro int not null,
claveAutor int not null,
foreign key(claveLibro) references Libro(claveLibro) on delete cascade on update cascade,
foreign key(claveAutor) references Autor(claveAutor) on delete cascade on update cascade);