<?php


include 'db.php';



//Esta funcion devuelve el resultado de los peridos con nombre y id con el metodo "obtener_perdiodos_actuales()"

//Devuelve la variable result al controlador para realizar las validaciones respectivas

function obtener_periodos_actuales()

{

    $con = conectar();



    $sql = "call obtener_periodos_actuales()";



    $result = mysqli_query($con, $sql);

    return $result;



}