<script>

	var queryString = decodeURIComponent(window.location.search);
	var array = queryString.split("=");
	var idd = array[array.length-1];
	document.cookie = "idcurso="+idd;
    function getCursoId(){
        return idd;
    }
    
</script>
<?php
   include 'db.php';
  //Conectamos a la base
    error_reporting(0);
  $con = conectar();

  if (mysqli_connect_errno())
    {
    echo "Error con conexión MySQL: " . mysqli_connect_error();
    }

  $ident = $_COOKIE['idcur'];
  //$id = "<script> document.write(idd) </script>";
  $query = "call obtener_lista_curso($ident)";
  $result = mysqli_query($con, $query);
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Lista de Curso</title>

    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Datatables -->
    <link href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">
  </head>

<body onload="fun()" class="nav-md">
<div id="navigation"></div>
    <div class="container body">
      <div class="main_container">

        <!-- <a href="index.html" class="site_title"><i class="fa fa-paw"></i> <span>Gentelella Alela!</span></a> -->

        <!-- page content -->
        <div class="center_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Lista de Curso</h3>
              </div>
            <div class="clearfix"></div>
            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Lista de Usuarios </h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <p class="text-muted font-13 m-b-30">
                      En esta tabla se muestran todos los usuarios del sistema registrados en el curso.
                    </p>
                    <table id="datatable" class="table table-striped table-bordered">
                      <thead>
                        <tr>
                          <th>Cédula</th>
                          <th>Nombre</th>
                          <th>Correo</th>
                          <th>Teléfono 1</th>
                          <th>Teléfono 2</th>
                          <th>Fecha de Nacimiento</th>
                          <th>Estado de Matrícula</th>
                          <th>Comprobante</th>
                          <th>Factura Electrónica</th>
                          <th>Comentarios</th>
                          <th>Editar</th>

                        </tr>
                      </thead>

                      <tbody>
                      <?php

                        while($rows = mysqli_fetch_assoc($result)){
	                  ?>
	                  <tr>
                        <td><?php echo $rows['cedula']; ?> </td>
                        <td><?php echo $rows['nombre']; ?> </td>
                        <td><?php echo $rows['correo']; ?> </td>
                        <td><?php echo $rows['telefono']; ?> </td>
                        <td><?php echo $rows['telefono2']; ?> </td>
                        <td><?php echo $rows['fecha_nacimiento']; ?> </td>
                        <td><?php echo $rows['estado']; ?> </td>
                        <td><?php echo $rows['numero_comprobante']; ?> </td>
                        <td><?php echo $rows['numero_factura_electronica']; ?> </td>
                        <td><?php echo $rows['comentario']; ?> </td>
                        <!--<td><a href="editarUsuario.html">Editar</a></td>
                        -->
                        <td class="text-center">
                            <button type="button" class="btn btn-info" onclick="getId(this)">Editar</button>
                        </td>
                       </tr>
                      <?php
                        }            
                      ?> 

                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            </div>
          </div>
        </div>
        <!-- /page content -->


      </div>
    </div>
    
    
    <script>
    function  getId(element) {
        var table = document.getElementById('datatable');
        var fila = element.parentNode.parentNode.rowIndex;
        var cedula = table.rows[fila].cells[0].innerHTML;
        var queryString = "?cedula=" + cedula;
        window.location.href = "editarUsuario.html" + queryString;
    }
    function fun(){
        $.ajax({
        		  url:   'Controller/obtener_tipo_usuario.php',
        		  type:  'GET',
        		  success:  function(response) {
        		    if(response == "Normal"){
                         $('#navigation').load('menu.html');
        		    }else if(response == "Editor"){
        		         $('#navigation').load('menuAsistenteEditor.html');
        		    }else if(response == "Gestor"){
        		         $('#navigation').load('menuAsistenteGestor.html');
        		    }else if(response == "Super"){
        		         $('#navigation').load('menuAdmin.html');
        		    }
        		  }
            });	
    }
    

    </script>
    
    <!-- jQuery -->
    <script src="../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../vendors/nprogress/nprogress.js"></script>
    <!-- iCheck -->
    <script src="../vendors/iCheck/icheck.min.js"></script>
    <!-- Datatables -->
    <script src="../vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="../vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="../vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="../vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="../vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="../vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="../vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="../vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
    <script src="../vendors/jszip/dist/jszip.min.js"></script>
    <script src="../vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="../vendors/pdfmake/build/vfs_fonts.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="opciones_tabla_busqueda.js"></script>
    <script src="../build/js/custom.min.js"></script>

  </body>
</html>