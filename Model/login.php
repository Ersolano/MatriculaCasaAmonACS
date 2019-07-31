<?php
include 'variablesDeSesion.php';
include 'db.php';


//Esta funcion recibe los parámetros necesarios para invocar el procedimiento almacenado "obtener_usuario"
//Devuelve la variable result al controlador para realizar las validaciones respectivas
function obtener_usuario($cedula, $clave)
{
    $con = conectar();
    
    $consulta = "call obtener_tipo_usuario('$cedula')";
    
    $sql = "call obtener_usuario('$cedula', '$clave')";
    
    $result = mysqli_query($con, $sql);
    if(mysqli_num_rows($result) > 0){
        $fila = $result->fetch_row();
        //Variable de sesion
        actCed($fila[0]);
		$result = 1;
		 $con = conectar();
    
        $resultado = mysqli_query($con, $consulta);
        if(mysqli_num_rows($resultado) > 0){
            $fila2 = $resultado->fetch_row();
            actTipoUsuario($fila2[0]);
            if($fila2[1] == "activo"){ //Cambia la dirección según el usuario
                if($fila2[0] == "Editor"){
                    header("Location: ../listarEstudiantes.html");
                    die();
                }else if($fila2[0] == "Gestor"){
                    header("Location: ../listarEstudiantes.html");
                    die();
                }else if($fila2[0] == "Super"){
                    header("Location: ../listarEstudiantes.html");
                    die();
                }
            }else{ // Usuario Inactivo 
                $result = 0;
            }
    
        }else{
            actTipoUsuario("Normal");
            if($result == "1"){//Datos correctos 
            header("Location: ../matricular.html");
            die();
        }
        }
    }
    
    return $result;

}
		
?>
