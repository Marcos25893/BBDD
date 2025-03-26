drop database if exists proveedores;
create database proveedores CHARSET utf8mb4;
use proveedores;

create table categoria (
id int unsigned auto_increment primary key,
nombre varchar(100) not null
);

create table pieza (
id int unsigned auto_increment primary key,
nombre varchar(100) not null,
color varchar(50) not null,
precio decimal(7,2) not null,
id_categoria int unsigned not null,
foreign key (id_categoria) references categoria(id)
on delete restrict
on update restrict
);

insert into categoria values
(1,'categoria1'),
(2,'categoria2'),
(3,'categoria3');