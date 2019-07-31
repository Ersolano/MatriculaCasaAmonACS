<?php



include 'db.php';



//Esta funcion devuelve el resultado de los cursos con nombre y horario con el metodo "obtener_cursos()"

//Devuelve la variable result al controlador para realizar las validaciones respectivas

function obtener_cursos()

{

    $con = conectar();



    $sql = "call obtener_cursos()";



    $result = mysqli_query($con, $sql);

    return $result;



}