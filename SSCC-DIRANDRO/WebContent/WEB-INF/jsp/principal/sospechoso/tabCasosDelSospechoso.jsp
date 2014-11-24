<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.controls{
	margin-top: 3px;
}
</style>
<script>
function initCasoDelSospechoso(casos){
	$("#casoRelacionados").empty();
	var resultado = '';
		resultado +='<table class="table table-striped table-bordered table-hover dataTable" id="tblIniCasoSospechoso">'+
						'<thead>'+
							'<tr>'+
								'<th>Código</th>'+
		  						'<th>Asunto</th>'+
		  						'<th>Referencia</th>'+
		  						'<th>Descripción</th>'+
		  						'<th>Importancia</th>'+
		  						'<th>Estado</th>'+
		  						'<th>Desasignar</th>'+
							'</tr>'+
						'</thead>';
	$.each(casos, function(i, caso){
		resultado +='<tr>'+
				        '<td><a href="toCasoCriminal-'+caso.idCasoCriminal+'">'+caso.codigo+'</a></td>'+
				        '<td>'+caso.asunto+'</td>'+
				        '<td>'+caso.referencia+'</td>'+
				        '<td>'+caso.descripcion+'</td>'+
				        '<td>'+caso.importancia+'</td>'+
				        '<td>'+caso.estado+'</td>'+
				        '<td><button type="button" class="btn btn-outline btn-danger btn-xs btn-circle desasignar" id="desasignar_Caso_'+caso.idCasoCriminal+'"><i class="fa fa-minus"></i></button></td>'+
				    '</tr>';
	});
	
	resultado +='</table>';
	$("#casoRelacionados").append(resultado);
	$('#tblIniCasoSospechoso').dataTable();  				
// 	$.each(casos, function(i, caso) {
// 		var importancia = '';
// 		if(caso.importancia != ''){

// 			if(caso.importancia == 'Baja'){
// 				importancia += '( <span class="label">'+caso.importancia+'</span> )';
// 			}else if(caso.importancia == 'Media'){
// 				importancia += '( <span class="label label-warning">'+caso.importancia+'</span> )';
// 			}else if(caso.importancia == 'Alta'){
// 				importancia += '( <span class="label label-important">'+caso.importancia+'</span> )';
// 			}
// 		}else{
// 			importancia = '';
// 		}
// 		$("#casoRelacionados").append(
// 			'<table class="table table-bordered table-condensed">'+
// 					'<tbody>'+
// 					'<tr>'+
// 						'<td>Informe:</td>'+
// 						'<td align="center"><span id="hdrCodigoCaso"><a href="toCasoCriminal-'+caso.idCasoCriminal+'">'+caso.codigo+'</a> '+importancia+'</span></td>'+
// 						'<td>Estado:</td>'+
// 						'<td align="center"><span id="hdrEstado">'+caso.estado+'</span></td>'+
// 						'<td>Acciones:</td>'+
// 						'<td align="center"><button class="btn btn-danger btn-mini asignar" id="cancelarAsigna_'+caso.idCasoCriminal+'" type="button"><i class="icon-minus icon-white"></i></button></td>'+
// 					'</tr>'+
// 					'<tr>'+
// 						'<td colspan="2">Referencia:</td>'+
// 						'<td colspan="2"><span id="hdrReferencia">'+caso.referencia+'</span></td>'+
// 						'<td>Fecha de Creacion:</td>'+
// 						'<td><span id="hdrFecCreacion">'+timeStampFormatted(caso.fecCreacion)+'</span></td>'+
// 					'</tr>'+
// 					'<tr>'+
// 						'<td>Creado por:</td>'+
// 						'<td colspan="5"><span id="hdrCreador"><a href="toPerfil-'+caso.idPerfil+'">'+caso.nombreCompleto+'</a></span></td>'+					
// 					'</tr>'+
// 				'</tbody>'+
// 			'</table>');
// 	});
}

$(document).on('click','.asignar', function(e){
	var id1 = (this.id).split("_")[0];
	var id2 = (this.id).split("_")[1];
	var id3 = (this.id).split("_")[2];
	
	switch(id1){
		case 'cancelarAsigna':
			var respuesta = confirm('¿Esta seguro que desea quitar a este investigado?');
			if(respuesta){
				$.ajax({
			 		url: 'deshasignarCasoDelSospechoso-'+id2+"-"+$("#hdnIdSospechoso").text(),
			 		type: 'post',
			 		dataType: 'json',
			 		data: '',
			 		success: function(casos){
			 			initCasoDelSospechoso(casos);
			 		}
			 	});
			}			
		break;
		case 'guardarAsigna':
			$.ajax({
		 		url: 'asignarCasoToSospechoso-'+$("#hdnIdSospechoso").text()+"-"+id3,
		 		type: 'post',
		 		dataType: 'json',
		 		data: '',
		 		success: function(casos){
		 			initCasoDelSospechoso(casos);
		 		}
		 	});
		break;
	}
	
});

$(document).on('click','.desasignar', function(e){
	var id3 = (this.id).split("_")[2];
	var respuesta = confirm('¿Esta seguro que desea quitar a este investigado?');
	if(respuesta){
		$.ajax({
	 		url: 'desasignarCasoToSospechoso-'+$("#hdnIdSospechoso").text()+"-"+id3,
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(bienes){
	 			if(bienes == true){
	 				var idSospechoso = $("#hdnIdSospechoso").text();
	 				$.ajax({
	 			 		url: 'getCasosDelSospechoso-'+idSospechoso,
	 			 		type: 'post',
	 			 		dataType: 'json',
	 			 		data: '',
	 			 		success: function(casos){
	 			 			initCasoDelSospechoso(casos);
	 			 		}
	 			 	});
	 			}
	 		}
	 	});
	}	
});

$(document).ready(function(){
	
	var idSospechoso = $("#hdnIdSospechoso").text();
	
	$.ajax({
 		url: 'getCasosDelSospechoso-'+idSospechoso,
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(casos){
 			initCasoDelSospechoso(casos);
 		}
 	});
	
	$.ajax({
		url : 'getCasosCriminales',
		type : 'post',
		dataType : 'json',
		data : '',
		success : function(casos) {
			initAsignaCasos(casos);
		}
	});
		
});

function initAsignaCasos(casos){
	var resultado = '';
	$.each(casos, function(i, caso){						
						resultado += '<tr>'+
				        '<td><a href="toCasoCriminal-'+caso.idCasoCriminal+'">'+caso.codigo+'</a></td>'+
				        '<td>'+caso.asunto+'</td>'+
				        '<td>'+caso.referencia+'</td>'+
				        '<td>'+caso.descripcion+'</td>'+
				        '<td>'+caso.importancia+'</td>'+
				        '<td>'+caso.estado+'</td>'+
  						'<td><button type="button" class="btn btn-outline btn-primary btn-circle asignar" id="guardarAsigna_Caso_'+caso.idCasoCriminal+'" data-dismiss="modal"><i class="fa fa-check"></i></button></td>'+
  					'</tr>';
	});
	$("#tblCaso").append(resultado);
	$('#tblCaso').dataTable(); 
}

</script>
<!-- <div id="divMostrarCasosRelacionados"> -->
<!-- 	<div id="divMostrarCasos"> -->
<%-- 		<form:form class="form-horizontal"> --%>
<!-- 	       	<legend> -->
<!-- 		       	<span class=""><span class="colored">///</span> Casos Relacionados al Investigado:</span> -->
<!-- 		       	<span class="offset3"><button class="btn btn-primary" type="button" id="btnEditarSopechoso"><i class="icon-edit"></i> Editar</button></span> -->
<!-- 	       	</legend> -->
<!-- 	       	<div id="casoRelacionados"> -->
	       		
<!-- 	       	</div> -->
<%-- 		</form:form> --%>
<!-- 	</div> -->
		
	
<!-- </div> -->

<div id="divMostrarCasosAsignados">
	<div class="panel panel-default">
		<div class="panel-heading">
			/// Casos asignadoss al investigado:
			<div class="pull-right">
				<div class="btn-group">
					<button class="btn btn-outline btn-primary btn-sm asignar"
						data-toggle="modal" data-target="#modalCaso" type="button">
						<i class="fa fa-edit fa-fw"></i> Asignar Caso
					</button>					
				</div>
			</div>
		</div>
		<div class="panel-body">
			<div id="divMostrarCasos">
				<div class="panel panel-default">
					<div class="panel-heading">/// Casos relacionados</div>
					<div class="panel-body" id="mostrarCasos">
						<div class="table-responsive">
							<div id="casoRelacionados" class="dataTables_wrapper form-inline" role="grid">
							
							</div>
						</div>
					</div>
				</div>								
			</div>
		</div>
	</div>
</div>


<!-- MODAL -->
<div class="modal fade" id="modalCaso" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content" style="width: 200%; margin-left: -50%;">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">Casos Criminales</h4>
				<input type="hidden" id="hdnIdCasoSeleccionado" />
			</div>
			<div class="modal-body">
				<div class="table-responsive">
					<div id="divResultadoCaso"
						class="dataTables_wrapper form-inline" role="grid">
						<table class="table table-striped table-bordered table-hover dataTable" id="tblCaso">
							<thead>
								<tr>
									<th>Código</th>
									<th>Asunto</th>
									<th>Referencia</th>
									<th>Descripción</th>
									<th>Descripción</th>
									<th>Prioridad</th>
									<th>Asignar</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline btn-default"
					data-dismiss="modal">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- / MODAL -->