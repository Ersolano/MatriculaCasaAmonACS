<?php

include 'db.php';


function obtener_profesor_x_cedula($cedula)

{

    $con = conectar();

    $sql = "call obtener_profesor_x_cedula('$cedula')";

    $result = mysqli_query($con, $sql);

    return $result;

}