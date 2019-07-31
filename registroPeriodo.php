<?php
include 'db.php';
//Conectamos a la base

$con = conectar();

if (mysqli_connect_errno())
  {
  echo "Error con conexión MySQL: " . mysqli_connect_error();
  }

$query = "SELECT * FROM `Curso`";
$query2 = "SELECT Usuario.Cedula, Usuario.nombre, Usuario.primer_apellido, Usuario.segundo_apellido FROM `Usuario` INNER JOIN Profesor ON Usuario.cedula = Profesor.cedula_profesor"; 
$result = mysqli_query($con, $query);

//La lista de profesores a desplegar por curso

$indexProfe = 0;
$indexChecks = 0;
$options = "<option value = '-1' >Seleccione el instructor</option>";
$result2 = mysqli_query($con, $query2);
while($row2 = mysqli_fetch_array($result2)){
    $options = $options."<option>$row2[0] - $row2[1] $row2[2] $row2[3]</option>";
}


?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Casa Cultural Amón</title>

    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- FullCalendar -->
    <link href="../vendors/fullcalendar/dist/fullcalendar.min.css" rel="stylesheet">
    <link href="../vendors/fullcalendar/dist/fullcalendar.print.css" rel="stylesheet" media="print">
    <!-- bootstrap-datetimepicker -->
    <link href="../vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">
  </head>

<body onload="fun()" class="nav-md">
<div id="navigation"></div>
    <div class="container body">
      <div class="main_container">
     
        <!-- page content -->
        <div class="left_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Nuevo Periodo</h3>
              </div>


            </div>
            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Registro de Periodos</h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <form class="form-horizontal form-label-left" novalidate action="Controller/registrar_periodo.php" method="POST">
                        <form class="form-horizontal form-label-left">
                      <p>Complete la información solicitada (Todos los datos son requeridos)
                      </p>
                      <span class="section">Datos</span>
                     
                      <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Nombre <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="nombre" class="form-control col-md-7 col-xs-12" data-validate-length-range="6" data-validate-words="1" name="nombre" placeholder="II Periodo 2018" required="required" type="text">
                        </div>
                      </div>
		                
		                
		                <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="fecha_inicio">Fecha de Inicio <span class="required">*</span>
                        </label>
		                    <div class="col-md-6 col-sm-6 col-xs-12">
		                        <div class='input-group date' id='myDatepicker1'>
		                            <input id ="fechaInicio" name="fechaInicio" type='text'  placeholder="Ejemplo: 31-12-1950" class="form-control" required="required" />
		                            <span class="input-group-addon">
		                               <span class="glyphicon glyphicon-calendar"></span>
		                            </span>
		                        </div>
		                    </div>
		                </div>
		                
                        <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="fecha_final">Fecha Final <span class="required">*</span>
                        </label>
		                    <div class="col-md-6 col-sm-6 col-xs-12">
		                        <div class='input-group date' id='myDatepicker2'>
		                            <input id ="fechaFinal" name="fechaFinal" type='text'  placeholder="Ejemplo: 31-12-1950" class="form-control" required="required"/>
		                            <span class="input-group-addon">
		                               <span class="glyphicon glyphicon-calendar"></span>
		                            </span>
		                        </div>
		                    </div>
		                </div>
		                <!--
		                <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="fecha_inicio_lecciones">Fecha Inicio de lecciones <span class="required">*</span>
                        </label>
		                    <div class="col-md-6 col-sm-6 col-xs-12">
		                        <div class='input-group date' id='myDatepicker2'>
		                            <input id ="fecha_inicio_lecciones_in" name="fecha_inicio_lecciones_in" type='text'  placeholder="Ejemplo: 31-12-1950" class="form-control" required="required"/>
		                            <span class="input-group-addon">
		                               <span class="glyphicon glyphicon-calendar"></span>
		                            </span>
		                        </div>
		                    </div>
		                </div>
		                
		                <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="fecha_inicio_lecciones">Fecha Final de lecciones <span class="required">*</span>
                        </label>
		                    <div class="col-md-6 col-sm-6 col-xs-12">
		                        <div class='input-group date' id='myDatepicker2'>
		                            <input id ="fecha_fin_lecciones_in" name="fecha_fin_lecciones_in" type='text'  placeholder="Ejemplo: 31-12-1950" class="form-control" required="required"/>
		                            <span class="input-group-addon">
		                               <span class="glyphicon glyphicon-calendar"></span>
		                            </span>
		                        </div>
		                    </div>
		                </div>
		                -->
		                <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                              <div class="x_title">
                                <h2>Cursos disponibles</h2>
                                
                                <div class="clearfix"></div>
                              </div>
                              <div class="x_content">
                                <p class="text-muted font-13 m-b-30">
                                  Seleccionar los cursos que desea agregar en este periodo. Si el curso no está en el sistema puede agregarlo en la ventana de Registrar Curso.
                                </p>
                                <table id="datatable-checkbox" class="table table-striped table-bordered bulk_action">
                                  <thead>
                                    <tr>
                                    <th></th>
                                      <th>Nombre</th>
                                      <th>Cupo</th>
                                      <th>Horario</th>
                                      <th>Información</th>
                                      <th>Profesor</th>
                                    </tr>
                                  </thead>
                                  
                                  <tbody>
                                      
                                  <?php
                                    while($rows = mysqli_fetch_assoc($result))
                                    {
                                        $profes = "<select name = \"instructor$indexProfe\">";
                                        $profes = $profes.$options;
                                        $profes = $profes."</select>";
                                        $indexProfe ++;
                                        
                                  ?>
                                    <tr>
                                      <td>
            							 <input type="checkbox" name="cursos[]" id="check-all" class="flat" value=<?php echo $indexChecks;?>>
            							 <?php $indexChecks ++; ?>
            						  </td>
                                      <td><?php echo $rows['nombre']; ?> </td>
                                      <td><?php echo $rows['cupo']; ?> </td>
                                      <td><?php echo $rows['horario']; ?> </td>
                                      <td><?php echo $rows['informacion']; ?> </td>
                                      <td><?php echo $profes; ?></td>
                                    <?php
                                    }
                                    ?>
                                    </tr>
                                    
                                  </tbody>
                                </table>
                              </div>
                            </div>
                          </div>
                          
		                <input type="hidden" id="cursosList" name="cursosList" />
		                
		                
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-md-offset-3">
                          <button id="send" type="submit" class="btn btn-success">Registrar</button>
                          <button id="cancel" type="button" onclick="cancelar(this)" class="btn btn-primary" >
                            Volver
                        </button>
                        </div>
                      </div>
                    </form>
                    
                  </div>
                </div>
              </div>
            </div>
            
            
          </div>
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
            Casa Cultural Amón
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../vendors/nprogress/nprogress.js"></script>

	<!-- bootstrap-datetimepicker -->    
    <script src="../vendors/moment/min/moment.min.js"></script>
    <script src="../vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
    
<script>
    
    var table = document.getElementsByTagName("table")[0];
    var tbody = table.getElementsByTagName("tbody")[0];
    tbody.onclick = function (e) {
    e = e || window.event;
    var data = [];
    var target = e.srcElement || e.target;
    while (target && target.nodeName !== "TR") {
        target = target.parentNode;
    }
    if (target) {
        var cells = tbody.getElementsByTagName("td");
        for (var i = 0; i < cells.length; i++) {
            if (i%6==1){
                data.push(cells[i].innerHTML);    
            }
        }
    }
    document.getElementById("cursosList").value = data;
    //alert(data);
    }
</script>
    
<script>
    
    $('#myDatepicker2').datetimepicker({
        format: 'DD-MM-YYYY'
    });
    
    
    $('#myDatepicker1').datetimepicker({
        format: 'DD-MM-YYYY'
    });
</script>

<!--Funcion del botón Cancelar-->
<script>
function  cancelar(button) {
    //Aquí va la página anterior
    window.location.href = "index.html";
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

  </body>
</html>