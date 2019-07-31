<?php
$idMatricula = $_GET['mat'];

include 'db.php';
//Conectamos a la base

$con = conectar();

if (mysqli_connect_errno())
  {
  echo "Error con conexión MySQL: " . mysqli_connect_error();
  }
 //($rows = mysqli_fetch_assoc($result))

$idMatricula2 = $idMatricula;

$query = "call obtener_profesor(".$idMatricula.")";
$query2 = "call obtener_horario_informe(".$idMatricula2.")";


$resultado = mysqli_query($con, $query);
$resultado2 = mysqli_query($con, $query2);

$profesor = "";
$names = mysqli_fetch_array($resultado);
$profesor = $names[0]." ".$names[1]." ".$names[2];


?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Asistente|Generar Informe </title>

    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    
    <!-- Custom styling plus plugins -->
    <link href="../build/css/custom.min.css" rel="stylesheet">
    
    <!-- Para exportar PDF-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.js"></script>
  </head>

  
<body onload="fun()" class="nav-md">
<div id="navigation"></div>
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="clearfix"></div>
          </div>
        </div>

        <!-- page content -->
        <div class="right_col" role="main" id = "factura">
          <div class="" >
            <div class="page-title">
              <div class="title_left">
                <h3>INFORME DE  MATRÍCULA</h3>
              </div>
              <div class="clearfix"></div>
              
              <div class="title_left">
                    <h2>CASA CULTURAL AMÓN<br>
                    CÉD. JURÍDICA: 3-002-212685<br>
                    TEL: 2257-0470 EXT:129<br>
                    CEL: 8655-2026<br>
                    CORREO: ccamon@itcr.ac.cr</h2>
                    <div class="clearfix"></div>
                  </div>
                  
                  <div class="title_right">
                    <h2>CURSOS DE EXTENSIÓN<br></h2>
                    <h2 id="num_comprobante">NÚMERO INFORME: <?php echo $idMatricula?><br></h2>
                    <h2 id="date">FECHA:</h2>
                    <div class="clearfix"></div>
                  </div>
              
            </div>

            <div class="clearfix"></div>
                <div class="x_panel">
                  
                  <div class="x_content">
                      
                      <form class="form-horizontal form-label-left" novalidate id="form-usuario"
                                          action="Controller/obtner_horario.php" method="POST">

                        <span class="section">Estudiante</span>
                          
                        <div class="form-group row">
                            <div class="col-xs-4">
                                <h2>Cédula</h2>
                                    <input id="cedula" class="form-control"
                                       name="cedula"
                                       value=""
                                       disabled
                                       required="required"
                                       type="text">
                            </div>

                            <div class="col-xs-8">
                                <h2>Nombre</h2>
                                    <input id="nombre" class="form-control"
                                       name="nombre"
                                       value=""
                                       disabled
                                       required="required"
                                       type="text">
                            </div>
                        </div>

                        
                        <span class="section">Curso</span>

                        <div class="form-group row">
                            <div class="col-xs-12">
                                <input id="curso" class="form-control input-lg"
                                       name="curso"
                                       value=""
                                       disabled
                                       required="required"
                                       type="text">
                            </div>
                            
                            <div class="form-group row">
                                <br><h2>Instructor</h2>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="instructor" class="form-control"
                                       data-validate-length-range="6" name="instructor"
                                       value="<?php echo $profesor ?>"
                                       disabled
                                       required="required"
                                       type="text">
                                </div>
                            </div>
                        
                            <div class="col-xs-6">
                                <h4>Periodo</h4>
                                <input id="periodo" class="form-control"
                                       data-validate-length-range="6" name="periodo"
                                       value=""
                                       disabled
                                       required="required"
                                       type="text">
                            </div>
                        </div>
                        
                        <span class="section">Pago</span>
                        
                        <div class="form-group row">
                            <div class="col-xs-4">
                                <h2>Forma de Pago </h2>
                                <input id="pagos" class="form-control"
                                       data-validate-length-range="6" name="pagos"
                                       value="Depósito"
                                       required="required"
                                       type="text">
                            </div>
                        
                            <div class="col-xs-3">
                                <h2>Monto</h2>
                                <input id="monto" class="form-control"
                                       data-validate-length-range="6" name="periodo"
                                       value="₡ 20 000.00 "
                                       required="required"
                                       type="text">
                            </div>
                        
                            <div class="col-xs-5">
                                <h2>Firma Asistente</h2>
                                <input id="asistente" class="form-control"
                                       data-validate-length-range="6" name="asistente"
                                       value=""
                                       required="required"
                                       type="text">
                            </div>
                        </div>
                    <div class="clearfix"></div>
                    </form>
                  </div>
                  <!--Input invisible para guardar el id de matrícula-->
                    <div class="item form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="hidden" id="idMatricula" class="form-control col-md-7 col-xs-12"
                                   name="idMatricula"
                                   value=""
                                   required="required">
                        </div>
                    </div>
                  
                    
                </div>
          </div>
        </div>
        <!-- /page content -->
        <footer>
          <div class="col-md-6 col-md-offset-3">
            <button id="cancel" type="button" onclick="cancelar(this)" class="btn btn-primary" >
                Volver
            </button>
            <button id="exportar" class="btn btn-success">
                Exportar
            </button>
            </div>
            <div class="clearfix"></div>
        </footer>
        
      </div>
    </div>
    
    <!-- Fecha -->
    <script>
    document.getElementById("date").innerHTML = "FECHA: " + new Date().toLocaleDateString();
    </script>
    <!-- jQuery -->
    <script src="../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../vendors/nprogress/nprogress.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
<!-- Código JS para exportar-->
<script>

$('#exportar').click(function () {
    html2canvas(document.getElementById('factura'),{
        onrendered: function(canvas){
            var img = canvas.toDataURL('image/png');
            var doc = new jsPDF('landscape');
            doc.addImage(img, 'JPEG', 2, 2);
            doc.save('test.pdf');
        }
    })
})
</script>

<script>
var queryString = decodeURIComponent(window.location.search);
//Obtenemos los datos cuando es redirigida de la búsqueda de usuarios

var n = queryString.indexOf("&");
var idMatricula = queryString.substring(5, n);

queryString = queryString.substring(n+1);
var n = queryString.indexOf("&");
cedula = queryString.substring(3, n);

queryString = queryString.substring(n+1);
n = queryString.indexOf("&");
var nombre = queryString.substring(4,n); // para eliminar &nom=

//Agregar primer apellido
queryString = queryString.substring(n+1);
n = queryString.indexOf("&");
nombre = nombre + " " + queryString.substring(4,n);

//Agregar segundo apellido
queryString = queryString.substring(n+1);
n = queryString.indexOf("&");
nombre = nombre + " " + queryString.substring(4,n);

queryString = queryString.substring(n+1);
n = queryString.indexOf("&");
var curso = queryString.substring(4,n);

queryString = queryString.substring(n+1);
var periodo = queryString.substring(4);

//Cargamos
document.getElementById("idMatricula").value = idMatricula;
document.getElementById("cedula").value = cedula;
document.getElementById("nombre").value = nombre;
document.getElementById("periodo").value = periodo;
document.getElementById("curso").value = curso;

</script>
<!--Funcion del botón Cancelar-->
<script>
function  cancelar(button) {
    //Aquí va la página anterior
    window.location.href = "index.html";
}

function fun(){
    $('#navigation').load('menuAsistenteGestor.html');
}
</script>

  </body>
</html>