<?php
include 'db.php';

//Esta funcion devuelve el profesor para generar el informe

//Devuelve la variable result al controlador para realizar las validaciones respectivas

function obtener_profesor($idMatricula)
{
    $con = conectar();
    $sql = "call  obtener_profesor('$idMatricula')";
    $result = mysqli_query($con, $sql);
    return $result;
}
