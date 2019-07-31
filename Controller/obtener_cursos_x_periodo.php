<?php

include '../Model/obtenerCursosXPeriodo.php';


if ($_POST) {

    //datos tomados del formulario HTML


    // Obtener cedula de la sesion

    $idPeriodo = $_POST['idPeriodo'];;


    $resultado = obtener_cursos_x_periodo($idPeriodo);

    $myArray = array();

    $myObj = new stdClass();


    $emptyObject = new stdClass();
    $emptyArray = array();


// Verifica que se obtengan resultados con el query
    if (!$resultado) {
        echo "No";
    } else {
        if ($resultado->num_rows > 0) {
            while ($row = $resultado->fetch_object()) {
                $myArray[] = $row;
            }

            $myObj->data = $myArray;
            echo json_encode($myObj);

        } else {
            $emptyObject->data = $myObj;
            echo json_encode($emptyObject);

        }


    }
}