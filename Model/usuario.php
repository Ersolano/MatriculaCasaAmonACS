<?php



include 'db.php';



//Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado "registrar_usuario"

//Devuelve la variable result al controlador para realizar las validaciones respectivas

function registrar_usuario($cedula, $nombre, $primer_apellido, $segundo_apellido, $tipo_indentificacion, $telefono, $telefono2, $correo, $fecha_nacimiento, $clave)

{

    $con = conectar();



    $sql = "call registrar_usuario('$cedula', '$nombre', '$primer_apellido', '$segundo_apellido', '$tipo_indentificacion', '$telefono','$telefono2', '$correo', '$fecha_nacimiento', '$clave')";



    $result = mysqli_query($con, $sql);

    return $result;



}





//Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado "editar_usuario"

//Devuelve la variable result al controlador para realizar las validaciones respectivas

function editar_usuario($cedula, $nombre, $primer_apellido, $segundo_apellido, $telefono, $telefono2, $correo)

{

    $con = conectar();

    $query = "call editar_usuario('$cedula','$nombre', '$primer_apellido', '$segundo_apellido', '$telefono', '$telefono2', '$correo')";

    $result = mysqli_query($con, $query);

    return $result;

}



function obtener_usuario($cedula) {

    $con = conectar();

    $query = "SELECT nombre, primer_apellido, segundo_apellido, telefono, telefono2, correo, fecha_nacimiento FROM Usuario WHERE cedula='" . $cedula . "'";

    $result = mysqli_query($con, $query);



    return $result;

}



?>