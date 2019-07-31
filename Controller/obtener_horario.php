<?php
include '../Model/obtenerHorario.php';

//echo $_POST['idMatricula']; 
if($_POST) {
    
    //datos tomados del formulario HTML
    // Obtener id de la Matricula
    $id_matricula = $_POST['idMatricula']; 
    //echo $id_matricula;
    //se invoca la función del modelo para obtener la informacion.

    $resultado = obtener_horario( $id_matricula);
    //aqui se deben mostrar los mensajes respectivos y direccionar a otras páginas HTML

    if(!$resultado)

    {
        echo "Error";

    }

    else
    {

        $row = mysqli_fetch_row($resultado) ;
        echo "$row[0]";

    }

}

?>