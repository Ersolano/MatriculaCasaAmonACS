<?php

include 'enviarCorreo.php';

function enviar_correo_matricula_estado($to, $name, $curso, $horario, $estado){
    
    
    if (strcmp($estado, "Rechazado") === 0)
    {
        $subject = "Matrícula rechazada en el curso " . $curso;
        $message = "Estimado(a) " . $name . " de parte de Casa Cultural Amón le agradecemos su matrícula en el curso " . 
    $curso . ", el cual será impartido en el horario: " . $horario ."\n" . "Sin embargo, su matrícula ha sido rechazada. Puede ver más información en el sitio web, en su historial de matrícula. \nAnte cualquier consulta no dude en contactarnos por medio del correo electrónico ccamon@gmail.com o al teléfono 25509449.\nSaludos!";
        
    }
    else{
         $subject = "Matrícula aceptada en el curso " . $curso;
        $message = "Estimado(a) " . $name . " de parte de Casa Cultural Amón le agradecemos su matrícula en el curso " . 
    $curso . ", el cual será impartido en el horario: " . $horario ."\n" . "Su matrícula ha sido realizada con éxito. Puede ver más información en el sitio web, en su historial de matrícula. \nAnte cualquier consulta no dude en contactarnos por medio del correo electrónico ccamon@gmail.com o al teléfono 25509449.\nSaludos!";
    }
    
    enviar_correo($to, $subject, $message);
    
}

?>