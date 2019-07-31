<?php

function obtener_datos_usuario($cedula)
{
    $con = conectar();
    
    $sql = "call obtener_datos_usuario('$cedula')";
    
    $result = mysqli_query($con, $sql);
    
    if(mysqli_num_rows($result) > 0){
        
        $fila = $result->fetch_row();
        return $fila;
        
    }
}


?>
