<?php
    include ("conex.php");

    $nom_equipo=$_POST["nom_equipo"];
    $cod_liga=$_POST["cod_liga"];
    $localidad=$_POST["localidad"];
    $internacional=(int)$_POST["internacional"];
    //$comando="insert INTO equipos (cod_equipo,nom_equipo,cod_liga,localidad,internacional)
    //values (:null,:nom_equipo,:cod_liga,:localidad,:internacional );";
    //$insercion=$pdo->prepare($comando);
    //$insercion -> bindParam(":null",$mynull,PDO::PARAM_NULL);
    //$insercion -> bindParam(":nom_equipo",$nom_equipo,PDO::PARAM_STR);
    //$insercion -> bindParam(":cod_liga",$cod_liga,PDO::PARAM_STR);
    //$insercion -> bindParam(":localidad",$localidad,PDO::PARAM_STR);
    //$insercion -> bindParam(":internaciol",$nternacional,PDO::PARAM_INT);
    //$insercion -> execute();
    
    $procedurecall= $pdo->prepare("call insertar_equipo(:nombreEquipo,:codigoLiga,:localidade,:internacionalidad,@salida1,@salida2)");
    $procedurecall -> bindParam(":nombreEquipo",$nom_equipo,PDO::PARAM_STR);
    $procedurecall  -> bindParam(":codigoLiga",$cod_liga,PDO::PARAM_STR);
    $procedurecall  -> bindParam(":localidade",$localidad,PDO::PARAM_STR);
    $procedurecall  -> bindParam(":internacionalidad",$internacional,PDO::PARAM_INT);
    $procedurecall -> execute();
    
    $pdo=null;
    header("location:index.php");



?>