<?php



include '../Model/obtenerUsuariosMatricula.php';



    $resultado = obtener_usuariosMatricula();


    $myArray = array();



    echo "<select onchange='actualizar()' id='combo' class='form-control'>";

    if (!$resultado) {

        echo "<option>No hay usuarios con matricula pendiente</option>";

    } else {

        if ($resultado->num_rows > 0) {

            while ($row = mysqli_fetch_row($resultado)) {

		#Nombre, Primer Apellido, Cédula, Nombre Curso, id, número comprobante
                echo "<option value='".$row[4]."' >".$row[0]." ".$row[1]." - ".$row[3]."</option>";

            }




        } else {

            echo "<option id=0 value =0>No hay usuarios con matricula pendiente</option>";	

        }

	echo "</select>";


    }


