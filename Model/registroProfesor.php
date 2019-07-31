<?php

include 'db.php';

//Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado "registrar_profesor"
// el cual agrega un usuario con propiedad de profesor
//Devuelve la variable result al controlador para realizar las validaciones respectivas
function registrar_profesor($cedula, $nombre, $primer_apellido, $segundo_apellido, $telefono, $telefono2,
                            $correo,  $fecha_nacimiento, $clave, $provincia, $canton, $distrito, $sennas,
                            $identificaion_tributaria, $nombre_completo, $razon_social, $estado_tributario, $actividad, $codigo_actividad, $identificacion_select)
{
    $con = conectar();

    $sql = "CALL registrar_profesor('$cedula', '$nombre', '$primer_apellido', '$segundo_apellido', '$telefono', 
                                    '$telefono2','$correo',  '$fecha_nacimiento', '$clave', '$provincia', '$canton', 
                                    '$distrito','$sennas', '$identificaion_tributaria', '$nombre_completo', 
                                    '$razon_social', '$estado_tributario','$actividad', '$codigo_actividad', '$identificacion_select')";
    $result = mysqli_query($con, $sql);
    return $result;

}

?>