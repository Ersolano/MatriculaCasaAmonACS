<?php



include 'db.php';



//Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado "actualizarPeriodo"

//Devuelve la variable result al controlador para realizar las validaciones respectivas

function actualizarPeriodo($fecha, $id)

{

    $con = conectar();



    $sql = "call actualizar_periodo('$fecha', '$id')";



    $result = mysqli_query($con, $sql);

    return $result;



}


?>