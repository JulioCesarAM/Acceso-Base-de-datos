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
        <?php
            include("conex.php");
            $ligas=$pdo->query("select * from ligas")->fetchAll(PDO::FETCH_OBJ);
        ?>
        <h1>insertar equipos</h1>
        <form name="updateo_tabla" method="post" action="insertado.php">
            <table>

                <tr>
                    <td>campo</td>
                    <td>valor a Insertar</td>
                </tr>

                <tr>
                    <td>cod_equipo</td>
                    <td>
                        <label for="cod_equipo"></label>
                        <input type="hidden" name="cod_equipo" id="cod_equipo" >valor automatico
                    </td>
                </tr>
                <tr>
                    <td>nombre equipo</td>
                    <td>
                        <label for="nom_equipo"></label>
                        <input type="text" name="nom_equipo" id="nom_equipo">
                    </td>
                </tr>
                <tr>
                    <td>codLiga</td>
                    <td>
                        <label for="cod_liga"></label>
                        <select name="cod_liga",id="cod_liga">
                            <?php 
                                foreach($ligas as $liga){
                                    echo "<option value="."'".$liga->codLiga."'".">".$liga->nomLiga."</option>" ;
                                }
                            ?>
                       <! <input type="text" name="cod_liga" id="cod_liga"> ->
                    </td>
                </tr>

                <tr>
                    <td>localidad</td>
                    <td>
                        <label for="localidad"></label>
                        <input type="text" name="localidad" id="localidad">
                    </td>
                </tr>
                <tr>
                    <td>internacional</td>
                    <td>
                        <label for="internacional"></label>
                        <input type="number" name="internacional" id="internacional" min="0" max="1" >
                     
                    </td>
                </tr> 
                <tr>
                    <td colspan="2"><input type="submit" name="t_insertar" id="t_insertar" value="insertar"></td>
                </tr>


            </table>

        </form>





    </body>

</html>