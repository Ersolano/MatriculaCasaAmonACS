<?php



include '../Model/usuario.php';
include '../Model/enviarCorreoRegistro.php';



    if($_POST){

        //datos tomados del formulario HTML

        $cedula = $_POST['identificacion'];

        $nombre = $_POST['nombre'];

        $primer_apellido = $_POST['apellido1'];

        $segundo_apellido = $_POST['apellido2'];

        $tipo_indentificacion = $_POST['tipo_indentificacion'];

        $telefono = $_POST['telefono'];

        $telefono2 = $_POST['telefono2'];

        $correo = $_POST['email'];

        $fecha = $_POST['nacimiento'];

        $clave = date('Y', strtotime($fecha));

        

        $fecha_nacimiento = date('Y-m-d', strtotime($fecha));

        $telefono  = str_replace('-', "", $telefono);
        $telefono2  = str_replace('-', "", $telefono2);

        

        //se invoca la función del modelo para registar el usuario en la base de datos.

        $resultado = registrar_usuario($cedula, $nombre,$primer_apellido, $segundo_apellido, $tipo_indentificacion, $telefono, $telefono2, $correo, $fecha_nacimiento, $clave);

        

        //aqui se deben mostrar los mensajes respectivos y direccionar a otras páginas HTML

        if(!$resultado)

        {

            echo '<script> alert("No se ha podido registrar, por favor revise que los datos sean correctos");
            window.location="https://casaculturalamon.000webhostapp.com/Prototipo1/registroEstudiante.html";
            </script>';

        }

        else

        {

            echo '<script> alert("Usuario registrado exitosamente.");
            window.location="https://casaculturalamon.000webhostapp.com/Prototipo1/registroEstudiante.html";
            </script>';
            enviar_correo_registro($correo, $nombre, $cedula, $clave);

        }

    }

?>