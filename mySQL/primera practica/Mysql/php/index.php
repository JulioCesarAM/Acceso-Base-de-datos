<!doctype html>
    <html>
        <head>
            <style>
                h1{
                    text-align:center;
                }
                table.table1,tr,th,td{
                    border:1px solid black;
                    margin-left:auto;
                    margin-right:auto;
                    border-collapse:collapse;  
                }
                table.table2{
                    border:0px ;
                    margin-left:auto;
                    margin-right:auto;
                }
                table.table2 tr{
                    border:0px ;
                    padding-top:90px
                    
                }
                table.table2 th{
                    border:0px ;
                    padding-top:90px
                    
                }
                table.table2 td{
                    border:0px ;
                    padding-top:90px
                    
                }

                th{
                    padding-left:10px;
                    padding-right:10px;
                }
            </style>

            <meta charset="utf-8">
        <title>crud</title>
        </head>
        <body>
            <?php 
                include("conex.php");
                $resultado=$pdo->query("select e.cod_equipo,e.nom_equipo,e.cod_liga,e.localidad,e.internacional,la.nomLiga
                    from equipos as e LEFT JOIN ligas as la ON la.codLiga=e.cod_liga;")->fetchAll(PDO::FETCH_OBJ);
                $numeroEquipos=$pdo->query("select count(*) from equipos")->fetchColumn();
                         
            ?>   
            <h1>Autor : julio Cesar Ascencion Marrero</h1>
            <h1>Base : bdfutbol - tabla:equipos</h1>
            <table class="table1">
                <tr>
                    <th>Cod_equipo</th>
                    <th>Nom_equipo</th>
                    <th>Cod_liga</th>
                    <th>Localidad</th>
                    <th>Internacional</th>
                    <th>nomLigas</th>
                    <th>Borrado</th>
                    <th>Modificacion</th>
                </tr>
                <?php foreach($resultado as $equipo): ?>
                <tr>
                    <th><?php echo $equipo->cod_equipo?></th>
                    <th><?php echo $equipo->nom_equipo?></th>
                    <th><?php echo $equipo->cod_liga?></th>
                    <th><?php echo $equipo->localidad?></th>
                    <th><?php echo $equipo->internacional?></th>
                    <th><?php echo $equipo->nomLiga?></th>
                    <th>
                        <a href="confirmarBorrado.php?cod_equipo=<?php echo $equipo->cod_equipo ?> &
                            nom_equipo=<?php echo $equipo->nom_equipo ?> &
                            cod_liga=<?php echo $equipo->cod_liga ?> &
                            localidad=<?php echo $equipo->localidad?> &
                            internacional=<?php echo $equipo->internacional?>">

                        <input type="button" name="del" id="del" value="borrar" >
                        </a>
                    </th>
                    
                    <th>
                        <a href="modificar.php?
                            cod_equipo=<?php echo $equipo->cod_equipo ?> &
                            nom_equipo=<?php echo $equipo->nom_equipo ?> &
                            cod_liga=<?php echo $equipo->cod_liga ?> &
                            localidad=<?php echo $equipo->localidad?> &
                            internacional=<?php echo $equipo->internacional?>">
                        <input type ="button" name="modificar" id="mod" value="modificar">
                        </a>
                    </th>
                   
                </tr>    
               <?php endforeach; ?>
            </table>  
            <table class ="table2">
                    <tr>
                        <td>Numero residencias escolares</td>
                        <td><?php echo $numeroEquipos ?></td>
                    </tr>
                    <tr>
                        <td>
                            <a href="insertarEquipo.php">
                            <input type="button" name="insertar" id="insertar" value="insertar" >
                        <td>
                    </tr>
            </table>
  


        </body>
    </html>