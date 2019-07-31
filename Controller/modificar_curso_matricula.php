<?php

include '../Model/modificarCursoMatricula.php';

if($_POST) {

    //datos tomados del formulario HTML
    // Obtener id de la Matricula
    $id_matricula = $_POST['idMatricula']; 
    
    if (isset($_POST['cursos']))
    {
        $id_Curso_X_Periodo = $_POST['cursos'];
    }

    //se invoca la función del modelo para editar el usuario en la base de datos.

    $resultado = modificar_curso_matricula($id_Curso_X_Periodo, $id_matricula);


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