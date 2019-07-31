<?php




include 'db.php';



function obtener_todos_cursos_x_periodo($idPeriodo)

{

    $con = conectar();



    $sql = "call obtener_todos_cursos_x_periodo('$idPeriodo')";



    $result = mysqli_query($con, $sql);

    return $result;



}

?>