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
        <h1>confirmar Borrado</h1>
        <?php
            $cod_equipo=$_GET["cod_equipo"];
            $nom_equipo=$_GET["nom_equipo"];
            $cod_liga=$_GET["cod_liga"];
            $localidad=$_GET["localidad"];
            $internacional=$_GET["internacional"];
        ?>

        <form name="confirmar_borrado" method="post" action="borrado.php">
        <table>
            <tr>
                <td>cambo a borrar</td>
                <td>valor borrado</td>
            </tr>

            <tr>
                <td>cod_equipo</td>
                <td> 
                    <label for="cod_equipo"></label>
                    <input type="hidden" name="cod_equipo" id="cod_equipo" value="<?php echo $cod_equipo ?>"><?php echo $cod_equipo ?>
            
                </td>
            </tr>

            <tr>
                <td>nombre equipo</td>
                <td><?php echo $nom_equipo ?></td>
            </tr>

            <tr>
                <td>codLiga</td>
                <td><?php echo $cod_liga ?></td>
            </tr>

            <tr>
                <td>localidad</td>
                <td><?php echo $localidad ?></td>
            </tr>
            <tr>
                <td>internacional</td>
                <td><?php echo $comprobar=$internacional==1?"si":"no"?></td>
            </tr> 
            <tr>
                <td colspan="3"><input type="submit" name="t_borrar" id="t_borrar" value="borrar"></td>
            </tr>
            <tr>
                <td colspan="3"> 
                    <a href="index.php">
                    <input type="button" name="t_volver" id="t_volver" value="volver">
                    </a>
                </td>
            </tr>


        </form>
    </body>