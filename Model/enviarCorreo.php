<?php

function enviar_correo($to, $subject, $message)
{
    ini_set( 'display_errors', 1 );
    error_reporting( E_ALL );
    $from = "ccamon@gmail.com";
    $headers = "From:" . $from;
  
    mail($to, $subject, $message, $headers);

}
		
?>
