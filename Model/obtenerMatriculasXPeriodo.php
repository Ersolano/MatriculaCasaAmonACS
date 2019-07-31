<?php

//Esta función es para desplegar las matriculas de cada periodo en la ventana Lista Estudiantes.


include 'db.php';

function obtener_estudiantes_x_periodo($idPeriodo)
{
    $con = conectar();
    $sql = "call obtener_estudiantes_x_periodo('$idPeriodo')";
    $result = mysqli_query($con, $sql);
    return $result;
}