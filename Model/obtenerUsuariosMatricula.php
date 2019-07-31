<?php



include 'db.php';



//Esta funcion devuelve el resultado de las personas en matricula del procedimiento almacenado "obtener_usuariosMatricula"

//Devuelve la variable result al controlador para realizar las validaciones respectivas

function obtener_usuariosMatricula()

{

    $con = conectar();



    $sql = "call obtener_usuariosMatricula()";



    $result = mysqli_query($con, $sql);

    return $result;



}


//Esta funcion actualiza el estado de matricula

//Devuelve la variable result al controlador para realizar las validaciones respectivas

function actualizar_matricula($id, $estado, $comentario)

{

    $con = conectar();



    $sql = "call actualizar_matricula('$id', '$estado', '$comentario')";



    $result = mysqli_query($con, $sql);

    return $result;



}
