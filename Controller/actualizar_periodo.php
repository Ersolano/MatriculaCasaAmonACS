<?php



include '../Model/periodo.php';



if($_POST) {

    //datos tomados del formulario HTML


    $id = $_POST['id'];

    $fecha = $_POST['fecha'];



    //se invoca la función del modelo para editar el periodo en la base de datos.

    $resultado = actualizarPeriodo($fecha, $id);





    //aqui se deben mostrar los mensajes respectivos y direccionar a otras páginas HTML

    if(!$resultado)

    {

        echo "No se ha podido actualizar, intente nuevamente.";

    }

    else

    {

        echo "Periodo actualizado exitosamente.";

    }



}