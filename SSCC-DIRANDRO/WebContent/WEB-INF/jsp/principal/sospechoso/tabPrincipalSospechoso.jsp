<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.controls{
	margin-top: 3px;
}
</style>
<script>
function init(sospechoso){
	//cabecera
	$("#hdrCodigoUnicoDeIdentificacion").empty();
	$("#hdrPrimerApellido").empty();
	$("#hdrSegundoApellido").empty();
	$("#hdrPrenombres").empty();
	$("#hdrAlias").empty();
	$("#hdrCaso").empty();
	//
	$("#hdrCodigoUnicoDeIdentificacion").append(sospechoso.codigoUnicoDeIdentificacion);
	$("#hdrPrimerApellido").append(sospechoso.primerApellido);
	$("#hdrSegundoApellido").append(sospechoso.segundoApellido);
	$("#hdrPrenombres").append(sospechoso.preNombres);
	$("#hdrAlias").append(sospechoso.alias);
	//$("#hdrCaso").append(sospechoso.);
	//tabPrincipal
	$("#spnCodigoUnicoDeIdentificacion").empty();
	$("#spnPrimerApellido").empty();
	$("#spnSegundoApellido").empty();
	$("#spnPrenombres").empty();
	$("#spnAlias").empty();
	$("#spnSexo").empty();
	$("#spnFecNac").empty();
	$("#spnGradoInstruccion").empty();
	
	$("#spnCodigoUnicoDeIdentificacion").append(sospechoso.codigoUnicoDeIdentificacion);
	$("#spnPrimerApellido").append(sospechoso.primerApellido);
	$("#spnSegundoApellido").append(sospechoso.segundoApellido);
	$("#spnPrenombres").append(sospechoso.preNombres);
	$("#spnAlias").append(sospechoso.alias);
	if(sospechoso.sexo == 'F'){
		$("#spnSexo").append("Femenino");
	}else{
		$("#spnSexo").append("Masculino");
	}	 			
	
	var fec  = sospechoso.fechaDeNacimiento;
	$("#spnFecNac").append(fec.split("-")[2]+"/"+fec.split("-")[1]+"/"+fec.split("-")[0]);
	
	//$("#spnFecNac").append(sospechoso.fechaDeNacimiento);
	$("#spnGradoInstruccion").append(sospechoso.gradoDeInstruccion);
}

$(document).ready(function(){
	$(".datepicker").datepicker({dateFormat: 'dd/mm/yy'});
	//esto es para que los checkbox del editar esten en blanco cuando se carga la pagina
	$("#checkFemenino").prop("checked", false);
	$("#checkMasculino").prop("checked", false);
	
	var idSospechoso = $("#hdnIdSospechoso").text();
	
		$.ajax({
	 		url: 'getSopechoso-'+idSospechoso,
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(sospechoso){
	 			init(sospechoso);
	 		}
	 	});
		
		/* validacion para editar */
		$("#formEditarSospechoso").validate({
			rules:{
				txtFecNac: {peruDate: true},
				//txtEstatura: {number: true},
				//txtInscripcion: {date: true},
				//txtEmision: {date: true},
				txtCodUnico: {number: true, minlength: 8, maxlength: 8}
			},
			messages:{
				txtFecNac: "Debe tener formato de fecha dd/mm/aaaa",
				//txtEstatura: "Solo Números",
				//txtInscripcion: "Debe tener formato de fecha dd/mm/aaaa",
				//txtEmision: "Debe tener formato de fecha dd/mm/aaaa",
				txtCodUnico: "Solo Números, 8 digitos"
			},
			submitHandler: function(form){
				//Se usa 1000-12-12 para que pase de la vista al controlador
				//y en el implements se seteara como null.
				if($("#txtFecNac").val() == ''){
					$("#hdnFecNac").val('1000-12-12');
				}
				
				/*if($("#txtInscripcion").val() == ''){
					$("#hdnFecIns").val('1000-12-12');
				}*/
				
				/*$("#hdnEstatura").val($("#txtEstatura").val());*/
				$("#hdnCodUnico").val($("#txtCodUnico").val());
				
				/*if($("#txtEmision").val() == ''){
					$("#hdnFecEmi").val('1000-12-12');
				}*/
				//$("#hdnFecEmi").val($("#txtEmision").val());

				$.ajax({
			 		url: 'editarSopechoso',
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarSospechoso").serialize(),
			 		success: function(sospechoso){
			 			init(sospechoso);
			 			$("#divMostrarSospechoso").show();
			 			$("#divEditarSospechoso").hide();
			 		}
			 	});
			}
		});
});

$(document).on('change','#txtFecNac', function(e){
	var fec  = $("#txtFecNac").val();
	$("#hdnFecNac").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);
});

$(document).on('click','#btnEditarSopechoso', function(e){
	$("#txtCodUnico").val($("#spnCodigoUnicoDeIdentificacion").text());
	$("#txtPrimerApellido").val($("#spnPrimerApellido").text());
	$("#txtSegundoApellido").val($("#spnSegundoApellido").text());
	$("#txtPrenombres").val($("#spnPrenombres").text());
	$("#txtAlias").val($("#spnAlias").text());
	
	if($("#spnSexo").text() == 'Masculino'){
		$("#checkMasculino").prop("checked",true);
	}else{
		$("#checkFemenino").prop("checked",true);
	}
	$("#txtFecNac").val($("#spnFecNac").text());
	$("#selectGradoInstruccion").val($("#spnGradoInstruccion").text());
	
	$("#hdnIdSospechosoEdit").val($("#hdnIdSospechoso").text());
	
	$("#divMostrarSospechoso").hide();
	$("#divEditarSospechoso").show();
});

$(document).on('click','#btnCancelEditar', function(e){
	$("#divMostrarSospechoso").show();
	$("#divEditarSospechoso").hide();
});
</script>
<div id="divMostrarDatosSospechoso">
	<div id="divMostrarSospechoso">
		<form:form class="form-horizontal">
	       	<legend><span class="span3"><span class="colored">///</span> Datos del Sospechoso:</span><span class="span2 offset3"><span class="btn btn-primary btn-small" id="btnEditarSopechoso"><i class="icon-edit"></i> Editar</span></span></legend>
	       		<div class="control-group">
	          		<label class="control-label">C.U.I: </label>
	          		<div class="controls">
	          			<span id="spnCodigoUnicoDeIdentificacion">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Apellidos: </label>
	          		<div class="controls">
	          			<span id="spnPrimerApellido">&nbsp;</span>&nbsp;&nbsp;<span id="spnSegundoApellido">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Prenombres: </label>
	          		<div class="controls">
	          			<span id="spnPrenombres">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Alias: </label>
	          		<div class="controls">
	          			<span id="spnAlias">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Grado de Instrucción: </label>
	          		<div class="controls">
	          			<span id="spnGradoInstruccion">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Sexo: </label>
	          		<div class="controls">
	          			<span id="spnSexo">&nbsp;</span>
	          		</div>
	       		</div> 
	       		<div class="control-group">
	          		<label class="control-label">Fecha de Nacimiento: </label>
	          		<div class="controls">
	          			<span id="spnFecNac">&nbsp;</span>
	          		</div>
	       		</div>       
		</form:form>
	</div>
		
	<!-- <section> -->
		<fieldset class="well" style="display: none;" id="divEditarSospechoso">
			<form:form class="form-horizontal" id="formEditarSospechoso" action="editarSospechoso" commandName="sospechoso">
		       	<legend><span class="colored">///</span> Editar Datos Personales del Sospechoso:</legend>
		       		<input type="hidden" name="idSospechoso" id="hdnIdSospechosoEdit">
		       		<div class="control-group">
		          		<label class="control-label">Código Único de Identificación: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtCodUnico" id="txtCodUnico" data-rule-required="true" data-msg-required="*">
		          			<input class="span2" type="hidden" name="codigoUnicoDeIdentificacion" id="hdnCodUnico">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Primer Apellido: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" id="txtPrimerApellido" name="primerApellido" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Segundo Apellido: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" id="txtSegundoApellido" name="segundoApellido" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Prenombres: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" id="txtPrenombres" name="preNombres" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Alias: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" id="txtAlias" name="alias">
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
		       		<!-- <hr>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="departamentoDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="provinciaDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="distritoDeNacimiento">
		          		</div>
		       		</div> -->
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
		       		<!-- <hr>
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
		          			<input class="span2" type="text" name="nombrePadre">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Nombre de la Madre: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="nombreMadre">
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
		          			<input class="span2" type="text" name="restriccion">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="domicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="departamentoDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="provinciaDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="distritoDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Multas Electorales: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="multasElectoraleso">
		          		</div>
		       		</div> -->
		       		<div class="form-actions">
			        	<button class="btn btn-success" id="btnGuardar" type="submit"><i class="icon-ok icon-white"></i> Guardar Sospechoso</button>
			        	<button class="btn btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset</button>
			        	<button class="btn btn-warning" type="button" id="btnCancelEditar"><i class="icon-arrow-left icon-white"></i> Cancel</button>
			        </div>  
			</form:form>
		</fieldset>
	<!-- </section> -->
</div>

