drop database if EXISTS bdfutbol;
create database IF NOT EXISTS bdfutbol;
use bdfutbol;
/*Creacion de base de datos */
drop table if EXISTS  ligas;
create table if not EXISTS ligas(
    codLiga char(5),
    nomLiga varchar(50),
    PRIMARY KEY(codLiga)
);
drop table if EXISTS  equipos;
create table  if not exists equipos (
    cod_equipo int AUTO_INCREMENT,
    nom_equipo varchar (40), 
    cod_liga char(5) DEFAULT ('pdn'),
    localidad varchar(60),
    internacional tinyint(1) DEFAULT 0,
    PRIMARY KEY (cod_equipo),
    /* index pk_cod_equipo (cod_equipo),  no es necesario o si yo que se*/
    FOREIGN key fk_codligaLigas (cod_liga) REFERENCES ligas(codLiga) 
    on delete CASCADE 
    on update CASCADE 
);
DROP table if EXISTS  futbolistas;
create table if NOT EXISTS futbolistas (
    cod_dni_nie char (9),
    nombre varchar(50),
    nacionalidad varchar(40),
    PRIMARY KEY (cod_dni_nie)
);
DROP table if EXISTS  contratos;
create table IF NOT EXISTS contratos (
    cod_contrato int AUTO_INCREMENT,
    dni_nie char(9),
    cod_equipo int,
    fecha_inicio date,
    fecha_fin date,
    precio_anual int,
    precio_recision int,
    PRIMARY KEY (cod_contrato),
    FOREIGN KEY fk_dniFutbolistas (dni_nie) 
    REFERENCES futbolistas(cod_dni_nie)
    on update CASCADE
    on delete CASCADE,
    FOREIGN KEY fk_codequipoEquipos (cod_equipo) 
    REFERENCES equipos(cod_equipo)
    ON UPDATE CASCADE 
    ON DELETE CASCADE 
);

/*fin creacion base de datos*/
/*inserciones*/
/*Inserciones ligas */
insert into bdfutbol.ligas (codLiga, nomLiga)
    values ('pdn','liga del pdn');

insert into bdfutbol.ligas (codLiga, nomLiga)
    values ('tdp','liga del tdp');

insert into bdfutbol.ligas (codLiga, nomLiga )
    values ('cgh','liga del cgh'   );
/*Fin insert ligas*/
/*Inserciones equipos*/
insert INTO bdfutbol.equipos (cod_equipo,nom_equipo,cod_liga,localidad,internacional)
    values (null,'los duros','pdn','duro landia',0 );

insert INTO bdfutbol.equipos (cod_equipo,nom_equipo,cod_liga,localidad,internacional)
    values (null,'los grandes','tdp','el olimpo',1 );

insert INTO bdfutbol.equipos (cod_equipo,nom_equipo,cod_liga,localidad,internacional)
    values (null,'los inutiles','cgh','a la izquierda',0 );
/*fin inserciones equipo*/
/*Inserciones futbolistas*/
insert into bdfutbol.futbolistas (cod_dni_nie,nombre,nacionalidad)
    values ('45984461p','benito','ESP');

insert into bdfutbol.futbolistas (cod_dni_nie,nombre,nacionalidad)
    values ('45984451p','ramon','ESP');

insert into bdfutbol.futbolistas (cod_dni_nie,nombre,nacionalidad)
    values ('43333331p','vladimir','RUS');

insert into bdfutbol.futbolistas (cod_dni_nie,nombre,nacionalidad)
    values ('43333332p','dimitri ','RUS');

insert into bdfutbol.futbolistas (cod_dni_nie,nombre,nacionalidad)
    values ('66666661p','keni','GER');

insert into bdfutbol.futbolistas (cod_dni_nie,nombre,nacionalidad)
    values ('66666662p','cartman','GER');

/*fin inserciones futbolistas*/
/*Inserciones contratos*/

insert into bdfutbol.contratos (cod_contrato,dni_nie,cod_equipo,fecha_inicio,fecha_fin,precio_anual,precio_recision)
    values (null,
    (select cod_dni_nie from bdfutbol.futbolistas where nombre='benito'),
    (select cod_equipo from equipos where cod_liga='pdn'),
    (select curdate()),
    '2030-11-28',
    5000,
    20000);

insert into bdfutbol.contratos (cod_contrato,dni_nie,cod_equipo,fecha_inicio,fecha_fin,precio_anual,precio_recision)
    values (null,
    (select cod_dni_nie from bdfutbol.futbolistas where nombre='ramon'),
    (select cod_equipo from equipos where cod_liga='pdn'),
    (select curdate()),
    '2030-11-28',
    5500,
    21000);

insert into bdfutbol.contratos (cod_contrato,dni_nie,cod_equipo,fecha_inicio,fecha_fin,precio_anual,precio_recision)
    values (null,
    (select cod_dni_nie from bdfutbol.futbolistas where nombre='vladimir'),
    (select cod_equipo from equipos where cod_liga='tdp'),
    (select curdate()-10),
    '2030-11-28',
    30000,
    50000);


insert into bdfutbol.contratos (cod_contrato,dni_nie,cod_equipo,fecha_inicio,fecha_fin,precio_anual,precio_recision)
    values (null,
    (select cod_dni_nie from bdfutbol.futbolistas where nombre='dimitri'),
    (select cod_equipo from equipos where cod_liga='tdp'),
    (select curdate()-10),
    '2030-11-28',
    40000,
    90000);

insert into bdfutbol.contratos (cod_contrato,dni_nie,cod_equipo,fecha_inicio,fecha_fin,precio_anual,precio_recision)
    values (null,
    (select cod_dni_nie from bdfutbol.futbolistas where nombre='keni'),
    (select cod_equipo from equipos where cod_liga='cgh'),
    (select curdate()-20),
    '2030-11-28',
    900000,
    1000000);

insert into bdfutbol.contratos (cod_contrato,dni_nie,cod_equipo,fecha_inicio,fecha_fin,precio_anual,precio_recision)
    values (null,
    (select cod_dni_nie from bdfutbol.futbolistas where nombre='cartman'),
    (select cod_equipo from equipos where cod_liga='cgh'),
    (select curdate()-20),
    '2030-11-28',
    100,
    200);

/*fin inserciones contratos*/
/*fin inserciones*/


/* Crear un procedimiento almacenado que liste todos los contratos de cierto futbolista pasando por
parámetro de entrada el dni o nie del futbolista, ordenados por fecha de inicio.
Los datos a visualizar serán: Código de contrato, nombre de equipo, nombre de liga, fecha de inicio,
fecha de fin, precio anual y precio de recisión del contrato. 
 */
DELIMITER //
    create PROCEDURE if not EXISTS   bdfutbol.proc_contractos_dni (in dni_in char(9))
        begin
        select 
            cod_contrato,
            nom_equipo,
            nomLiga,
            fecha_inicio,
            fecha_fin,
            precio_anual,
            precio_recision
        from 
            contratos
        INNER JOIN 
            equipos
        ON 
            contratos.cod_equipo=equipos.cod_equipo
        INNER JOIN 
            ligas
        ON  
            equipos.cod_liga=ligas.codLiga
        where contratos.dni_nie=dni_in
        ORDER BY contratos.fecha_inicio;
        end //
DELIMITER ;
/*Crear un procedimiento almacenado que inserte un equipo, de modo que se le pase como parámetros
todos los datos.
Comprobar que el código de liga pasado exista en la tabla ligas. En caso de que no exista la liga que
no se inserte.
Devolver en un parámetro de salida: 0 si la liga no existe y 1 si la liga existe.
 Devolver en otro parámetro de salida: 0 si el equipo no se insertó y 1 si la inserción fue
correcta. 
 */
DELIMITER //
    create procedure bdfutbol.insertar_equipo (in _nomEquipo varchar(40), in _codLiga char(5),
        in _localidad varchar(60),in _internacional tinyint, out resultadoL TINYINT(1),out resultadoI TINYINT(1)    )
        BEGIN
           set @contadorInicial = (select COUNT(*) FROM equipos);
            set resultadoL=(SELECT if (EXISTS (select codLiga from ligas where codLiga=_codLiga),1,0));

            
            if resultadoL>=1 THEN 
            	BEGIN
            	        INSERT INTO bdfutbol.equipos values (null,_nomEquipo,_codliga,_localidad,_internacional);
                        if @contadorInicial<(select COUNT(*) from equipos) 
                                then 
                                        set resultadoI=1;
                        else 
                                        set resultadoI=0;
                        end if;
     		
            	END;
       	    END IF;
        END //
DELIMITER ;

/*  Crear un procedimiento almacenado que indicándole un equipo, precio anual y un precio recisión,
devuelva dos parámetros. En un parámetro de salida la cantidad de futbolistas en activo (con contrato
vigente) que hay en dicho equipo. En otro parámetro de salida la cantidad de futbolistas en activo de
dicho equipo con precio anual y de recisión menor de los indicados. */
DELIMITER //
create PROCEDURE  bdfutbol.futbolistasActivo (in _cod_equipo int, in _precio_anual int, 
        in _precio_recision int , out _fblts_activo int, out _fblts_pa_rc_menor int)
        BEGIN
            SET _fblts_activo = (
                SELECT  COUNT(*) 
                FROM contratos
                INNER JOIN equipos
                ON  contratos.cod_equipo=_cod_equipo
                where contratos.fecha_fin > contratos.fecha_inicio );
            
            SET _fblts_pa_rc_menor = (
                SELECT  COUNT(*)
                FROM contratos
                INNER JOIN  equipos
                ON contratos.cod_equipo=_cod_equipo
                WHERE contratos.precio_anual<_precio_anual
                AND contratos.precio_recision<_precio_recision
            );

        END //
DELIMITER ; 
/* Crear una función que dándole un dni o nie de un futbolista nos devuelva en número de meses total
que ha estado en equipos. */
DELIMITER //
create FUNCTION  bdfutbol.dni_meses_en_equipo (_dni char(9))
    RETURNS  INT
        BEGIN 
            declare valorRetornado int ;
            set valorRetornado = (select TIMESTAMPDIFF(month,contratos.fecha_inicio,contratos.fecha_fin) 
                FROM contratos
                WHERE  dni_nie=_dni 
                );
            RETURN  valorRetornado;
        END //
DELIMITER ; 
/* Hacer un Trigger que en la tabla contratos al insertar o modificar el precio de recisión no permita
que sea menor que el precio anual.*/
DELIMITER //
create procedure bdfutbol_auxiliar_trigger (in _precioRecision int, in _precioAnual int, out resultado int)
    BEGIN
        if _precioRecision>_precioAnual then
            set resultado=1;
        else
            SET  resultado=0;
        END IF;
    END // 

DELIMITER ;
DELIMITER //

CREATE  TRIGGER trig_contratos_precio_anual 
    BEFORE 
    INSERT on contratos
    FOR EACH ROW 
    BEGIN
        declare comparador tinyint(1);
        call bdfutbol_auxiliar_trigger(new.precio_recision,new.precio_anual,@resultado);
        select @resultado into comparador;
        if comparador = 0 then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'precio recision no puede ser menor que precio anual';
        END  IF; 
    END //

DELIMITER ;

DELIMITER //

CREATE  TRIGGER trig_contratos_precio_anual_update 
    BEFORE 
    UPDATE  on contratos
    FOR EACH ROW 
    BEGIN
        declare comparador tinyint(1);
        call bdfutbol_auxiliar_trigger(new.precio_recision,new.precio_anual,@resultado);
        select @resultado into comparador;
        if comparador = 0 then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'precio recision no puede ser menor que precio anual';
        END  IF; 
    END //

DELIMITER ;
/* Hacer un Trigger que si en la tabla contratos que al insertar o modificar ponemos la fecha inicio
posterior a la fecha fin que las intercambie. 
*/
DELIMITER //
create TRIGGER trig_fechaInicio_fechafin 
    BEFORE
    INSERT  on contratos
    FOR EACH ROW
    BEGIN  
        if new.fecha_inicio>new.fecha_fin then
         BEGIN
            declare fecha_comienzo date;
            declare fecha_final date;
            set fecha_comienzo=new.fecha_fin;
            set fecha_final=new.fecha_inicio; 
            SET new.fecha_fin=fecha_final;
            set new.fecha_inicio=fecha_comienzo;
         END; 
        END IF;
    END //
DELIMITER ;

DELIMITER //
create TRIGGER trig_fechaInicio_fechafin_update /*cambiar  mal tambien*/
    BEFORE  
    UPDATE on contratos
    FOR EACH ROW
    BEGIN  
        if new.fecha_inicio>new.fecha_fin then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'la fecha de inicio no puede ser superior a la fecha fin'; 
        END IF;   
    END //
DELIMITER ;
/* update new set new.fecha_inicio=old.fecha_inicio,new.fecha_fin=old.fecha_fin; */
/* Hacer un Trigger que no permita eliminar ninguna liga. */
DELIMITER //
create TRIGGER  trig_protec_ligas
    BEFORE 
    DELETE  on ligas
    FOR EACH ROW
    BEGIN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'no puedes borrar ninguna liga';
    END // 
DELIMITER ;