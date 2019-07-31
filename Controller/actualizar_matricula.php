<?php

include '../Model/obtenerUsuariosMatricula.php';
include '../Model/obtenerDatosCurso.php';
include '../Model/obtenerDatosUsuario.php';
include '../Model/obtenerDatosMatricula.php';
include '../Model/enviarCorreoMatriculaEstado.php';

    $id = $_POST['id'];
    $estado = $_POST['estado'];
    $comentario = $_POST['comentario'];
    $resultado = actualizar_matricula($id, $estado, $comentario);
    
    

    if (!$resultado) {

        echo 1;

    } else {

        $datosMatricula = obtener_datos_matricula($id);
	    $cedula = $datosMatricula[0];
	    $idCursoXPeriodo = $datosMatricula[1];
	    
	    $datosUsuario = obtener_datos_usuario($cedula);
	    $nombre = $datosUsuario[0];
	    $correo = $datosUsuario[1];
	    
	    $datosCurso = obtener_datos_curso($idCursoXPeriodo);
	    $curso = $datosCurso[0];
	    $horario = $datosCurso[1];
	    
	    enviar_correo_matricula_estado($correo, $nombre, $curso, $horario, $estado);

        if ($resultado->num_rows <= 0) {
            
        

	    echo "bien";
	   
         
        } else {

            echo "error";	

        }


    }


