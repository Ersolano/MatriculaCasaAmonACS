<?php
include 'db.php';

//Esta funcion devuelve el horario para generar el informe

//Devuelve la variable result al controlador para realizar las validaciones respectivas

function obtener_horario($idMatricula)
{
    $con = conectar();
    $sql = "call obtener_horario_informe($idMatricula)";
    $result = mysqli_query($con, $sql);
    return $result;
}


?>