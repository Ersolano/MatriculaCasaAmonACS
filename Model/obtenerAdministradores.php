<?php




include 'db.php';



function obtener_administradores()

{

    $con = conectar();

    $sql = "call obtener_administradores_activos();";

    $result = mysqli_query($con, $sql);

    return $result;



}