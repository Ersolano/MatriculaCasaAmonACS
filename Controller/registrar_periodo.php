<?php

include '../Model/registroPeriodo.php';

function getIdProf($ced){
    $con = conectar();
    $sql = "SELECT idProfesor FROM Profesor WHERE $ced = Profesor.cedula_profesor ";
    $result = mysqli_query($con, $sql);
    $row = mysqli_fetch_assoc($result);
    $idProfesor = $row['idProfesor'];
    return $idProfesor;
}
function getIdCurso($nombreCurso){
    $con = conectar();
    $sql = "SELECT idCurso FROM `Curso` WHERE Curso.nombre ='$nombreCurso' ";
    $result = mysqli_query($con, $sql);
    $row = mysqli_fetch_assoc($result);
    $idCurso = $row['idCurso'];
    return $idCurso;
}
function getIdPeriodo(){
    $con = conectar();
    $sql = "SELECT idPeriodo FROM Periodo ORDER BY idPeriodo DESC LIMIT 1 ";
    $result = mysqli_query($con, $sql);
    $row = mysqli_fetch_assoc($result);
    $idPeriodo= $row['idPeriodo'];
    return $idPeriodo;
}

if($_POST){
    //datos tomados del formulario HTML
    $nombre = $_POST['nombre'];
    $fechaInicio = $_POST['fechaInicio'];
    $fechaFinal = $_POST['fechaFinal'];
    $fechaInicio1 = date('Y-m-d', strtotime($fechaInicio));
    $fechaFinal1 = date('Y-m-d', strtotime($fechaFinal));
    
    $fecha_InicioTime = new DateTime($fechaInicio);
    $fecha_FinalTime = new DateTime($fechaFinal);
    
    if($nombre == ""){
        echo "No se ha podido registrar. No ingresó nombre de periodo. ";
    }
    
    if ($fecha_InicioTime < $fecha_FinalTime) {
        //se invoca la función del modelo para registar el usuario en la base de datos.
        $resultado = registrar_periodo($nombre, $fechaInicio1, $fechaFinal1);
        if(!$resultado)
        {
            echo "No se ha podido registrar. ";
        }
        else
        {
            //Lista de cursos mostrados
            $cursos = explode(',', $_POST['cursosList']);
            //Si el curso está seleccionado lo agrega a la base con el periodo respectivo
            if (isset($_POST['cursos'])){
                foreach($_POST['cursos'] as $numFila){ //_POST['cursos'] nos da el valor de la fila
                    $instructor = "instructor".$numFila;
                    $cedProfesor = explode(' ',$_POST[$instructor])[0]; //Obtenemos la cédula
                    if($cedProfesor == '-1'){
                        echo "No se seleccionó instructor para un curso seleccionado\n";
                    }
                    $idInstructor = getIdProf($cedProfesor); //Con la función obtenemos el id de la tabla Profesor
                    $nombreCurso = substr($cursos[$numFila],0,-1); //Eliminamos el espacio del final para buscar el id
                    $idCurso = getIdCurso($nombreCurso);
                    //Obtenemos el último periodo que se agregó (el de la ventana)
                    $idPeriodo = getIdPeriodo();
                    
                    $resultado1 = registrar_cursoXperiodo($idCurso,$idPeriodo, $idInstructor);
                    if(!$resultado1)
                    {
                        echo "No se han seleccionado cursos.";
                    }
                    else{
                        echo "Periodo registrado exitosamente."."\n";    
                    }
                    
                }
            }else{
                echo "NO SE SELECCIONARON CURSOS";
            }
        }
    }
    else
    {
        echo "No se ha podido registrar. Fecha final está antes que la inicial";
    }
    
    
}
?>