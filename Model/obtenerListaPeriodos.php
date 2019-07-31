<?php


include 'db.php';



//Esta funcion devuelve el resultado de los peridos con nombre y id con el metodo " obtener_listaPeriodos()"
//Utilizado en la ventana de listarEstudiantes.html
//Devuelve la variable result al controlador para realizar las validaciones respectivas

function  obtener_listaPeriodos()

{

    $con = conectar();

    $sql = "call obtener_listaPeriodos()";

    $result = mysqli_query($con, $sql);

    return $result;

}