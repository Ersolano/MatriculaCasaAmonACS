<?php

include '../Model/registroProfesor.php';

    if($_POST){
        //datos tomados del formulario HTML
        $cedula = $_POST['identificacion'];
        $nombre = $_POST['nombre'];
        $nombre_completo = $_POST['nombre_completo'];
        $primer_apellido = $_POST['apellido1'];
        $segundo_apellido = $_POST['apellido2'];
        $telefono = $_POST['telefono'];
        $telefono2 = $_POST['telefono2'];
        $correo = $_POST['email'];
        $razon_social = $_POST['razon_social'];
        $identificacion_select = $_POST['identificacion_select'];
        $identificaion_tributaria = $_POST['identificaion_tributaria'];
        $estado_tributario = $_POST['estado_tributario'];
        $actividad = $_POST['actividad'];
        $codigo_actividad = $_POST['codigo_actividad'];
        $fecha = $_POST['nacimiento'];
        $clave = date('Y', strtotime($fecha)); //prueba - falta tomar el año de la fecha.

        $provincia = str_replace("_", " ",$_POST['provincia']);
        $canton = str_replace("_", " ",$_POST['canton']);
        $distrito = str_replace("_", " ",$_POST['distrito']);
        $sennas = $_POST['señas'];


        $fecha_nacimiento = date('Y-m-d', strtotime($fecha));
        
        //falta verificar que el usuario no exista en la base de datos.

        //se invoca la función del modelo para registar el usuario en la base de datos.
        $resultado = registrar_profesor($cedula, $nombre, $primer_apellido, $segundo_apellido, $telefono, $telefono2,
            $correo,  $fecha_nacimiento, $clave, $provincia, $canton, $distrito, $sennas, $identificaion_tributaria,
            $nombre_completo, $razon_social, $estado_tributario, $actividad, $codigo_actividad, $identificacion_select);


        //aqui se deben mostrar los mensajes respectivos y direccionar a otras páginas HTML
        if(!$resultado)
        {
            echo "No se ha podido registrar.";
        }
        else
        {
            echo "Usuario registrado exitosamente.";
        }
    }
?>