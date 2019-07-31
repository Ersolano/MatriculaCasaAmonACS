<?php

include 'db.php';

//Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado "editar profesor"
// el cual edita un usuario con propiedad de profesor
//Devuelve la variable result al controlador para realizar las validaciones respectivas
function editar_profesor($cedula, $nombre, $primer_apellido, $segundo_apellido, $telefono, $telefono2,
                            $correo, $provincia, $canton, $distrito, $sennas,
                            $identificaion_tributaria, $nombre_completo, $razon_social, $estado_tributario, $actividad, $codigo_actividad, $id_profesor)
{
    $con = conectar();

    $sql = "CALL editar_profesor('$cedula', '$nombre', '$primer_apellido', '$segundo_apellido', '$telefono', 
                                    '$telefono2','$correo', '$provincia', '$canton', 
                                    '$distrito','$sennas', '$identificaion_tributaria', '$nombre_completo', 
                                    '$razon_social', '$estado_tributario','$actividad', '$codigo_actividad', '$id_profesor')";

    $result = mysqli_query($con, $sql);
    return $result;

}