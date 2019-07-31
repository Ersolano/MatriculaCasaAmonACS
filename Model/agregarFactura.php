<?php
include 'db.php';

/*Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado " agregar_factura"
//El cual vincula una factura electrónica generada a una matrícula */

//Devuelve la variable result al controlador para realizar las validaciones respectivas


function agregar_factura($id_matricula, $num_factura)

{

    $con = conectar();

    $sql = "CALL agregar_factura('$id_matricula', '$num_factura')";

    $result = mysqli_query($con, $sql);

    return $result;

}

?>