<?php



include 'db.php';



//Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado "matricular"

// el cual registra una matricula

//Devuelve la variable result al controlador para realizar las validaciones respectivas


function matricular($cedula_estudiante, $id_Curso_X_Periodo, $numero_comprobante, $comprobante)

{

    $con = conectar();



    $sql = "CALL matricular('$cedula_estudiante', '$id_Curso_X_Periodo', '$numero_comprobante', '$comprobante')";

    

    $result = mysqli_query($con, $sql);

    return $result;



}



?>