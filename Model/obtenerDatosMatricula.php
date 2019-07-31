<?php

function obtener_datos_matricula($id)
{
    $con = conectar();
    
    $sql = "call obtener_datos_matricula('$id')";
    
    $result = mysqli_query($con, $sql);
    
    if(mysqli_num_rows($result) > 0){
        
        $fila = $result->fetch_row();
        return $fila;
        
    }
}


?>
