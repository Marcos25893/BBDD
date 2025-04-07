/*1. Creación de usuarios y otorgamiento de privilegios:
● Crea un nuevo usuario llamado 'usuario1' con contraseña 'contraseña1' y
otorga los privilegios SELECT y INSERT en todas las tablas de la base de
datos 'GESTIÓN DE PROYECTOS'.*/
CREATE USER 'usuario1'@'%' IDENTIFIED BY 'contraseña1';
GRANT select, insert ON Relacion6.* TO 'usuario1'@'%';/*Mi tabla se llama Relacion6*/

/*2. Revocación de privilegios:
● Revoca el privilegio de DELETE en todas las tablas de la base de datos
'GESTIÓN DE PROYECTOS' para el usuario 'usuario1'.*/
REVOKE delete ON Relacion6.* FROM 'usuario1'@'%';

/*3. Creación de usuarios con privilegios específicos:
● Crea un nuevo usuario llamado 'usuario2' con contraseña 'contraseña2' y
otorga únicamente el privilegio SELECT en la tabla 'empleado' de la base de
datos 'GESTIÓN DE PROYECTOS'.*/
CREATE USER 'usuario2'@'%' IDENTIFIED BY 'contraseña2';
GRANT select ON Relacion6.Empleado TO 'usuario2'@'%';

/*4. Creación de usuario con privilegios globales:
● Crea un nuevo usuario llamado 'usuario3' con contraseña 'contraseña3' y
otorga el privilegio de CREATE TABLESPACE a nivel global.*/
CREATE USER 'usuario3'@'%' IDENTIFIED BY 'contraseña3';
GRANT CREATE tablespace TO 'usuario3'@'%';/**/

/*5. Eliminación de usuarios:
● Elimina el usuario 'usuario2'.*/
DROP USER 'usuario2'@'%';

/*6. Modificación de usuarios:
● Cambia la contraseña del usuario 'usuario3' a 'nuevacontraseña'*/
ALTER USER 'usuario3'@'%' identified by 'nuevacontraseña';

/*7. Combinación de privilegios:
● Otorga al usuario 'usuario1' el privilegio de SELECT en la tabla
'EMPLEADO' y el privilegio de INSERT en la tabla 'TRABAJA’' de la base
de datos"GESTIÓN DE PROYECTOS''.*/
GRANT select on Relacion6.Empleado to 'usuario1'@'%';
GRANT insert on Relacion6.Trabaja to 'usuario1'@'%';

/*8. Revocación de todos los privilegios:
● Revoca todos los privilegios para el usuario 'usuario1'.*/
REVOKE USAGE ON *.* FROM 'usuario1'@'%';

/*9. Otorgamiento de privilegios a nivel de columna:
● Otorga al usuario 'usuario1' el privilegio de SELECT en la columna 'nombre'
de la tabla 'EMPLEADO' de la base de datos 'GESTIÓN DE PROYECTOS'*/
GRANT SELECT (nombre) ON Relacion6.Empleado TO 'usuario1'@'%';

/*10. Revocación de privilegios a nivel de columna:
● Revoca el privilegio de INSERT en la columna 'fecha_ingreso' de la tabla
'empleado' para el usuario 'usuario1'*/
revoke insert (fecha_ingreso) on Relacion6.Empleado FROM 'usuario1'@'%';

/*11. Creación de usuario con permisos de solo lectura a nivel global:
● Crea un nuevo usuario llamado 'lectorglobal' con contraseña 'contraseña4' y
otorga únicamente el privilegio SELECT a nivel global.*/
CREATE USER 'lectorglobal'@'%' IDENTIFIED BY 'contraseña4';
GRANT select TO 'lectorglobal'@'%';
/**/

/*12. Revocación de todos los privilegios a nivel global:
● Revoca todos los privilegios a nivel global para el usuario 'lectorglobal'*/
REVOKE USAGE ON *.* FROM 'lectorglobal'@'%';




