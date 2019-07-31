<?php

include 'enviarCorreo.php';

function enviar_correo_registro($to, $name, $cedula, $password){
    
    $subject = "Bienvenido(a) a Casa Cultural Amón";
    $message = "Estimado(a) " . $name . " de parte de Casa Cultural Amón le damos una cordial bienvenida a nuestro programa de cursos libres de extension cultural.\n" . "Para ingresar al sistema, debe hacerlo por medio de estos datos:\n" .
    "Usuario: " . $cedula . "\n" . "Pin: " . $password . "\n" . "Ante cualquier consulta no dude en contactarnos por medio del correo electrónico ccamon@gmail.com o al teléfono 25509449.\n Saludos!";
    enviar_correo($to, $subject, $message);
    
}

?>