<?php

include 'db.php';

//Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado "registrar_periodor"
// el cual agrega un periodo de matrícula nuevo
//Devuelve la variable result al controlador para realizar las validaciones respectivas
function registrar_periodo($nombre,$fecha_inicio, $fecha_final)
{
    $con = conectar();

    $sql = "CALL registrar_periodo('$nombre', '$fecha_inicio', '$fecha_final')";
    
    $result = mysqli_query($con, $sql);
    return $result;

}

function registrar_cursoXperiodo($idCurso,$idPeriodo, $idProfesor)
{
    $con = conectar();

    $sql = "CALL registrar_curso_X_Periodo('$idCurso', '$idPeriodo', '$idProfesor')";
    
    $result = mysqli_query($con, $sql);
    return $result;

}



?>