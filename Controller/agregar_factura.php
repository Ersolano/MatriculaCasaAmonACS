<?php

include '../Model/agregarFactura.php';

if($_POST) {
    //datos tomados del formulario HTML, obtener id de la Matricula y el numero de factura
    $id_matricula = $_POST['idMatricula']; 
    $num_factura = $_POST['factura'];
    
    
    //se invoca la función del modelo para editar el usuario en la base de datos.
    if ($num_factura == ""){
        echo "No se ha podido actualizar, no se ingresó el número de factura. Intente nuevamente.";
    }
    else{
        $resultado = agregar_factura($id_matricula, $num_factura);   
    }

    //aqui se deben mostrar los mensajes respectivos y direccionar a otras páginas HTML
    if(!$resultado)
    {
        echo "No se ha podido actualizar, intente nuevamente.";
    }

    else

    {

        echo "Matrícula actualizada exitosamente.";

        echo "<br>";

        echo "<a href=\"../listarEstudiantes.html\">Volver</a>";

    }



}