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
create PROCEDURE bdfutbol.futbolistasActivo (in _cod_equipo int, in _precio_anual int, 
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
   

   





