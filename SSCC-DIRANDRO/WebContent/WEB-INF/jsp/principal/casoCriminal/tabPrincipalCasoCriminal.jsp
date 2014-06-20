<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
function initCasoCriminal(caso){
		$("#hdrCodigoCaso").empty();
		$("#hdrEstado").empty();
		$("#hdrReferencia").empty();
		$("#hdrCreador").empty();
		$("#hdrFecCreacion").empty();
		
		$("#spnCodigo").empty();
		$("#spnEstado").empty();
		$("#spnFecCreacion").empty();
		$("#spnReferencia").empty();
		$("#spnAsunto").empty();
		$("#spnDescripcion").empty();
		$("#spnPrioridad").empty();
			 				
		var importancia = '';
		if(caso.importancia != ''){
			importancia += caso.importancia;
			$("#hdrCodigoCaso").append(caso.codigo+" ("+importancia+")");
		}else{
			importancia = '';
			$("#hdrCodigoCaso").append(caso.codigo);
		}

		$("#hdrEstado").append(caso.estado);
		$("#hdrReferencia").append(caso.referencia);
		$("#hdrCreador").append('<a href="toPerfil-'+caso.idPerfil+'">'+caso.primerNombre+ ' ' +caso.segundoNombre+ ' ' +caso.apePaterno+ ' ' +caso.apeMaterno+ '</a>');
		$("#hdrFecCreacion").text(timeStampFormatted(caso.fecCreacion));
		$("#spnPrioridad").append(importancia);
		
		$("#spnCodigo").append(caso.codigo);
		$("#spnEstado").append(caso.estado);
		$("#spnFecCreacion").append(timeStampFormatted(caso.fecCreacion));
		$("#spnReferencia").append(caso.referencia);
		$("#spnAsunto").append(caso.asunto);
		$("#spnDescripcion").append(caso.descripcion);
		
		if(caso.estado == 'Activo'){
			$("#alertaPausaDocs").remove();
			$("#alertaPausaNCaso").remove();

			if(JefeDeUnidad == 0){
				$("#divAlertarCasoCriminal").show();
	 			$("#divAlertarCasoCriminal").append('<div class="alert alert-info" id="alertaVerde">'+
									 			        '<a class="close" data-dismiss="alert">×</a>'+
									 			        'Recuerde Asignar un <strong>Jefe de unidad</strong> y al personal policial.'+
									 			    '</div>');
			}else if(JefeDeUnidad > 0){
				$("#tdBotones").empty();
				$("#tdBotones").append('<button class="btn btn-small btn-success" id="btnDiligenciasPre" href="#myModal" data-toggle="modal"><i class="icon-ok icon-white"></i> Diligencias Preliminares</button>'+
						' <button class="btn btn-small btn-info" id="btnPasusaDoc" href="#myModalPausaDoc" data-toggle="modal"><i class="icon-pause icon-white"></i> Pausa por Falta de Documentos</button>'+
						' <button class="btn btn-small btn-info" id="btnPasusaNCaso" href="#myModalPausaNCaso" data-toggle="modal"><i class="icon-pause icon-white"></i> Pausa por Nuevo Caso</button>');
			}	
		}else if(caso.estado == 'Diligencias Preliminares'){
			$("#alertaPausaDocs").remove();
			$("#alertaPausaNCaso").remove();
			$("#divAlertarCasoCriminal").show();
 			$("#divAlertarCasoCriminal").append('<div class="alert alert-success" id="alertaVerde">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        'Se han asignado <strong>'+caso.diasDiligenciasPreliminares+'</strong> dias para las diligencias preliminares.<br>'+
				 			       'Apartir de <strong>'+timeStampFormatted(caso.fecDiligenciasPre)+'.</strong>'+
				 			    '</div>');
 			$("#tdBotones").empty();
			$("#tdBotones").prepend(' <button class="btn btn-small btn-success" id="btnDiligenciasPreAmpliatorio" href="#myModalPlazoAmp" data-toggle="modal"><i class="icon-plus icon-white"></i> Plazo Ampliatorio</button>');
			$("#tdBotones").prepend('<button class="btn btn-small btn-success" id="btnCalificacionFiscal" href="#myModalCalificacionFiscal" data-toggle="modal"><i class="icon-ok icon-white"></i> Calificacion Fiscal</button>');
			$("#tdBotones").append(' <button class="btn btn-small btn-info" id="btnPasusaDoc" href="#myModalPausaDoc" data-toggle="modal"><i class="icon-pause icon-white"></i> Pausa por Falta de Documentos</button>');
			$("#tdBotones").append(' <button class="btn btn-small btn-info" id="btnPasusaNCaso" href="#myModalPausaNCaso" data-toggle="modal"><i class="icon-pause icon-white"></i> Pausa por Nuevo Caso</button>');
			
		}else if(caso.estado == 'Pausa por Falta de Documentos'){
			$("#tdBotones").empty();
			$("#tdBotones").append('<button class="btn btn-small btn-danger" id="btnRemoverPausa"><i class="icon-remove icon-white"></i> Remover Pausa</button>');
			if(caso.cometarioPausaDoc != null){
				$("#divAlertarCasoCriminal").show();
	 			$("#divAlertarCasoCriminal").append('<div class="alert alert-info" id="alertaPausaDocs">'+
					 			        '<a class="close" data-dismiss="alert">×</a>'+
					 			        'Comentraio: <strong id="msgVerde">'+caso.cometarioPausaDoc+'</strong>'+
					 			    '</div>');				
			}
		}else if(caso.estado == 'Pausa por Nuevo Caso'){
			$("#tdBotones").empty();
			$("#tdBotones").append('<button class="btn btn-small btn-danger" id="btnRemoverPausa"><i class="icon-remove icon-white"></i> Remover Pausa</button>');
			//alert(""+caso.cometarioPausaNCaso);
			if(caso.cometarioPausaNCaso != null){
				$("#divAlertarCasoCriminal").show();
	 			$("#divAlertarCasoCriminal").append('<div class="alert alert-info" id="alertaPausaNCaso">'+
					 			        '<a class="close" data-dismiss="alert">×</a>'+
					 			        'Comentraio: <strong id="msgVerde">'+caso.cometarioPausaNCaso+'</strong>'+
					 			    '</div>');				
			}
		}
		
		///fecha de las diligencias
		if(caso.fecDiligenciasPre != null){
			$("#divDiligenciasPre").remove();
			$("#divFecDiligenciasPre").remove();
			$("#fsPrincipal").append('<div class="control-group" id="divFecDiligenciasPre">'+
										'<label class="control-label">Fecha Inicial de las Diligencias Preliminares: </label>'+
										'<div class="controls" style="margin-top: 4.6%;">'+
											'<span id="spnfecDiligenciasPre">'+timeStampFormatted(caso.fecDiligenciasPre)+'</span>'+
										'</div>'+
									'</div>');
			$("#fsPrincipal").append('<div class="control-group" id="divDiligenciasPre">'+
										'<label class="control-label">Dias para las Diligencias Preliminares: </label>'+
										'<div class="controls" style="margin-top: 4.6%;">'+
											'<span id="spnDiligenciasPre">'+caso.diasDiligenciasPreliminares+' dias.</span>'+
										'</div>'+
									'</div>');

		}
}
$(document).ready(function(){
	var idCaso = $("#hdnIdCaso").text();
	$.ajax({
 		url: 'getCaso-'+idCaso,
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(caso){
 			initCasoCriminal(caso);
 		}
 	});
	//
	$("#formEditarCasoCriminal").validate({
		submitHandler: function(form){
			$("#hdnIdCasoCriminal").val($("#hdnIdCaso").text());
			$.ajax({
				url: 'editarCasoCriminal',
		 		type: 'post',
		 		dataType: 'json',
		 		data: $("#formEditarCasoCriminal").serialize(),
		 		success: function(caso){
		 			initCasoCriminal(caso);
		 			$("#divMostrarCasoCriminal").show();
		 			$("#divEditarCasoCriminal").hide();
		 			$("#alertas").show();
		 			$("#alertas").append('<div class="alert alert-success" id="alertaVerde">'+
						 			        '<a class="close" data-dismiss="alert">×</a>'+
						 			        '<strong id="msgVerde">Editado Correctamente</strong>'+
						 			    '</div>');
		 		}
			});
		}
	});
});
$(document).on('click','#btnEditarCasoCriminal', function(e){
	//TABS A OCULTAR Y MOSTRAR
	$("#txtAsunto").val($("#spnAsunto").text());
	$("#txtReferencia").val($("#spnReferencia").text());
	$("#txtDescription").val($("#spnDescripcion").text());
	$("#sltcImportancia").val($("#spnPrioridad").text());
	
	$("#divMostrarCasoCriminal").hide();
	$("#divEditarCasoCriminal").show();
});
$(document).on('click','#btnCancelEditar', function(e){
	//TABS A OCULTAR Y MOSTRAR
	$("#divMostrarCasoCriminal").show();
	$("#divEditarCasoCriminal").hide();
});
</script>
<div id="divCasoCriminal">
	<div id="alertas" style="display: none;">
	</div>
	<div id="divMostrarCasoCriminal">
	<form:form class="form-horizontal">
		<fieldset id="fsPrincipal">
			<legend>
				<span class=""><span class="colored">///</span> Datos del Caso Criminal:</span>
				<span class="offset3"><button class="btn btn-primary btn-small" type="button" id="btnEditarCasoCriminal"><i class="icon-edit icon-white"></i> Editar</button></span>
			</legend>
			<div class="control-group">
				<label class="control-label">Codigo: </label>
				<div class="controls">
					<span id="spnCodigo">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Estado: </label>
				<div class="controls">
					<span id="spnEstado">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Fecha de Creacion: </label>
				<div class="controls">
					<span id="spnFecCreacion">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Referencia: </label>
				<div class="controls">
					<span id="spnReferencia">&nbsp;</span>
				</div>
			</div>
			<div class="control-group" id="divRango">
				<label class="control-label">Asunto: </label>
				<div class="controls">
					<span id="spnAsunto">&nbsp;</span>
				</div>
			</div>
			<div class="control-group" id="divRango">
				<label class="control-label">Description: </label>
				<div class="controls">
					<p id="spnDescripcion">&nbsp;</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Prioridad: </label>
				<div class="controls">
					<p id="spnPrioridad">&nbsp;</p>
				</div>
			</div>
		</fieldset>
	</form:form>
</div>
<!-- EDITAR CAOS CRIMINAL -->
	<fieldset class="well" style="display: none;" id="divEditarCasoCriminal">
		<form:form class="form-horizontal" id="formEditarCasoCriminal" action="editarCasoCriminal" commandName="CasoCriminal">
				<input type="hidden" name="idCasoCriminal" id="hdnIdCasoCriminal">
				<legend>
			       	<span class="colored">///</span> Editar Caso Criminal:
		       	</legend>
		       	<div class="control-group">
	          		<label class="control-label">Asunto: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="asunto" id="txtAsunto" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
				<hr/>
				<div class="control-group">
	          		<label class="control-label">Referencia: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="referencia" id="txtReferencia" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
				<hr/>
				<div class="control-group">
	          		<label class="control-label">Description: </label>
	          		<div class="controls">
	          			<textarea class="input-xlarge" name="descripcion" id="txtDescription" rows="8" data-rule-required="true" data-msg-required="*"></textarea>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Prioridad: </label>
	          		<div class="controls">
	          			<select class="span3" name="importancia" id="sltcImportancia">
	          				<option value="">No Precisa</option>
	          				<option>Alta</option>
	          				<option>Media</option>
	          				<option>Baja</option>
			            </select>
	          		</div>
	       		</div>
				<!-- BOTONES -->
				<div class="form-actions">
					<button class="btn btn-success" id="btnGuardar" type="submit"><i class="icon-ok icon-white"></i> Guardar</button>
			        <button class="btn btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset</button>
			        <button class="btn btn-warning" type="button" id="btnCancelEditar"><i class="icon-arrow-left icon-white"></i> Cancel</button>
			    </div>
			</form:form>
		</fieldset>
</div>
