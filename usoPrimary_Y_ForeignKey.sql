create database if not exists alumnos;
use alumnos;
create table if not exists localidad(
cpostal varchar(5) not null,
localidad varchar(35),
primary key(cpostal));
create table if not exists alumno(
codAlumno int auto_increment not null,
nombre varchar(35),
apellidos varchar(100),
codigopostal varchar(5), /*se puede poner otro nombre con respecto a la otra tabla pero hay que cambiarlo tambien en foreign key() y ponerlo bien en references*/
primary key (codAlumno),
foreign key(codigopostal) references localidad(cpostal) on update cascade on delete restrict
);