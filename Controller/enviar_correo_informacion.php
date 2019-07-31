<?php


if ($_POST) {

    //datos tomados del formulario HTML



    $to = $_POST['to'];

    $subject= $_POST['subject'];

    $message = $_POST['message'];

	
	try {

		ini_set( 'display_errors', 1 );
		error_reporting( E_ALL );
		$from = "ccamon@gmail.com";
		$headers = "From:" . $from . "\r\n";
		$headers .= "MIME-Version: 1.0" . "\r\n";
		$headers .= "Content-type:text/html;charset=UTF-8" . "\r\b";
		
		mail($to, $subject, $message, $headers);
		echo 1;
	} catch(Exception $e) {
		echo -1;
	}
}

