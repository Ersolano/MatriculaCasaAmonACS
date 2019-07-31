<?php
include '../Model/enviarCorreoRecuperacion.php';
include '../Model/db.php';

    if($_POST){
        //datos tomados del formulario HTML
        $correo = $_POST['email'];
        
        //se invoca la función del modelo para obtener el usuario en la base de datos.
        
        $con = conectar();
    
        $sql = "call recuperar_contra('$correo')";
        
        $result = mysqli_query($con, $sql);
        if(mysqli_num_rows($result) > 0){
            $fila = $result->fetch_row();
            
            $cedula = $fila[0];
            $pin = $fila[1];
            $nombre = $fila[2]." ".$fila[3];
            
            enviar_correo_recuperacion($correo, $nombre, $cedula, $pin);
            
            echo "<SCRIPT type='text/javascript'>
                alert('Contraseña enviada');
                window.location.replace('../login.html');
            </SCRIPT>";
            
        }else{
            echo "<SCRIPT type='text/javascript'>
                alert('Correo incorrecto o no existe');
                window.location.replace('../recuperacion.php');
            </SCRIPT>";
        }
    }
?>
