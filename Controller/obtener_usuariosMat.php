<?php



include '../Model/obtenerUsuariosMat.php';


    $id = $_POST['id'];
    $resultado = obtener_usuariosMat($id);


    $myArray = array();


    if (!$resultado) {

        echo 1;

    } else {

        if ($resultado->num_rows > 0) {

            while ($row = mysqli_fetch_row($resultado)) {
		#Nombre, Primer Apellido, Cédula, Nombre Curso, id, número comprobante, comprobante
		echo $row[0]."$".$row[1]."$".$row[2]."$".$row[3]."$".$row[4]."$".$row[5]."$".$row[6];

            }




        } else {

            echo "Error";	

        }


    }


