<?php
include '../Model/editarProfesor.php';

if($_POST){
    //datos tomados del formulario HTML
    $cedula = $_POST['cedula'];
    $nombre = $_POST['nombre'];
    $nombre_completo = $_POST['nombre_completo'];
    $primer_apellido = $_POST['apellido1'];
    $segundo_apellido = $_POST['apellido2'];
    $telefono = $_POST['telefono'];
    $telefono2 = $_POST['telefono2'];
    $correo = $_POST['email'];
    $razon_social = !empty($_POST['razon_social']) ? $_POST['razon_social'] : '';
    $identificaion_tributaria = !empty($_POST['identificaion_tributaria']) ? $_POST['identificaion_tributaria'] : '';
    $estado_tributario = $_POST['estado_tributario'];
    $actividad = !empty($_POST['actividad']) ? $_POST['actividad'] : '';
    $codigo_actividad = !empty($_POST['codigo_actividad']) ? $_POST['codigo_actividad'] : '';

    $provincia = str_replace("_", " ",$_POST['provincia']);
    $canton = str_replace("_", " ",$_POST['canton']);
    $distrito = str_replace("_", " ",$_POST['distrito']);
    $sennas = !empty($_POST['señas']) ? $_POST['señas'] : '';
    $id_profesor = $_POST['id_profesor'];


    //falta verificar que el usuario no exista en la base de datos.

    //se invoca la función del modelo para registar el usuario en la base de datos.
    $resultado = editar_profesor($cedula, $nombre, $primer_apellido, $segundo_apellido, $telefono, $telefono2,
        $correo, $provincia, $canton, $distrito, $sennas, $identificaion_tributaria,
        $nombre_completo, $razon_social, $estado_tributario, $actividad, $codigo_actividad, $id_profesor);


    //aqui se deben mostrar los mensajes respectivos y direccionar a otras páginas HTML
    if(!$resultado)
    {
        echo "No se ha podido registrar.";
    }
    else
    {
        echo "Usuario editado exitosamente.";
    }

    echo "<br>";

    echo "<a href=\"../editarProfesor.html\">GO BACK</a>";
}