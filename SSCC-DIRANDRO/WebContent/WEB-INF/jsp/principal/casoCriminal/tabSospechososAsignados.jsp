<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
function initSospechososAsignado(sospechosos){
	$("#divMostrarSospechosos").empty();
		$.each(sospechosos, function(i, sospechoso) {
			var imagen = '';
			
			if(sospechoso.urlSospechoso == null){
				imagen = '<img src="img/skills.png" alt="logo" style="width: 90px; height: 120px;" />';
			}else{
				imagen = '<img src="'+sospechoso.urlSospechoso+'" alt="logo" style="width: 90px; height: 120px;" />';
			}
			var sexo = '';
			if(sospechoso.sexo == 'M'){
				sexo = 'Masculino';
			}else if(sospechoso.sexo == 'F'){
				sexo = 'Femenino';
			}
			
			$("#divMostrarSospechosos").append(
					'<table class="table table-bordered table-condensed">'+
	 					'<tbody>'+
						'<tr>'+
							'<td rowspan="5" align="center" style="width: 90px; height: 100px;" id="tdImagen">'+imagen+'</td>'+
							'<td>Código Único de Identificación:</td>'+
							'<td align="center"><span id="hdrCodigoUnicoDeIdentificacion">'+sospechoso.codigoUnicoDeIdentificacion+'</span></td>'+
							'<td>Acción:</td>'+
							'<td><button class="btn btn-danger btn-mini asignar" id="cancelarAsigna_'+sospechoso.idSospechoso+'" type="button"><i class="icon-minus icon-white"></i></button></td>'+
						'</tr>'+
						'<tr>'+
							'<td colspan="2">Apellidos y Nombres:</td>'+
							'<td colspan="2"><span id="hdrPrimerApellido">'+sospechoso.primerApellido+'</span>&nbsp;<span id="hdrSegundoApellido">'+sospechoso.segundoApellido+'</span>&nbsp;<span id="hdrPrenombres">'+sospechoso.preNombres+'</span></td>'+
						'</tr>'+
						'<tr>'+
							'<td colspan="2">Alias:</td>'+
							'<td colspan="2"><a href="toSospechosoPrincipal-'+sospechoso.idSospechoso+'"><span id="hdrAlias">'+sospechoso.alias+'</span></a></td>'+
						'</tr>'+
						'<tr>'+
							'<td colspan="2">Sexo:</td>'+
							'<td colspan="2"><span id="hdrSexo">'+sexo+'</span></td>'+
						'</tr>'+
					'</tbody>'+
				'</table>');
		});
}

$(document).on('click','.asignar', function(e){
	var id1 = (this.id).split("_")[0];
	var id2 = (this.id).split("_")[1];
	
	switch(id1){
		case 'cancelarAsigna':
			var respuesta = confirm('¿Esta seguro que desea quitar a este Investigado?');
			if(respuesta){
				$.ajax({
			 		url: 'deshasignarSospechoso-'+$("#hdnIdCaso").text()+"-"+id2,
			 		type: 'post',
			 		dataType: 'json',
			 		data: '',
			 		success: function(sospechosos){
			 			initSospechososAsignado(sospechosos);
			 		}
			 	});
			}			
		break;
	}
	
});

$(document).ready(function(){
	$(".datepicker").datepicker({dateFormat: 'dd/mm/yy'});
	//esto es para que los checkbox del editar esten en blanco cuando se carga la pagina
	$("#checkFemenino").prop("checked", false);
	$("#checkMasculino").prop("checked", false);
		
		$.ajax({
	 		url: 'getSopechososPorCaso-'+$("#hdnIdCaso").text(),
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(sospechosos){
	 			initSospechososAsignado(sospechosos);
	 		}
	 	});
		
		/* validacion para editar */
		$("#formAgregarSospechoso").validate({
			rules:{
				txtFecNac: {peruDate: true},
				txtEstatura: {doubleNumber: true},
				txtInscripcion: {peruDate: true},
				txtEmision: {peruDate: true},
				txtCodUnico: {number: true, minlength: 8, maxlength: 8},
				txtMultasElectorales: {number: true, maxlength:4}
			},
			messages:{
				txtFecNac: "Debe tener formato de fecha dd/mm/aaaa",
				txtEstatura: "Solo Números",
				txtInscripcion: "Debe tener formato de fecha dd/mm/aaaa",
				txtEmision: "Debe tener formato de fecha dd/mm/aaaa",
				txtCodUnico: "Sólo Números, 8 digitos",
				txtMultasElectorales: "Sólo Números"
			},
			submitHandler: function(form){
				//Se usa 1000-12-12 para que pase de la vista al controlador
				//y en el implements se seteara como null.
				if($("#txtFecNac").val() == ''){
					$("#hdnFecNac").val('1000-12-12');
				}
				
				if($("#txtInscripcion").val() == ''){
					$("#hdnFecIns").val('1000-12-12');
				}
				
				$("#hdnEstatura").val($("#txtEstatura").val());
				$("#hdnCodUnico").val($("#txtCodUnico").val());
				$("#hdnMultasElectorales").val($("#txtMultasElectorales").val());
				
				if($("#txtEmision").val() == ''){
					$("#hdnFecEmi").val('1000-12-12');
				}
				
				var idCasoCriminal = $("#hdnIdCaso").text();
				
				if($("#txtCodigo").val() == ''){
					$.ajax({
				 		url: 'crearSospechosoAlCaso-'+idCasoCriminal,
				 		type: 'post',
				 		dataType: 'json',
				 		data: $("#formAgregarSospechoso").serialize(),
				 		success: function(sospechosos){
				 			$("#divMostrarSospechosoAsignado").show();
				 			$("#divNuevoSospechoso").hide();
				 			$("#alertasMostrarSospechoso").show();
				 			$("#alertasMostrarSospechoso").append('<div class="alert alert-success" id="alertaError">'+
				 					'<a class="close" data-dismiss="alert">×</a>'+
				 					'<strong>Se creo y asigno correctamente el investigado.</strong>'+
				 				'</div>');
				 			vaciarFormulario();
				 			initSospechososAsignado(sospechosos);
				 		}
				 	});
				}else{
					$.ajax({
				 		url: 'crearSospechosoExistenteAlCaso-'+idCasoCriminal+"-"+$("#txtIdSospechosoAux").val(),
				 		type: 'post',
				 		dataType: 'json',
				 		data: '',
				 		success: function(sospechosos){
				 			if(sospechosos == null){
				 				$("#alertasMostrarSospechoso").show();
					 			$("#alertasMostrarSospechoso").append('<div class="alert alert-error" id="alertaError">'+
					 					'<a class="close" data-dismiss="alert">×</a>'+
					 					'<strong>Ya esta asignado este investigado.</strong>'+
					 				'</div>');
				 			}else{
				 				$("#divMostrarSospechosoAsignado").show();
					 			$("#divNuevoSospechoso").hide();
					 			$("#alertasMostrarSospechoso").show();
					 			$("#alertasMostrarSospechoso").append('<div class="alert alert-success" id="alertaError">'+
					 					'<a class="close" data-dismiss="alert">×</a>'+
					 					'<strong>Se asigno correctamente el investigado.</strong>'+
					 				'</div>');
					 			vaciarFormulario();
					 			initSospechososAsignado(sospechosos);	
				 			}				 			
				 		}
				 	});
				}
				
			}
		});
});

$(document).on('change','#txtFecNac', function(e){
	if($("#txtFecNac").val() != null){
		var fec  = $("#txtFecNac").val();
		$("#hdnFecNac").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});

$(document).on('change','#txtEmision', function(e){
	if($("#txtInscripcion").val() != null){
		var fec  = $("#txtInscripcion").val();
		$("#hdnFecIns").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});

$(document).on('change','#txtEmision', function(e){
	if($("#txtEmision").val() != null){
		var fec  = $("#txtEmision").val();
		$("#hdnFecEmi").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});

$(document).on('click','#btnCancelAgregarSospechoso', function(e){
	$("#divMostrarSospechosoAsignado").show();
	$("#divNuevoSospechoso").hide();
	vaciarFormulario();
});

$(document).on('click','#btnAgregarSospechosoNuevo', function(e){
	$("#divNuevoSospechoso").show();
	$("#divMostrarSospechosoAsignado").hide();
	$("#alertasAgregarSospechoso").show();
	$("#alertasAgregarSospechoso").append('<div class="alert alert-error" id="alertaError">'+
			'<a class="close" data-dismiss="alert">×</a>'+
			'<strong>Dejar en blanco el codigo de investigado si quiere agregar uno nuevo.</strong>'+
		'</div>');
});

function vaciarFormulario(){
	$("#txtCodigo").val("");
	$("#hdnCodUnico").val("");
	$("#txtCodUnico").val("");
	$("#txtPrimerApellido").val("");
	$("#txtSegundoApellido").val("");
	$("#txtPrenombres").val("");
	$("#txtAlias").val("");
	$("#checkMasculino").prop("checked",false);
	$("#checkFemenino").prop("checked",false);
	$("#txtFecNac").val("");
	$("#hdnFecNac").val("");
	$("#txtDepartamentoDeNacimiento").val("");
	$("#txtProvinciaDeNacimiento").val("");
	$("#txtDistritoDeNacimiento").val("");
	$("#selectGradoInstruccion").val("");
	$("#sltcEstadoCivil").val("");
	$("#txtEstatura").val("");
	$("#hdnEstatura").val("");
	$("#txtInscripcion").val("");
	$("#hdnFecIns").val("");
	$("#txtNombrePadre").val("");
	$("#txtNombreMadre").val("");
	$("#txtEmision").val("");
	$("#hdnFecEmi").val("");
	$("#txtRestriccion").val("");
	$("#txtDomicilio").val("");
	$("#txtDepartamentoDeDomicilio").val("");
	$("#txtProvinciaDeDomicilio").val("");
	$("#txtDistritoDeDomicilio").val("");
	$("#txtMultasElectorales").val("");
	$("#hdnMultasElectorales").val("");
}

function popUp(){
	var caracteristicas = "scrollTo,resizable=1,scrollbars=1,location=0";
  	nueva=window.open("popUpAsignarSospechoso", 'Popup', caracteristicas);
  	return false;
}
</script>
<div id="divSospechososAsignados">
	<div id="alertasMostrarSospechoso" style="display: none;">
	</div>
	<div id="divMostrarSospechosoAsignado">
		<form:form class="form-horizontal">
			<fieldset>
				<legend>
					<span class=""><span class="colored">///</span> Investigados Asignados al caso:</span>
					<span class="offset3"><button class="btn btn-primary btn-small asignar" type="button" id="btnAgregarSospechosoNuevo"><i class="icon-edit icon-white"></i> Agregar Investigado Nuevo</button></span>
				</legend>
				<div id="divMostrarSospechosos">
				
				</div>
			</fieldset>
		</form:form>
	</div>
	<div id="divNuevoSospechoso" style="display: none;">
		<div id="alertasAgregarSospechoso" style="display: none;">
		</div>		
		<fieldset class="well">
			<form:form class="form-horizontal span9" id="formAgregarSospechoso" action="agregarSospechoso" commandName="sospechoso">
		       	<legend class="span8">
			       	<span class="colored">///</span> Agregar Investigado Nuevo:
		       	</legend>
		       	<div class="span4">
		       		<div class="control-group">
		          		<label class="control-label">Código de Investigado: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="codigo" id="txtCodigo"> <button class="btn btn-primary btn-mini asignar" type="button" id="btnBuscarSospechoso" onclick="popUp()"><i class="icon-search icon-white"></i></button>
		          			<input type="hidden" id="txtIdSospechosoAux">
		          		</div>
		       		</div>		       		
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label" title="Código Único de Identificación">C.U.I: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtCodUnico" id="txtCodUnico">
		          			<input class="span2" type="hidden" name="codigoUnicoDeIdentificacion" id="hdnCodUnico">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Primer Apellido: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" id="txtPrimerApellido" name="primerApellido">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Segundo Apellido: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" id="txtSegundoApellido" name="segundoApellido">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Prenombres: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" id="txtPrenombres" name="preNombres">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Alias: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" id="txtAlias" name="alias" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Sexo: </label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="sexo" id="checkMasculino" value="M">Masculino
		          		</label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="sexo" id="checkFemenino" value="F">Femenino
		          		</label>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Fecha de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2 datepicker" type="text" name="txtFecNac" id="txtFecNac">
		          			<input class="span2" type="hidden" name="fechaDeNacimiento" id="hdnFecNac">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="departamentoDeNacimiento" id="txtDepartamentoDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="provinciaDeNacimiento" id="txtProvinciaDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="distritoDeNacimiento" id="txtDistritoDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Grado de Instrucción: </label>
		          		<div class="controls">
		          			<select class="span2" name="gradoDeInstruccion" id="selectGradoInstruccion">
		          				<option value="">No Precisa</option>
		          				<option>Preescolar</option>
		          				<option>Primaria</option>
		          				<option>Secundaria</option>
		          				<option>Superior</option>
				            </select>
		          		</div>
		       		</div>
		       		
		       	</div>
		       	<div class="span4">		       		
		       		<div class="control-group" id="divGrado">
		          		<label class="control-label">Estado Civil: </label>
		          		<div class="controls">
		          			<select class="span2" name="estadoCivil" id="sltcEstadoCivil">
		          				<option value="">No Precisa</option>
		          				<option>Casado</option>
		          				<option>Divorciado</option>
		          				<option>Soltero</option>
		          				<option>Viudo</option>
				            </select>
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Estatura: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtEstatura" id="txtEstatura">
		          			<input class="span2" type="hidden" name="estatura" id="hdnEstatura">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Fecha de Inscripción: </label>
		          		<div class="controls">
		          			<input class="span2 datepicker" type="text" name="txtInscripcion" id="txtInscripcion">
		          			<input class="span2" type="hidden" name="fechaDeInscripcion" id="hdnFecIns">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Nombre del Padre: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="nombrePadre" id="txtNombrePadre">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Nombre de la Madre: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="nombreMadre" id="txtNombreMadre">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Fecha de Emisión: </label>
		          		<div class="controls">
		          			<input class="span2 datepicker" type="text" name="txtEmision" id="txtEmision">
		          			<input class="span2" type="hidden" name="fechaDeEmision" id="hdnFecEmi">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Restricción: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="restriccion" id="txtRestriccion">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="domicilio" id="txtDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="departamentoDeDomicilio" id="txtDepartamentoDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="provinciaDeDomicilio" id="txtProvinciaDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="distritoDeDomicilio" id="txtDistritoDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Multas Electorales: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtMultasElectorales" id="txtMultasElectorales">
		          			<input class="span2" type="hidden" name="multasElectorales" id="hdnMultasElectorales">
		          		</div>
		       		</div>
		       	</div>
	       		<div class="form-actions span6">
		        	<button class="btn btn-success" id="btnGuardar" type="submit"><i class="icon-ok icon-white"></i> Guardar Investigado</button>
		        	<button class="btn btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset</button>
		        	<button class="btn btn-warning" type="button" id="btnCancelAgregarSospechoso"><i class="icon-arrow-left icon-white"></i> Cancel</button>
		        </div>  
			</form:form>
		</fieldset>
	</div>
</div>