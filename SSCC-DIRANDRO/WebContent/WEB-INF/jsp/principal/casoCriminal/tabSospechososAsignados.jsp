<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
$(document).ready(function(){
	$(".datepicker").datepicker({dateFormat: 'dd/mm/yy'});
	//esto es para que los checkbox del editar esten en blanco cuando se carga la pagina
	$("#checkFemenino").prop("checked", false);
	$("#checkMasculino").prop("checked", false);
		
		/*$.ajax({
	 		url: 'getSopechoso-'+idSospechoso,
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(sospechoso){
	 			initSospechoso(sospechoso);
	 		}
	 	});*/
		
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
				
				/*$("#hdnEstatura").val($("#txtEstatura").val());*/
				$("#hdnCodUnico").val($("#txtCodUnico").val());
				
				if($("#txtEmision").val() == ''){
					$("#hdnFecEmi").val('1000-12-12');
				}
				//$("#hdnFecEmi").val($("#txtEmision").val());
				var idCasoCriminal = $("#hdnIdCaso").text();
				
				/*$.ajax({
			 		url: 'agregarSospechosoAlCaso-'+idCasoCriminal,
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formAgregarSospechoso").serialize(),
			 		success: function(sospechoso){
			 			$("#divMostrarSospechoso").show();
			 			$("#divEditarSospechoso").hide();
			 		}
			 	});*/
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
	$("#divMostrarPersonalAsignado").show();
	$("#divNuevoSospechoso").hide();
});

$(document).on('click','#btnAgregarSospechosoNuevo', function(e){
	
	$("#divMostrarPersonalAsignado").hide();
	$("#divNuevoSospechoso").show();
});

</script>
<div id="divPersonalAsignado">
	<div id="alertasTab2" style="display: none;">
	</div>
	<div id="divMostrarPersonalAsignado">
		<form:form class="form-horizontal">
			<fieldset>
				<legend>
					<span class=""><span class="colored">///</span> Sospechosos Asignados al caso:</span>
					<span class="offset3"><button class="btn btn-primary btn-small asignar" type="button" id="btnAgregarSospechosoNuevo"><i class="icon-edit icon-white"></i> Agregar Sospechoso Nuevo</button></span>
				</legend>
				<div id="divMostrarPersonal">
				
				</div>
			</fieldset>
		</form:form>
	</div>
	<div id="divNuevoSospechoso" style="display: none;">
		<fieldset class="well">
			<form:form class="form-horizontal" id="formAgregarSospechoso" action="agregarSospechoso" commandName="sospechoso">
		       	<legend>
			       	<span class="colored">///</span> Agregar Sospechoso Nuevo:
		       	</legend>
		       	<div class="span4">
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
		          			<input class="span2" type="text" name="txtDepartamentoNacimiento" id="txtDepartamentoDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtProvinciaNacimiento" id="txtProvinciaDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtDistritoNacimiento" id="txtDistritoDeNacimiento">
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
		       		<hr>
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
		       	</div>
		       	<div class="span4">
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
		          			<input class="span2" type="text" name="txtNombrePadre" id="txtNombrePadre">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Nombre de la Madre: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtNombreMadre" id="txtNombreMadre">
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
		          			<input class="span2" type="text" name="txtRestriccion" id="txtRestriccion">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtDomicilio" id="txtDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtDepartamentoDeDomicilio" id="txtDepartamentoDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtProvinciaDeDomicilio" id="txtProvinciaDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtDistritoDeDomicilio" id="txtDistritoDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Multas Electorales: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtMultasElectorales" id="txtMultasElectorales">
		          			<input class="span2" type="hidden" name="txtMultasElectorales" id="txtMultasElectorales">
		          		</div>
		       		</div>
		       	</div>
	       		<div class="form-actions span8">
		        	<button class="btn btn-success" id="btnGuardar" type="submit"><i class="icon-ok icon-white"></i> Guardar Sospechoso</button>
		        	<button class="btn btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset</button>
		        	<button class="btn btn-warning" type="button" id="btnCancelAgregarSospechoso"><i class="icon-arrow-left icon-white"></i> Cancel</button>
		        </div>  
			</form:form>
		</fieldset>
	</div>
</div>