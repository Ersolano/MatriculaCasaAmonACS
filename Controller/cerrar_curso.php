<?php


include '../Model/cerrarCurso.php';

if ($_POST) {

    //datos tomados del formulario HTML


    // Obtener cedula de la sesion

    $idCXP = $_POST['idCXP'];;


    //se invoca la función del modelo para cerrar el curso en la base de datos.

    $resultado = cerrar_curso($idCXP);


    //aqui se deben mostrar los mensajes respectivos y direccionar a otras páginas HTML

    echo !$resultado ? "0" : "1";

}