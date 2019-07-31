<?php

include '../Model/obtenerProfesorXCedula.php';


if ($_POST) {
    //datos tomados del formulario HTML

    $cedula = $_POST['cedula'];

    $resultado = obtener_profesor_x_cedula($cedula);
    $myArray = array();

    //Verifica que se obtengan resultados con el query
    if (!$resultado) {
        echo "No";
    } else {
        if ($resultado->num_rows > 0) {
            while ($row = $resultado->fetch_object()) {
                $myArray[] = $row;
            }
            echo json_encode($myArray);

        } else {
            echo "0";
        }

    }
}