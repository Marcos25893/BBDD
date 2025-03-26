create database Compra;
use Compra;

create table if not exists Cliente(
nif char(9),
nombre varchar(25) not null,
domicilio varchar(100),
tlf varchar(25),
ciudad varchar(50),
primary key (nif)
);

create table if not exists Producto(
codigo char(4),
descripcion varchar(100) not null,
precio float,
stock float,
minimo float,
check (precio>0),
primary key (codigo)
);

create table if not exists Factura(
numero int,
fecha date,
pagado bool,
totalPrecio float,
nif char(9),
primary key (numero),
foreign key (nif) references Cliente(nif) on delete cascade on update cascade
);

create table if not exists Detalle(
numero int,
codigo char(4),
unidades int,
primary key (numero, codigo),
foreign key (codigo) references Producto(codigo) on delete cascade on update cascade,
foreign key (numero) references Factura(numero) on delete cascade on update cascade
);

insert into Cliente values
('43434343A','DElGADO PEREZ MARISA','C/MIRAMAR 84 3ºA','925-200-967','TOLEDO'),
('51592939K','LOPEZ VAL SOLEDAD','C/PEZ,54 4ºC','915-829-394','MADRID'),
('51639989K','DELGADO ROBLES MIGUEL','C/OCA,54 5ºC','913-859-293','MADRID'),
('51664372R','GUTIRREZ PEREZ ROSA','C/CASTILLA,4 4ºA','919-592-932','MADRID');

insert into Producto Values
('CAJ1','CAJA DE HERRAMIENTAS DE PLASTICO',8.50,4.00,3),
('CAJ2','CAJA DE HERRAMIENTAS DE METAL',12.30,3.00,2),
('MAR1','MARTILLO PEQUEÑO',3.50,5,10),
('MAR2','MARTILLO GRANDE',6.50,12,10),
('TOR7','CAJA 100 TORNILLOS DEL 7',0.80,20,100),
('TOR8','CAJA 100 TORNILLOS DEL 9',0.80,25,100),
('TUE1','CAJA 100 TUERCAS DEL 7',0.50,40,100),
('TUE2','CAJA 100 TUERCAS DEL 9',0.50,54,100),
('TUE3','CAJA 100 TUERCAS DEL 12',0.50,60,100);

insert into Factura values
(5440,'2017-09-05',TRUE,345,'51664372R'),
(5441,'2017-09-06',FALSE,1000,'51592939K'),
(5442,'2017-09-07',FALSE,789,'43434343A'),
(5443,'2017-09-08',TRUE,123.78,'51639989K'),
(5444,'2017-09-09',TRUE,567,'51639989K'),
(5445,'2017-09-10',TRUE,100,'51592939K');

insert into Detalle values
(5440,'CAJ2',2),
(5440,'MAR1',1),
(5440,'TOR7',2),
(5440,'TOR8',2),
(5441,'CAJ1',1),
(5442,'CAJ1',1),
(5442,'MAR1',2),
(5443,'TOR7',1),
(5443,'TUE1',1),
(5444,'MAR2',1),
(5445,'TOR7',5),
(5445,'TOR8',5),
(5445,'TUE2',5),
(5445,'TUE3',5);
/*Ejercicio3*/
/*A) Mostrar todos los datos introducidos en cada una de las tablas*/
select * from Cliente;
select * from Producto;
select * from Factura;
select * from Detalle;
/*B) Reemplazar la ciudad del cliente con DNI 51664372R por Granada*/
UPDATE Cliente SET ciudad = 'Granada' WHERE nif = '51664372R';
/*C) Actualizar todos los precios de los productos con un aumento del 10%*/
UPDATE Producto
SET precio = precio * 1.10;
/*D) Aumentar el stock en 20 unidades para todos los productos y disminuir
el precio de los productos en un 30%*/
UPDATE Producto
SET stock = stock + 20, 
    precio = precio * 0.70;
/*E) A los productos en los que haya un mínimo de 100 unidades, hacerle un
descuento al precio del 50%*/    
UPDATE Producto
SET	precio = precio *0.5
where minimo >= 100;
/*F) Eliminar al cliente cuyo dni sea 51664372R*/
Delete FROM Cliente where nif='51664372R';
