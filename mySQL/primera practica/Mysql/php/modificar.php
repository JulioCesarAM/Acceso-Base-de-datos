<!doctype html>

    <head>
            <style>
                h1{
                    text-align:center;
                }
                table,th,td,tr{
                    border:1px solid black;
                    margin-left:auto;
                    margin-right:auto;
                    border-collapse:collapse;
                    text-align:center;   
                }
                th{
                    padding-left:10px;
                    padding-right:10px;
                }
            </style>

    </head>

    <body>
        <h1>Actualizar registros</h1>

        <?php
            include("conex.php");
            $cod_equipo=$_GET["cod_equipo"];
            $nom_equipo=$_GET["nom_equipo"];
            $cod_liga=$_GET["cod_liga"];
            $localidad=$_GET["localidad"];
            $internacional=$_GET["internacional"];
            $ligas=$pdo->query("select * from ligas")->fetchAll(PDO::FETCH_OBJ);
            
        ?>

        <form name="updateo_tabla" method="post" action="update_table.php">
            <table>

                <tr>
                    <td>campo</td>
                    <td>valor Antiguo</td>
                    <td>valor Nuevo</td>
                </tr>

                <tr>
                    <td>cod_equipo</td>
                    <td> <?php echo $cod_equipo ?> </td>
                    <td>
                        <label for="cod_equipo"></label>
                        <input type="hidden" name="cod_equipo" id="cod_equipo" value="<?php echo $cod_equipo ?>">valor inamovible
                    </td>
                </tr>

                <tr>
                    <td>nombre equipo</td>
                    <td><?php echo $nom_equipo ?></td>
                    <td>
                        <label for="nom_equipo"></label>
                        <input type="text" name="nom_equipo" id="nom_equipo">
                    </td>
                </tr>

                <tr>
                    <td>codLiga</td>
                    <td><?php echo $cod_liga ?></td>
                    <td>
                        <label for="cod_liga"></label>
                        <select name="cod_liga",id="cod_liga">
                            <?php 
                                foreach($ligas as $liga){
                                    echo "<option value="."'".$liga->codLiga."'".">".$liga->nomLiga."</option>" ;
                                }
                            ?>
                    </td>
                </tr>

                <tr>
                    <td>localidad</td>
                    <td><?php echo $localidad ?></td>
                    <td>
                        <label for="localidad"></label>
                        <input type="text" name="localidad" id="localidad">
                    </td>
                </tr>
                <tr>
                    <td>internacional</td>
                    <td><?php echo $internacional ?></td>
                    <td>
                        <label for="localidad"></label>
                        <input type="number" name="internacional" id="internacional" min="0" max="1">
                    </td>
                </tr> 
                <tr>
                    <td colspan="3"><input type="submit" name="t_actualizar" id="t_actualizar" value="actualizar"></td>
                </tr>


            </table>

        </form>

    </body>
</html>