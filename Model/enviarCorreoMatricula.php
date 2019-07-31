<?php

include 'enviarCorreo.php';

function enviar_correo_matricula($to, $name, $curso, $horario){
    
    $subject = "Solicitud de matrícula en el curso " . $curso;
    $message = "Estimado(a) " . $name . " de parte de Casa Cultural Amón le agradecemos su matrícula en el curso " . 
    $curso . ", el cual será impartido en el horario: " . $horario ."\n" . "Por favor, espere una notificación por este medio en cuanto se acepte su matrícula. \nAnte cualquier consulta no dude en contactarnos por medio del correo electrónico ccamon@gmail.com o al teléfono 25509449.\nSaludos!";
    enviar_correo($to, $subject, $message);
    
}

?>