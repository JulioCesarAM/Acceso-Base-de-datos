﻿/* CREACION BASE DATOS */

if DB_ID('bdFutbol') is not null
	drop DATABASE bdFutbol
	ELSE 
	create DATABASE bdFutbol

go
if DB_ID('bdFutbol') is not null
	use bdFutbol
go
create table ligas (
codLiga char(5) ,
nomLiga varchar(50),
CONSTRAINT pk_tablaLigas PRIMARY KEY (codLiga),
)
go
create table equipos(
codEquipo integer identity(1,1),
nomEquipo varchar(40),
codLiga char(5) DEFAULT 'PDN',
localidad varchar(60),
internacional tinyInt DEFAULT 0,
CONSTRAINT pk_tablaEquipos PRIMARY KEY (codEquipo),
CONSTRAINT fk_codLigaTablaLiga  FOREIGN KEY  (codLiga) REFERENCES ligas(codLiga),

)
go
create table futbolistas(
codDniNie char(9),
nombre varchar(50),
nacionalidad varchar(40),
CONSTRAINT pk_tablaFutbolistas PRIMARY KEY (codDniNie)
)
go
create table contratos(
codContrato integer identity(1,1),
codDniNie char(9),
codEquipo integer,
fechaInicio date,
fechaFin date,
precioAnual integer,
preciorecision integer,
CONSTRAINT pk_tablaContratos PRIMARY KEY (codContrato),
CONSTRAINT fk_codDnieNieFutbolistas FOREIGN KEY (codDniNie) REFERENCES futbolistas(codDniNie),
CONSTRAINT fk_codEquipoTablaEquipos FOREIGN KEY (codEquipo) REFERENCES equipos(codEquipo)

)
go
/*FIN CREACION BASE DATOS*/
/*iNSERCION DATOS*/
insert into ligas values ('ABCDE','la liga mas dura de tenerife')
insert into ligas values ('EDCBA','la liga mas blanda de tenerife')
go
insert into equipos values ('futbol club xD',
(SELECT ligas.codLiga from ligas where ligas.codLiga=(select equipos.codEquipo from equipos)),'santa cruz de las tal')
insert into equipos values ('futbol club DX','ABCDE','santa cruz de las tal')
go
insert into futbolistas values('123456789','el señor adolfo','aleman')
insert into futbolistas values('48888888p','el señor juanes','jamaica')
go
insert into contratos values('45984416p',(select codDniNIE from futbolistas),'2012/06/18 10:34:09 AM','2012/06/18 10:34:09 AM',50,20)
insert into contratos values('48888888p',12/12/12,24/24/24);
go

/*procedimientos*/
/*Crear un procedimiento almacenado que lis
te todos los contratos de cierto futbolista pasando por
parámetro de entrada el dni o nie del futbolista, ordenados por fecha de inicio.
Los datos a visualizar serán: Código de contrato, nombre de equipo, nombre de liga, fecha de inicio,
fecha de fin, precio anual y precio de recisión del contrato.
alter PROCEDURE bdFutbol_ontratosPorDni @codDniNie char(9) 
todos los datos.
Comprobar que el código de liga pasado exista en la tabla ligas. En caso de que no exista la liga que
no se inserte.
Devolver en un parámetro de salida: 0 si la liga no existe y 1 si la liga existe.
Devolver en otro parámetro de salida: 0 si el equipo no se insertó y 1 si la inserción fue
correcta.*/
devuelva dos parámetros. En un parámetro de salida la cantidad de futbolistas en activo (con contrato
vigente) que hay en dicho equipo. En otro parámetro de salida la cantidad de futbolistas en activo de
dicho equipo con precio anual y de recisión menor de los indicados*/
que ha estado en equipos. */
/**/
alter trigger insertarModificar 
	on contratos
	for insert,update
	as
	begin
		set nocount ON

		declare @preciorecision int

		declare @dosPosibilidades tinyint 

		declare @PrecioComparador int

		set @PrecioComparador=(select precioAnual from contratos)


		if Exists (select i.preciorecision from inserted I where i.preciorecision > i.precioAnual )
			set @dosPosibilidades=1;
		else
			set @dosPosibilidades=0;

		if (@dosPosibilidades=1)
			begin
				set IDENTITY_INSERT contratos on

				update contratos(codContrato,codDniNie,codEquipo,fechaInicio,fechaFin,precioAnual,preciorecision)
				set codContrato=inserted.codContrato,
				codDniNie=inserted.codDniNie,
				codEquipo=inserted.codEquipo,
				fechaInicio=inserted.fechaInicio,
				fechaFin=inserted.fechaFin,
				precioAnual=inserted.precioAnual,
				preciorecision=inserted.preciorecision
				from inserted;

				
			end
	end
go

/*Hacer un Trigger que si en la tabla contratos que al insertar o modificar ponemos la fecha inicio
posterior a la fecha fin que las intercambie.*/
alter trigger condicionFechaInicio 
	on contratos
	for insert,update
	AS
	begin
		declare @fechaInicioAux date
		declare @fechaFinAux date
		declare @codContrato char
		if exists (select c.fechainicio from inserted as c where  c.fechaInicio>c.fechaFin)
			begin
				set @fechaInicioAux=(select fechafin from inserted)
				set @fechafinAux=(select fechaInicio from inserted)
				update  contratos (fechaInicio,fechaFin) set contratos.fechaInicio=@fechaFinAux,contratos.fechaFin=@fechaFinAux 
			end				
	end
go

SET IDENTITY_INSERT contratos off
insert into contratos values( '123456789',20,'25/03/1999','26/04/2000',5,6)
insert into contratos values( '123454444',21,'25/03/3000','26/04/1990',7,8)



go



/* Hacer un Trigger que no permita eliminar ninguna liga. */