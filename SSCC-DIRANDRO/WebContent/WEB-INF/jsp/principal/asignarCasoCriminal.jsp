<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Asignar Caso</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- js -->
<script src="js/jquery-1.11.0.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/plugins/metisMenu/metisMenu.min.js"></script>
<script src="js/plugins/dataTables/jquery.dataTables.js"></script>
<script src="js/plugins/dataTables/dataTables.bootstrap.js"></script>
<script src="js/sb-admin-2.js"></script>
<script src="js/jquery.validate.min.js"></script>

<!-- styles -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
<link href="css/plugins/dataTables.bootstrap.css" rel="stylesheet">
<link href="css/plugins/timeline.css" rel="stylesheet">
<link href="css/sb-admin-2.css" rel="stylesheet">
<link href="css/plugins/morris.css" rel="stylesheet">
<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<script>
var totalCasos = 0;
var indiceCaso = 0;
var flag = false;
function initAsignaCasos(casos){
	indiceCaso = 0;
	totalCasos = casos.length;
	var resultado = '';
	$("#tblBodyCasos").empty();
		//$("#tblBody").empty();
		$.each(casos, function(i, caso) {
			resultado += '<tr>';
			resultado += '<td>'+caso.codigo+' ('+caso.referencia+')'+'<input type="hidden" name="idCaso" id="hdnCaso_'+indiceCaso+'" value="'+caso.idCasoCriminal+'"></td>';
			resultado += '<td id="spnJefeDeUnidad_'+indiceCaso+'"></td>';
			resultado += '<td id="btnAsignar_'+indiceCaso+'">'+
						'<button class="btn btn-outline btn-info asignar" id="asignar_'+indiceCaso+'" data-toggle="modal" data-target="#myModal">Buscar</button>'+
						'</td>';
			resultado += '</tr>';
			indiceCaso++;
		});
		$("#tblBodyCasos").append(resultado);
		$("#tblCasos").dataTable(); 
}

function getCasosInit(){
	$.ajax({
 		url: 'getCasos',
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(casos){
 			initAsignaCasos(casos);
 			$.each(casos, function(i, caso) {
 				$.ajax({
 	 		 		url: 'getJefeAsignado-'+caso.idCasoCriminal,
 	 		 		type: 'post',
 	 		 		dataType: 'json',
 	 		 		data: '',
 	 		 		success: function(jefe){
 	 		 			$("#spnJefeDeUnidad_"+i).empty();
 	 		 			if(jefe.nombreCompleto == null){
 							$("#spnJefeDeUnidad_"+i).append('');
 	 		 			}else{
 	 		 				$("#spnJefeDeUnidad_"+i).append(jefe.nombreCompleto);
 	 		 			}
 	 		 		}
 	 		 	});
 			});

 			
 		}
 	});		
}

$(document).ready(function(){
	getCasosInit();
	
	$.ajax({
 		url: 'getJefesDeUnidad',
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(jefes){
 			var resultado = '';
 			$.each(jefes, function(i, jefe) {
 				resultado += '<tr>'+
 								'<td><img src="'+jefe.urlPerfil+'" style="width: 100%; height: 150%;"/></td>'+
				                '<td><a href="toPerfil-'+jefe.idPerfil+'">'+jefe.nombreCompleto+'</a></td>'+
				                '<td>'+jefe.dni+'</td>'+
				                '<td>'+jefe.numeroDeCarnet+'</td>'+
				                '<td>'+jefe.cargo+'</td>'+
				                '<td>'+jefe.grado+'</td>'+
				                '<td>'+jefe.rango+'</td>'+
				                '<td>'+jefe.entidadPerteneciente+'</td>'+
				                '<td>'+jefe.correoElectronico+'</td>'+
				                '<td>'+jefe.telefono+'</td>'+
				                '<td>'+jefe.sexo+'</td>'+
				                '<td><button type="button" class="btn btn-outline btn-primary btn-circle asignar" id="guardarAsigna_'+jefe.idUsuario+'" data-dismiss="modal"><i class="fa fa-check"></i></button></td>'+
				            '</tr>';
 			});
 			$("#dataTablesPersonal").append(resultado);
	  		$('#dataTablesPersonal').dataTable();
 		}
 	});	
 	
	$(document).on('click','.asignar', function(e){
		var id = this.id;
		var idA = id.split("_")[0];
		var idN = id.split("_")[1];
		
		switch(idA){
			case 'asignar':
				$("#hdnIdCasoSeleccionado").val($("#hdnCaso_"+idN).val());
			break;
			case 'guardarAsigna':
				$.ajax({
			 		url: 'asignarCaso-'+$("#hdnIdCasoSeleccionado").val()+"-"+idN,
			 		type: 'post',
			 		dataType: 'json',
			 		data: '',
			 		success: function(casos){
			 			getCasosInit();
			 			$("#alertasAsignarCaso").show();
			 			$("#alertasAsignarCaso").append('<div class="alert alert-success" id="alertaVerde">'+
								 			        '<a class="close" data-dismiss="alert">×</a>'+
								 			        '<strong id="msgVerde">Asignado Correctamente.</strong>'+
								 			    '</div>');
			 		}
			 	});					
			break;
		}
		
		
	});
	
});
</script>
</head>
<body>
<div id="wrapper">
	<!--HEADER-->
	<jsp:include page="../componentes/newHeader.jsp" />
	<!--/HEADER-->
	<!--CENTRO-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
			<div class="col-lg-12" id="titulo">
				<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
			</div>
			<div id="alertasAsignarCaso" class="col-lg-12" style="display: none;">
			</div>
			<div class="table-responsive">
	       		<div id="divResultadoSearch" class="dataTables_wrapper form-inline" role="grid">
					<table class="table table-striped table-bordered table-hover dataTable" id="tblCasos">
						<thead>
							<tr>
								<th style="width: 400px;">Caso Criminal</th>
								<th>Jefe De Unidad</th>
								<th>Asignar</th>
							</tr>
						</thead>
						<tbody id="tblBodyCasos">
						</tbody> 
					</table>
				</div>
			</div>
		</div>
	</div>
	<!--/CENTRO-->
	<!-- MODAL -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
       <div class="modal-dialog">
           <div class="modal-content" style="width: 200%; margin-left: -50%;">
               <div class="modal-header">
                   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                   <h4 class="modal-title" id="myModalLabel">Jefes de Unidad</h4>
                   <input type="hidden" id="hdnIdCasoSeleccionado"/>
               </div>
               <div class="modal-body">
                   <div class="table-responsive">
			       		<div id="divResultadoSearch" class="dataTables_wrapper form-inline" role="grid">
			       			<table class="table table-striped table-bordered table-hover dataTable" id="dataTablesPersonal">
				  					<thead>
					  					<tr>
					  						<th>foto</th>
					  						<th>Nombre Completo</th>
					  						<th>DNI</th>
					  						<th>N° CIP</th>
					  						<th>Cargo</th>
					  						<th>Grado</th>
					  						<th>Jerarquia</th>
					  						<th>Entidad Perteneciente</th>
					  						<th>Corre Electrónico</th>
					  						<th>Teléfono</th>
					  						<th>Sexo</th>
					  						<th>Asignar</th>
					  					</tr>
				  					</thead>
			           		</table>
			       		</div>
			       	</div>
               </div>
               <div class="modal-footer">
                   <button type="button" class="btn btn-outline btn-default" data-dismiss="modal">Close</button>
               </div>
           </div>
           <!-- /.modal-content -->
       </div>
       <!-- /.modal-dialog -->
   	</div>
	<!-- / MODAL -->
</div>
</body>
</html>