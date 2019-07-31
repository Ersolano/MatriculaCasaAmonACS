<?php
//include 'db.php';


//Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado "obtener_usuario"
//Devuelve la variable result al controlador para realizar las validaciones respectivas
function obtener_datos_curso($idCursoXPeriodo)
{
    $con = conectar();
    
    $sql = "call obtener_datos_curso('$idCursoXPeriodo')";
    
    $result = mysqli_query($con, $sql);
    
    if(mysqli_num_rows($result) > 0){
        
        $fila = $result->fetch_row();
        return $fila;
        
    }
}


?>
