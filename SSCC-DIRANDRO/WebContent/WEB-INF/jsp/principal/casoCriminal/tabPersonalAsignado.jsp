<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(document).on('click','.asignar', function(e){
	var id = this.id;
	var idA = id.split("_")[0];
	var idN = id.split("_")[1];
	//var idN2 = id.split("_")[2];
	
	var idCasoCriminal = $("#hdnIdCaso").text();
	
	switch(idA){
		case 'CancelarAsigna':
			var respuesta = confirm('¿Esta seguro que desea quitar a este agente?');
			if(respuesta){
				$.ajax({
			 		url: 'reAsignarPersonalPolicial-'+idCasoCriminal+"-"+idN,
			 		type: 'post',
			 		dataType: 'json',
			 		data: '',
			 		success: function(casos){
			 			$("#tblAsignado_"+idN).remove();
			 			iniPersonalAsignadoPorCaso(idCasoCriminal);
			 		}
			 	});
			}				
		break;
		case 'guardarAsigna':
			$.ajax({
		 		url: 'asignarPersonalPolicial-'+idCasoCriminal+"-"+idN,
		 		type: 'post',
		 		dataType: 'json',
		 		data: '',
		 		success: function(caso){
 					$("#alertasTab2").empty();
		 			if(caso == true){
		 					iniPersonalAsignadoPorCaso(idCasoCriminal);
				 			$("#alertasTab2").show();
				 			$("#alertasTab2").append('<div class="alert alert-success" id="alertaVerde">'+
								 			        '<a class="close" data-dismiss="alert">×</a>'+
								 			        '<strong id="msgVerde">Asignado Correctamente.</strong>'+
								 			    '</div>');
		 			}else{
		 				$("#alertasTab2").show();
			 			$("#alertasTab2").append('<div class="alert alert-error" id="alertaVerde">'+
							 			        '<a class="close" data-dismiss="alert">×</a>'+
							 			        '<strong id="msgVerde">Este usuario ya esta asignado.</strong>'+
							 			    '</div>');
		 			}
		 		}
		 	});
		break;
	}
	
});
var llenarCombo = "";
var botonQuitar = '';
$(document).ready(function(){
	var idCaso = $("#hdnIdCaso").text();
	
	iniPersonalAsignadoPorCaso(idCaso);

	$.ajax({
 		url: 'getPersonalPolicialBuscar',
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
				                '<td><button type="button" class="btn btn-outline btn-primary btn-circle asignar" id="guardarAsigna_'+jefe.idUsuario+'" data-dismiss="modal"><i class="fa fa-check"></i></button></td>'+
				            '</tr>';
 			});
 			$("#modalPersonalAsignar").append(resultado);
	  		$('#modalPersonalAsignar').dataTable();
 		}
 	});
	
});
var jefeDeUnidad = 0;
var policiasInv = 0;
function iniPersonalAsignadoPorCaso(idCaso){
	$("#cuerpoTable").empty();
	$.ajax({
 		url: 'getPersonalAsignado-'+idCaso,
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(policias){
 			 var resultado = '';
			//$("#divMostrarPersonal").empty();
			$.each(policias, function(i, policia){
				if(policia.cargo != 'Jefe de Unidad'){
					botonQuitar = '<button class="btn btn-outline btn-danger btn-xs btn-circle asignar" id="CancelarAsigna_'+policia.idUsuario+'" type="button"><i class="fa fa-minus"></i></button>';
					policiasInv++;
				}else{
					jefeDeUnidad++;
				}
				
				resultado += '<tr id="tblAsignado_'+policia.idUsuario+'">'+
								'<td><a href="toPerfil-'+policia.idPerfil+'"><img src="'+policia.urlPerfil+'" alt="logo"/></a></td>'+
								'<td><a href="toPerfil-'+policia.idPerfil+'"><span id="hdrApePaterno_'+i+'">'+policia.apePaterno+'</span>&nbsp;<span id="hdrApeMaterno_'+i+'">'+policia.apeMaterno+'</span>&nbsp;<span id="hdrPrimerNombe_'+i+'">'+policia.primerNombre+'</span>&nbsp;<span id="hdrSegundoNombe_'+i+'">'+policia.segundoNombre+'</span>&nbsp;(<span id="hdrCodigo_'+i+'">'+policia.codigoPerfil+'</span>)</a></td>'+
								'<td>'+policia.cargo+'</td>'+
								'<td>'+policia.rango+'</td>'+
								'<td>'+policia.grado+'</td>'+
								'<td>'+policia.numeroDeCarnet+'</td>'+
								'<td>DIRANDRO</td>'+
								'<td>'+policia.correoElectronico+'</td>'+
								'<td>'+botonQuitar+'</td>'+
							'</tr>';
				botonQuitar = '';
			});
			$("#cuerpoTable").append(resultado);
	  		$('#dataTablesPersonal').dataTable();
			if((jefeDeUnidad == 0 && policiasInv == 0) || (jefeDeUnidad == 0) || (policiasInv == 0)){
				$("#alertasTab2").show();
	 			$("#alertasTab2").append('<div class="alert alert-info" id="alertaVerde">'+
									 			        '<a class="close" data-dismiss="alert">×</a>'+
									 			        'Recuerde Asignar un <strong>Jefe de unidad</strong> y al personal policial.'+
									 			    '</div>');
			}else if(jefeDeUnidad > 0 && policiasInv > 0){
				$("#alertasTab2").empty();
			}
 		}
 	});
}
</script>
<div id="divPersonalAsignado">
	<div id="alertasTab2" style="display: none;">
	</div>
	<div id="divMostrarPersonalAsignado">
		<div class="panel panel-default">
		    <div class="panel-heading">
		    	/// Personal Asignado al caso:
		    	<div class="pull-right">
					<div class="btn-group">
						<button class="btn btn-outline btn-primary btn-sm" type="button" id="btnAsignarPersonal" data-toggle="modal" data-target="#modalPersonal"><i class="fa fa-edit fa-fw"></i> Asignar Personal</button>
					</div>
				</div>
		    </div>
		    <div class="panel-body">
		    	<div id="divMostrarPersonal">
					<div class="table-responsive">
			       		<div id="divResultadoSearch" class="dataTables_wrapper form-inline" role="grid">
			       			<table class="table table-striped table-bordered table-hover dataTable" id="dataTablesPersonal">
				  					<thead>
					  					<tr>
					  						<td>Imagen</td>
					  						<td>Nombre Completo</td>
					  						<td>Cargo</td>
					  						<td>Jerarquía</td>
					  						<td>Grado</td>
					  						<td>N° Carnet</td>
					  						<td>Entidad</td>
					  						<td>Correo Electrónico</td>
					  						<td>Acción</td>
					  					</tr>
		  							</thead>
				  					<tbody id="cuerpoTable">
				  					</tbody>
	           				</table>
	       				</div>
	       			</div> 
				</div>
		    </div>
	    </div>				
	</div>
	
	<!-- <div id="divAsignarPersonal" style="display: none;">
		<fieldset class="well">
			<legend>
				<span class="colored">///</span> Asignar Personal Policial:
			</legend>
			<div class="control-group" id="divSelectPersonal">
				<select id="slctPersonal"></select>
			</div>
			<div class="form-actions">
				<button class="btn btn-success asignar" id="GuardarAsigna" type="button"><i class="icon-ok icon-white"></i> Asignar Personal</button>
		        <button class="btn btn-warning asignar" type="button" id="btnCancelar"><i class="icon-arrow-left icon-white"></i> Cancelar</button>
			</div>
		</fieldset>
	</div> -->
	
	<!-- MODAL -->
	<div class="modal fade" id="modalPersonal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
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
			       			<table class="table table-striped table-bordered table-hover dataTable" id="modalPersonalAsignar">
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