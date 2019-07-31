<?php
include '../Model/variablesDeSesion.php';

function obtener_sesion(){
    $result = obtCed();
    return $result;
    
}

echo obtener_sesion();

?>