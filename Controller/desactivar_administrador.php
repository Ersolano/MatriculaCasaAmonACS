<?php

include '../Model/desactivarAdministrador.php';

if ($_POST) {

    $idAdministrador = $_POST['idAdministrador'];;


    //se invoca la función del modelo para cerrar el curso en la base de datos.

    $resultado = desactivar_administrador($idAdministrador);


    //aqui se deben mostrar los mensajes respectivos y direccionar a otras páginas HTML

    echo !$resultado ? "0" : "1";

}
?>