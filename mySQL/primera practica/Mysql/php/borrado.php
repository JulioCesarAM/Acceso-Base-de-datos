<?php
    include ("conex.php");
    $cod_equipos=$_POST["cod_equipo"];
    $borrado="delete   from equipos where cod_equipo = :cod_equipos";
    $stmt = $pdo->prepare($borrado);
    $stmt ->bindParam(":cod_equipos",$cod_equipos,PDO::PARAM_INT);
    $stmt->execute();
    $pdo=null;
    
    header("location:index.php");
   
?>
>
            