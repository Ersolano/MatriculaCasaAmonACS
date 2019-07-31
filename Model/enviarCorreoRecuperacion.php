<?php

include 'enviarCorreo.php';

function enviar_correo_recuperacion($to, $name, $cedula, $pin){
    
    $subject = "Recuperación de contraseña";
    $message = "Estimado(a) " . $name . " de parte de Casa Cultural Amón le enviamos los datos de su contraseña.\n
    
                \nUsuario: ".$cedula."
                \nPin: ".$pin."\n
                
                \nAnte cualquier consulta no dude en contactarnos por medio del correo electrónico ccamon@gmail.com o al teléfono 25509449.\nSaludos!";
    enviar_correo($to, $subject, $message);
    
}

?>