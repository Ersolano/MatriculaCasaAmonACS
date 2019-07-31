<?php

include 'db.php';


function desactivar_administrador($idAdministrador)

{

    $con = conectar();

    $query = "call 	desactivar_administrador('$idAdministrador')";

    $result = mysqli_query($con, $query);

    return $result;

}

