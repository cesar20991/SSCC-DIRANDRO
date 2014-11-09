<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Asignar Personal</title>
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
var llenarCombo = "";
var indicePol = 0;
function initAsignaCasos(casos){
	indiceCaso = 0;
	totalCasos = casos.length;
		$("#divResultadoSearch").empty();
		var resultado ='';
		resultado += '<table class="table table-striped table-bordered table-hover dataTable" id="tblCasos">'+
						'<thead>'+
							'<tr>'+
								'<th style="width: 400px;">Caso Criminal</th>'+
								'<th>Personal Policial</th>'+
								'<th>Asignar</th>'+
							'</tr>'+
						'</thead>'+
						'<tbody id="tblBody">';
		$.each(casos, function(i, caso) {
			resultado += '<tr>';
			resultado += '<td>'+caso.codigo+' ('+caso.referencia+')'+'<input type="hidden" name="idCaso" id="hdnCaso_'+indiceCaso+'" value="'+caso.idCasoCriminal+'"></td>';
			resultado += '<td id="tdAsignadorAgregar_'+indiceCaso+'"></td>'+
		          			'<td><button class="btn btn-outline btn-info asignar" id="buscarPersonal_'+indiceCaso+'" type="button" data-toggle="modal" data-target="#modalPersonalPolicial">Buscar</td>';
		    resultado += '</tr>';
			
			indiceCaso++;
		});
		resultado += '</tbody></table>';
		$("#divResultadoSearch").append(resultado);

		$("#tblCasos").dataTable(); 
}

function traerCasos(){
	$.ajax({
 		url: 'getCasosPersonal',
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(casos){
 			initAsignaCasos(casos);
	 		$.each(casos, function(i, caso) {
	 			$.ajax({
	 		 		url: 'getPersonalPolicialPorCaso-'+caso.idCasoCriminal,
	 		 		type: 'post',
	 		 		dataType: 'json',
	 		 		data: '',
	 		 		success: function(policias){
	 		 			$.each(policias, function(j, policia) {
	 		 				$("#tdAsignadorAgregar_"+i).append(
									'<span id="spnPolName_'+indicePol+'">'+
										''+policia.nombreCompleto+
										' <button class="btn btn-outline btn-danger btn-xs btn-circle asignar" id="CancelarAsigna_'+i+'_'+indicePol+'" type="button"><i class="fa fa-times"></i></button>'+
											'<input type="hidden" id="hdnIsUsuario_'+i+'_'+indicePol+'" name="" value="'+policia.idUsuario+'">'+
					          		'</span><br id="brPolName_'+indicePol+'">');
					 			indicePol++;
	 		 			});
	 		 		}
	 		 	});
	 		});
 		}
 	});
}

$(document).ready(function(){	
	
	$.ajax({
 		url: 'getPersonalPolicial',
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(jefes){
 			var resultado = '';
 			$.each(jefes, function(i, jefe) {
 				resultado += '<tr>'+
								'<td><img src="'+jefe.urlPerfil+'" style="width: 100%; height: 150%;"/></td>'+
				                '<td><a href="toPerfil-'+jefe.idPerfil+'"><span id="spnNombre_'+jefe.idUsuario+'">'+jefe.nombreCompleto+'</span></a></td>'+
				                '<td>'+jefe.dni+'</td>'+
				                '<td>'+jefe.numeroDeCarnet+'</td>'+
				                '<td>'+jefe.cargo+'</td>'+
				                '<td>'+jefe.grado+'</td>'+
				                '<td>'+jefe.rango+'</td>'+
				                '<td>'+jefe.entidadPerteneciente+'</td>'+
				                '<td>'+jefe.correoElectronico+'</td>'+
				                '<td>'+jefe.telefono+'</td>'+
				                '<td>'+jefe.sexo+'</td>'+
				                '<td><button type="button" class="btn btn-outline btn-primary btn-circle asignar" id="GuardarAsigna_'+jefe.idUsuario+'"><i class="fa fa-check"></i></button></td>'+
				            '</tr>';
 			});
 			$("#dataTablesPersonal").append(resultado);
	  		$('#dataTablesPersonal').dataTable();
 			traerCasos();
 		}
 	});	 	
	
});

$(document).on('click','.asignar', function(e){
	var id = this.id;
	var idA = id.split("_")[0];
	var idN = id.split("_")[1];
	var idN2 = id.split("_")[2];
	
	switch(idA){
		case 'buscarPersonal':
			$("#hdnIdCasoSeleccionado").val($("#hdnCaso_"+idN).val());
		break;
		case 'CancelarAsigna':
			var respuesta = confirm('¿Esta seguro que desea quitar a este agente?');
			if(respuesta){
				$.ajax({
			 		url: 'reAsignarPersonalPolicial-'+$("#hdnCaso_"+idN).val()+"-"+$("#hdnIsUsuario_"+idN+"_"+idN2).val(),
			 		type: 'post',
			 		dataType: 'json',
			 		data: '',
			 		success: function(casos){
			 			$("#spnPolName_"+idN2).remove();
			 			$("#brPolName_"+idN2).remove();
			 		}
			 	});
			}				
		break;
		case 'GuardarAsigna':
			//if($("#slctPol_"+idN).val() != ""){
			$.ajax({
		 		url: 'asignarPersonalPolicial-'+$("#hdnIdCasoSeleccionado").val()+"-"+idN,
		 		type: 'post',
		 		dataType: 'json',
		 		data: '',
		 		success: function(caso){
		 			//initAsignaCasos(casos);
		 			if(caso){
		 				/*$("#tdAsignadorAgregar_"+idN).append(
								'<div id="divPolName_'+indicePol+'">'+
									''+$("#slctPol_"+idN+" option:selected").html()+
									' <button class="btn btn-danger btn-mini asignar" id="CancelarAsigna_'+idN+'_'+indicePol+'" type="button"><i class="icon-minus icon-white"></i></button>'+
										'<input type="hidden" id="hdnIsUsuario_'+idN+'_'+indicePol+'" name="" value="'+$("#slctPol_"+idN).val()+'">'+
				          			''+
				          		'</div>');
				 			$("#slctPol_"+idN).val("");
				 			indicePol++;
				 		alert("Asignado Correctamente.");*/
				 		$("#alertasAsignarCaso").show();
			 			$("#alertasAsignarCaso").append('<div class="alert alert-success" id="alertaVerde">'+
								 			        '<a class="close" data-dismiss="alert">×</a>'+
								 			        '<strong id="msgVerde">Asignado Correctamente.</strong>'+
								 			    '</div>');
		 				traerCasos();
		 			}else{
		 				alert($("#spnNombre_"+idN).text()+" ya esta asignado(a) al caso.");
		 			}			 			
		 		}
		 	});
			/*}else{
				alert("Debe Seleccionar una opcion.");					
			}*/
					
		break;
	}
});
</script>
</head>
<body>

	<!--HEADER-->
	<jsp:include page="../componentes/newHeader.jsp" />
	<!--/HEADER-->
	<!--CENTRO-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
			<div class="col-lg-12" id="titulo">
				<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
			</div>
			<div class="table-responsive">
	       		<div id="divResultadoSearch" class="dataTables_wrapper form-inline" role="grid">
	       			
						
	       		</div>
	       	</div>			
		</div>
	</div>
	<!-- MODAL -->
	<div class="modal fade" id="modalPersonalPolicial" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
       <div class="modal-dialog">
           <div class="modal-content" style="width: 200%; margin-left: -50%;">
               <div class="modal-header">
                   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                   <h4 class="modal-title" id="myModalLabel">Personal Policial</h4>
                   <input type="hidden" id="hdnIdCasoSeleccionado"/>
               </div>
               <div class="modal-body">
               <div id="alertasAsignarCaso" class="col-lg-12" style="display: none;">
				</div>
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
</body>
</html>