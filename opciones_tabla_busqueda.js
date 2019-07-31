$(document).ready(function() {
    $('#datatable').DataTable( {
        "language": {
		    "decimal":        "",
		    "emptyTable":     "No hay datos disponibles",
		    "info":           "Mostrando de _START_ a _END_ de _TOTAL_ entradas",
		    "infoEmpty":      "Mostrando 0 a 0 de 0 entradas",
		    "infoFiltered":   "(Filtrado de _MAX_ entradas totales)",
		    "infoPostFix":    "",
		    "thousands":      ",",
		    "lengthMenu":     "Mostrar _MENU_ entradas",
		    "loadingRecords": "Cargando...",
		    "processing":     "Procesando...",
		    "search":         "Buscar:",
		    "zeroRecords":    "No se encontraron resultados",
		    "paginate": {
		        "first":      "Primero",
		        "last":       "Último",
		        "next":       "siguiente",
		        "previous":   "Anterior"
		    }
		}
    } );
} );