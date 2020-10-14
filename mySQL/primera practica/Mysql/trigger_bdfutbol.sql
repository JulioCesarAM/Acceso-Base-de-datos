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
create TRIGGER trig_fechaInicio_fechafin /*cambiar mal  por before sin el update*/
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
         END 
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