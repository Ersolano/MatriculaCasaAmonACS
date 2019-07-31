<?php



include '../Model/obtenerCursos.php';



    $resultado = obtener_cursos();


    $myArray = array();



    echo "<select class='select2_group form-control' id='cursos' name='cursos'>";

    if (!$resultado) {

        echo "<option>No hay cursos para mostrar</option>";

    } else {

        if ($resultado->num_rows > 0) {

            while ($row = mysqli_fetch_row($resultado)) {

        
                echo "<option value='".$row[0]."' >".$row[1]." > ".$row[2]."</option>";

            }




        } else {

            echo "<option id=0 value =0>No hay cursos para mostrar</option>";  

        }

    echo "</select>";


    }


