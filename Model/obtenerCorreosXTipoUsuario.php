<?php

include 'db.php';


function obtener_correos_x_tipo_usuario($tipo)

{

    $con = conectar();

    $sql = "call obtener_correos_x_tipo_usuario($tipo)";

    $result = mysqli_query($con, $sql);

    return $result;

}