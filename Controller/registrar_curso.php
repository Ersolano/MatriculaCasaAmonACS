<?php

include '../Model/registroCurso.php';

    if($_POST){
        //datos tomados del formulario HTML
        $nombre = $_POST['nombre'];
        $horario = $_POST['horario'];
        $cupo = $_POST['cupo'];
		$materiales = $_POST['materiales'];
		
        //se invoca la función del modelo para registar el usuario en la base de datos.
        $resultado = registrar_curso($nombre, $cupo, $horario, $materiales);
        
        //aqui se deben mostrar los mensajes respectivos y direccionar a otras páginas HTML
        if(!$resultado)
        {
            //echo "No se ha podido registrar.";<script>
            echo '(<script>
                alert("Ha ocurrido un error! por favor intente nuevamente");
                window.location="https://casaculturalamon.000webhostapp.com/Prototipo1/registroCurso.html";
            </script>)';
            
        }
        else
        {
            //echo "Curso registrado exitosamente.";
             echo '(<script>
                alert("Curso registrado exitosamente!");
                window.location="https://casaculturalamon.000webhostapp.com/Prototipo1/registroCurso.html";
            </script>)';
            
            
        }
    }
?>