<?php



include 'db.php';

//Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado " modificar_curso_matricula"
//el cual cambia de curso a un estudiante matriculado

//Devuelve la variable result al controlador para realizar las validaciones respectivas


function modificar_curso_matricula($id_Curso_X_Periodo, $id_matricula)

{

    $con = conectar();

    $sql = "CALL modificar_curso_matricula('$id_Curso_X_Periodo', '$id_matricula')";

    $result = mysqli_query($con, $sql);

    return $result;

}

?>