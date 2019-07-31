<?php
define ('SITE_ROOT', realpath(dirname(__FILE__)));

include '../Model/matricular.php';
include '../Model/obtenerDatosCurso.php';
include '../Model/obtenerDatosUsuario.php';
include '../Model/enviarCorreoMatricula.php';


    if($_POST){

        //datos tomados del formulario HTML

        $cedula_estudiante = $_POST['cedula'];
        $id_Curso_X_Periodo  = $_POST['cursos'];
        $numero_comprobante = $_POST['comprobante'];
        $fecha = date_create();
        $stamp = date_format($fecha, 'U = Y-m-d H:i:s');
        $target_dir = "comprobantes/";
        $target_file = $target_dir . $stamp. basename($_FILES["fileToUpload"]["name"]);
        $uploadOk = 1;
        $imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
        
        //datos para enviar el correo de confirmacion
        $datosUsuario = obtener_datos_usuario($cedula_estudiante);
        $nombre = $datosUsuario[0];
        $correo = $datosUsuario[1];
        $datosCurso = obtener_datos_curso($id_Curso_X_Periodo);
        $curso = $datosCurso[0];
        $horario = $datosCurso[1];

        //se invoca la función del modelo para registar el usuario en la base de datos.
        if (file_exists($target_file)) {
        echo "El archivo ya esta registrado.";
        $uploadOk = 0;
        }
        if ($uploadOk == 0) {
            echo "Sorry, your file was not uploaded.";
        // if everything is ok, try to upload file
        } else {
            if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], "../".$target_file)) {
                $resultado = matricular($cedula_estudiante, $id_Curso_X_Periodo, $numero_comprobante, $target_file);
                enviar_correo_matricula($correo, $nombre, $curso, $horario);
                // This is in the PHP file and sends a Javascript alert to the client
                $message = "El archivo ". basename($_FILES["fileToUpload"]["name"]). " se ha guardado y la matrícula está pendiente de aprobación.";

                echo "<SCRIPT type='text/javascript'> 
                    alert('$message');
                    window.location.replace(\"../matricular.html\");
                </SCRIPT>";
                //header('Location: ../matricular.html'); 
            } else {
                echo "Hubo un error, intentelo de nuevo.";
            }
        }

    }

?>