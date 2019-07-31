<?php

include 'db.php';

//Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado "registrar_curso"
// el cual agrega un periodo de matrícula nuevo
//Devuelve la variable result al controlador para realizar las validaciones respectivas
function registrar_curso($nombre, $cupo, $horario, $materiales)
{
    $con = conectar();

    $sql = "CALL registrar_curso('$nombre', '$cupo', '$horario', '$materiales')";
    
    $result = mysqli_query($con, $sql);
    return $result;

}

?>