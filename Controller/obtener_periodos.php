<?php

include '../Model/obtenerPeriodos.php';


$resultado = obtener_periodos_actuales();


$myArray = array();


// Verifica que se obtengan resultados con el query
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