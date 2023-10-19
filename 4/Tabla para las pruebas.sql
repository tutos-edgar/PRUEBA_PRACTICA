--- SE CREA LA TABLA PERSONA PAR LAS PRUEBAS DEL C#
--- DEVOLVER FILAS AFECTADAS EN INSERT, UPDATE Y DELETE
--- DEVOLVER CANTIDAD DE FILAS CON UN SELECT 
create table persona(
	id_persona int identity(1,1) primary key,
	documento varchar(20),
	nombre varchar(100),
	apellido varchar(100),
	telefono varchar(20)
)

insert into persona (documento, nombre, apellido, telefono) values('23', 'edgar', 'apellido', '2322');
insert into persona (documento, nombre, apellido, telefono) values('24', 'edy', 'ramirez', '2322');
insert into persona (documento, nombre, apellido, telefono) values('25', 'maria', 'apellido', '2322');
 
select * from persona

select count(1) from persona