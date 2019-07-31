<?php


include '../Model/obtenerHistorialEstudiante.php';

    if($_POST){

        //datos tomados del formulario HTML

        $cedula_estudiante = $_POST['cedula'];

        if ($cedula_estudiante) {
            $resultado = obtener_historial_X_estudiante($cedula_estudiante);

            echo "Datos obtenidos";
        } else {
            echo "Hubo un error, intentelo de nuevo.";
        }
    }

?>