<?php



include 'db.php';



//Esta funcion devuelve el resultado del historial de cursos de un estudiante con el metodo "obtener_historial_X_estudiante()"

//Devuelve la variable result al controlador para realizar las validaciones respectivas

function obtener_historial_X_estudiante($cedula_estudiante)

{

    $con = conectar();



    $sql = "call obtener_historial_X_estudiante('$cedula_estudiante')";



    $result = mysqli_query($con, $sql);

    return $result;



}