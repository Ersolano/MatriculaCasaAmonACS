<?php 
session_start();

function actCed($cedula){
    $_SESSION["cedula"] = $cedula;
    //echo $_SESSION["cedula"];
}

function obtCed(){
    return $_SESSION["cedula"];
}

function actTipoUsuario($tipo){
    $_SESSION["tipo"] = $tipo;
}

function obtTipoUsuario(){
    return $_SESSION["tipo"];
}
?>