<?php



include '../Model/usuario.php';



if($_POST) {

    //datos tomados del formulario HTML



    // Obtener cedula de la sesion

    $cedula = $_POST['cedula'];//115810550;

    $nombre = $_POST['nombre'];

    $primer_apellido = $_POST['apellido1'];

    $segundo_apellido = $_POST['apellido2'];

    $telefono = $_POST['telefono'];

    $telefono2 = $_POST['telefono2'];

    $correo = $_POST['email'];





    $telefono  = str_replace('-', "", $telefono);



    //se invoca la función del modelo para editar el usuario en la base de datos.

    $resultado = editar_usuario($cedula, $nombre,$primer_apellido, $segundo_apellido, $telefono, $telefono2, $correo);





    //aqui se deben mostrar los mensajes respectivos y direccionar a otras páginas HTML

    if(!$resultado) {
        echo 0; // "No se ha podido actualizar, intente nuevamente.";
    } else {
        echo 1;
    }



}