<?php



include 'db.php';



//Esta funcion devuelve el resultado de las personas consultadas en matricula del procedimiento almacenado "obtener_usuariosMat"

//Devuelve la variable result al controlador para realizar las validaciones respectivas

function obtener_usuariosMat($id)

{

    $con = conectar();



    $sql = "call obtener_usuariosMat('$id')";



    $result = mysqli_query($con, $sql);

    return $result;



}