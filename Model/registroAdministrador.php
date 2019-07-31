<?php



include 'db.php';



//Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado "registrar_administrador"

//Devuelve la variable result al controlador para realizar las validaciones respectivas

function registrar_administrador($cedula, $nombre, $primer_apellido, $segundo_apellido, $tipo_indentificacion, $telefono, $telefono2, $correo, $fecha_nacimiento, $clave, $tipo_administrador)

{

    $con = conectar();

    $sql = "call registrar_administrador('$cedula', '$nombre', '$primer_apellido', '$segundo_apellido', '$tipo_indentificacion', '$telefono','$telefono2', '$correo', '$fecha_nacimiento', '$clave', '$tipo_administrador')";


    $result = mysqli_query($con, $sql);

    return $result;



}

function obtener_usuario($cedula) {

    $con = conectar();

    $query = "SELECT nombre, primer_apellido, segundo_apellido, telefono, correo, fecha_nacimiento FROM Usuario WHERE cedula='" . $cedula . "'";

    $result = mysqli_query($con, $query);

	return $result;

}



?>