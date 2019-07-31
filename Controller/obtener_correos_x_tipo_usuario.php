<?php

include '../Model/obtenerCorreosXTipoUsuario.php';


if ($_POST) {
    //datos tomados del formulario HTML

    $tipo = (int)$_POST['tipo'];

    $resultado = obtener_correos_x_tipo_usuario($tipo);

    $myArray = array();

    //Verifica que se obtengan resultados con el query
    if (!$resultado) {
        echo "No";
    } else {
        if ($resultado->num_rows > 0) {


            while ($obj = $resultado->fetch_object()) {
                $myArray[] = $obj;
            }

            echo json_encode($myArray);

        } else {
            echo "0";
        }



    }
}