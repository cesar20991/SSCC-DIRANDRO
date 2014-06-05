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
			 		url: 'reAsignarPersonalPolicial-'+idCasoCriminal+"-"+$("#hdnIdUsuarioAux_"+idN).val(),
			 		type: 'post',
			 		dataType: 'json',
			 		data: '',
			 		success: function(casos){
			 			$("#tblAsignado_"+idN).remove();
			 		}
			 	});
			}				
		break;
	}
	
	if((this.id) == "btnAsignarPersonal"){
		$("#divMostrarPersonalAsignado").hide();
		$("#divAsignarPersonal").show();
		$.ajax({
	 		url: 'getPersonalPolicial',
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(jefes){
	 				llenarCombo = llenarCombo + '<option value="">No precisa</option>';
	 			$.each(jefes, function(i, jefe) {
	 				llenarCombo = llenarCombo + '<option value="'+jefe.idUsuario+'">'+jefe.nombreCompleto+'</option>';
	 			});
	 			$("#divSelectPersonal").empty();
	 			$("#divSelectPersonal").append('<select id="slctPersonal"></select>');
	 			$("#slctPersonal").append(llenarCombo);
	 		}
	 	});
		
	}else if((this.id) == "btnCancelar"){
		$("#divMostrarPersonalAsignado").show();
		$("#divAsignarPersonal").hide();
	}else if((this.id) == "GuardarAsigna"){
		if($("#slctPersonal").val() != ""){
			$.ajax({
		 		url: 'asignarPersonalPolicial-'+idCasoCriminal+"-"+$("#slctPersonal").val(),
		 		type: 'post',
		 		dataType: 'json',
		 		data: '',
		 		success: function(caso){
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
		 			$("#divMostrarPersonalAsignado").show();
		 			$("#divAsignarPersonal").hide();
		 		}
		 	});
		}else{
			$("#alertasTab2").show();
 			$("#alertasTab2").append('<div class="alert alert-error" id="alertaVerde">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        '<strong id="msgVerde">Debe Seleccionar a un Policia para Guardar.</strong>'+
				 			    '</div>');					
		}
	}
});
var llenarCombo = "";
var botonQuitar = '';
$(document).ready(function(){
	var idCaso = $("#hdnIdCaso").text();
	
	iniPersonalAsignadoPorCaso(idCaso);
	
});

function iniPersonalAsignadoPorCaso(idCaso){
	$.ajax({
 		url: 'getPersonalAsignado-'+idCaso,
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(policias){
			$("#divMostrarPersonal").empty();
			$.each(policias, function(i, policia){
				if(policia.cargo != 'Jefe de Unidad'){
					botonQuitar = '<button class="btn btn-danger btn-mini asignar" id="CancelarAsigna_'+i+'" type="button"><i class="icon-minus icon-white"></i></button>';
				}
				$("#divMostrarPersonal").append('<table class="table table-bordered table-condensed" id="tblAsignado_'+i+'">'+
													'<tbody>'+
														'<tr>'+
															'<td rowspan="4" align="center"><img src="img/skills.png" alt="logo"/></td>'+
															'<td>Nombre Completo:<input type="hidden" id="hdnIdUsuarioAux_'+i+'" value="'+policia.idUsuario+'"/></td>'+
															'<td align="center"><a href="toPerfil-'+policia.idPerfil+'"><span id="hdrApePaterno_'+i+'">'+policia.apePaterno+'</span>&nbsp;<span id="hdrApeMaterno_'+i+'">'+policia.apeMaterno+'</span>&nbsp;<span id="hdrPrimerNombe_'+i+'">'+policia.primerNombre+'</span>&nbsp;<span id="hdrSegundoNombe_'+i+'">'+policia.segundoNombre+'</span>&nbsp;(<span id="hdrCodigo_'+i+'">'+policia.codigoPerfil+'</span>)</a></td>'+
															'<td>Acciones:</td>'+
															'<td>'+botonQuitar+'</td>'+				
														'</tr>'+
														'<tr>'+
															'<td>Cargo:</td>'+
															'<td><span id="hdrCargo_'+i+'">'+policia.cargo+'</span></td>'+
															'<td>Grado:</td>'+
															'<td><span id="hdrGrado_'+i+'">'+policia.grado+'</span></td>'+
														'</tr>'+
														'<tr>'+
															'<td>Rango:</td>'+
															'<td><span id="hdrRango_'+i+'">'+policia.rango+'</span></td>'+
															'<td>N° Carnet:</td>'+
															'<td><span id="hdrNCarnet_'+i+'">'+policia.numeroDeCarnet+'</span></td>'+
														'</tr>'+
														'<tr>'+
															'<td>Correo Electrónico:</td>'+
															'<td><span id="hdrCorreo_'+i+'">'+policia.correoElectronico+'</span></td>'+
															'<td>Entidad:</td>'+
															'<td><span id="hdrEntidad_'+i+'">DIRANDRO</span></td>'+
														'</tr>'+
													'</tbody>'+
												'</table>');
				botonQuitar = '';
			});
 		}
 	});
}
</script>
<div id="divCasoCriminal">
	<div id="alertasTab2" style="display: none;">
	</div>
	<div id="divMostrarPersonalAsignado">
		<form:form class="form-horizontal">
			<fieldset>
				<legend>
					<span class=""><span class="colored">///</span> Personal Asignado al caso:</span>
					<span class="offset3"><button class="btn btn-primary btn-small asignar" type="button" id="btnAsignarPersonal"><i class="icon-edit icon-white"></i> Asignar Personal</button></span>
				</legend>
				<div id="divMostrarPersonal">
				
				</div>
			</fieldset>
		</form:form>
	</div>
	<div id="divAsignarPersonal" style="display: none;">
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
	</div>
</div>