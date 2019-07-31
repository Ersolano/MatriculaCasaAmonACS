<?php

include 'db.php';


function cerrar_curso($idCXP)

{

    $con = conectar();

    $query = "call cerrar_curso('$idCXP')";

    $result = mysqli_query($con, $query);

    return $result;

}

