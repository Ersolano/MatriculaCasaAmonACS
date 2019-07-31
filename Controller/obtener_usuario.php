<?php
include '../Model/login.php';

    if($_POST){
        //datos tomados del formulario HTML
        $cedula = $_POST['usuario'];
        $clave =  $_POST['contra'];
        
        //se invoca la función del modelo para obtener el usuario en la base de datos.
        $resultado = obtener_usuario($cedula, $clave);
        
        //aqui se deben mostrar los mensajes respectivos y direccionar a otras páginas HTML
        if($resultado == "0"){ //Usuario Inactivo
             echo "<SCRIPT type='text/javascript'>
                alert('Usuario Inactivo');
                window.location.replace('../login.html');
            </SCRIPT>";
        }else{ //Datos Incorrectos
           echo "<SCRIPT type='text/javascript'>
                alert('Datos Incorrectos');
                window.location.replace('../login.html');
            </SCRIPT>";
        }
        
    }
?>
