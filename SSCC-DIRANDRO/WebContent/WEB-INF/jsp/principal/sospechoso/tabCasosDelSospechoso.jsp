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
	$.each(casos, function(i, caso) {
		var importancia = '';
		if(caso.importancia != ''){

			if(caso.importancia == 'Baja'){
				importancia += '( <span class="label">'+caso.importancia+'</span> )';
			}else if(caso.importancia == 'Media'){
				importancia += '( <span class="label label-warning">'+caso.importancia+'</span> )';
			}else if(caso.importancia == 'Alta'){
				importancia += '( <span class="label label-important">'+caso.importancia+'</span> )';
			}
		}else{
			importancia = '';
		}
		$("#casoRelacionados").append(
			'<table class="table table-bordered table-condensed">'+
					'<tbody>'+
					'<tr>'+
						'<td>Informe:</td>'+
						'<td align="center"><span id="hdrCodigoCaso"><a href="toCasoCriminal-'+caso.idCasoCriminal+'">'+caso.codigo+'</a> '+importancia+'</span></td>'+
						'<td>Estado:</td>'+
						'<td align="center"><span id="hdrEstado">'+caso.estado+'</span></td>'+
						'<td>Acciones:</td>'+
						'<td align="center"><button class="btn btn-danger btn-mini asignar" id="cancelarAsigna_'+caso.idCasoCriminal+'" type="button"><i class="icon-minus icon-white"></i></button></td>'+
					'</tr>'+
					'<tr>'+
						'<td colspan="2">Referencia:</td>'+
						'<td colspan="2"><span id="hdrReferencia">'+caso.referencia+'</span></td>'+
						'<td>Fecha de Creacion:</td>'+
						'<td><span id="hdrFecCreacion">'+timeStampFormatted(caso.fecCreacion)+'</span></td>'+
					'</tr>'+
					'<tr>'+
						'<td>Creado por:</td>'+
						'<td colspan="5"><span id="hdrCreador"><a href="toPerfil-'+caso.idPerfil+'">'+caso.nombreCompleto+'</a></span></td>'+					
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
		
});

</script>
<div id="divMostrarCasosRelacionados">
	<div id="divMostrarCasos">
		<form:form class="form-horizontal">
	       	<legend>
		       	<span class=""><span class="colored">///</span> Casos Relacionados al Investigado:</span>
		       	<!-- <span class="offset3"><button class="btn btn-primary" type="button" id="btnEditarSopechoso"><i class="icon-edit"></i> Editar</button></span> -->
	       	</legend>
	       	<div id="casoRelacionados">
	       		
	       	</div>
		</form:form>
	</div>
		
	<!-- <section> Formulario editar-->
		<%-- <fieldset class="well" style="display: none; margin-left: 0%;" id="divEditarSospechoso">
		<div id="alertasSospechosoNuevo" style="display: none;">
		</div>
		<div id="alertasSospechosoNuevo2" style="display: none;">
		</div>
			<form:form class="form-horizontal span9" id="formEditarSospechoso" action="editarSospechoso" commandName="sospechoso" style="margin-left: -4%;">
		       	<legend class="span8">
			       	<span class="colored">///</span> Editar Datos Personales del Sospechoso:
		       	</legend>
		       		<input type="hidden" name="idSospechoso" id="hdnIdSospechosoEdit">
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
		       		<!--  -->
		       		<!-- Aqui empieza mario-->
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
		          			<input class="span2" type="hidden" name="multasElectorales" id="txtMultasElectorales">
		          		</div>
		       		</div>
		       	</div>
		       		<!-- Aqui cierra mario-->
	       		<div class="form-actions span6">
		        	<button class="btn btn-success" id="btnGuardar" type="submit"><i class="icon-ok icon-white"></i> Guardar Sospechoso</button>
		        	<button class="btn btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset</button>
		        	<button class="btn btn-warning" type="button" id="btnCancelEditar"><i class="icon-arrow-left icon-white"></i> Cancel</button>
		        </div>  
			</form:form>
		</fieldset>
	<!-- </section> --> --%>
</div>

