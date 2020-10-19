<?php
    include ("conex.php");
    $n_cod_equipo=$_POST["cod_equipo"];
    $n_nom_equipo=$_POST["nom_equipo"];
    $n_cod_liga=$_POST["cod_liga"];
    $n_localidad=$_POST["localidad"];
    if (isset($_POST["internacional"])){
        $n_internacional=1;
    }
    else{
        $n_internacional=0;
    }
    
    $consulta="update equipos 
    set nom_equipo= :nombre_equipo, 
    cod_liga= :codigo_liga,
    localidad= :localida, 
    internacional= :internacion 
    where cod_equipo= :id_equipo";
    
    $ConsultaModificada = $pdo->prepare($consulta);

    $ConsultaModificada -> bindParam(":id_equipo",$n_cod_equipo,PDO::PARAM_INT);
    $ConsultaModificada -> bindParam(":nombre_equipo",$n_nom_equipo,PDO::PARAM_STR,40);
    $ConsultaModificada -> bindParam(":codigo_liga",$n_cod_liga,PDO::PARAM_STR,5);
    $ConsultaModificada -> bindParam(":localida",$n_localidad,PDO::PARAM_STR,60);
    $ConsultaModificada -> bindParam(":internacion",$n_internacional,PDO::PARAM_INT);

    $ConsultaModificada -> execute();
    $pdo=null;
    header("location:index.php");
?>