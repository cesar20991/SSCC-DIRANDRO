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
			
			if(caso.importancia == 'Baja'){
				importancia += '<span>'+caso.importancia+'</span>';
			}else if(caso.importancia == 'Media'){
				importancia += '<span>'+caso.importancia+'</span>';
			}else if(caso.importancia == 'Alta'){
				importancia += '<span>'+caso.importancia+'</span>';
			}
			$("#hdrCodigoCaso").append(caso.codigo+" ( "+importancia+" )");
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
		//alert(caso.estado);
		if(caso.estado == 'Activo'){
			$("#alertaPausaDocs").remove();
			$("#alertaPausaNCaso").remove();
			
			$("#tdBotones").empty();
			$("#tdBotones").append('<button class="btn btn-outline btn-success btn-sm" id="btnDiligenciasPre" href="#myModal" data-toggle="modal"><i class="icon-ok icon-white"></i> Diligencias Preliminares</button>'+
					' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaDoc" href="#myModalPausaDoc" data-toggle="modal"><i class="icon-pause icon-white"></i> Pausa por Falta de Documentos</button>'+
					' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaNCaso" href="#myModalPausaNCaso" data-toggle="modal"><i class="icon-pause icon-white"></i> Pausa por Nuevo Caso</button>');

			//la alerta celeste de personal asignado esta en el tabPersonalAsignado	
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
			$("#tdBotones").prepend(' <button class="btn btn-outline btn-success btn-sm" id="btnDiligenciasPreAmpliatorio" href="#myModalPlazoAmp" data-toggle="modal"><i class="icon-plus icon-white"></i> Plazo Ampliatorio</button>');
			$("#tdBotones").prepend('<button class="btn btn-outline btn-success btn-sm" id="btnCalificacionFiscal" href="#myModalCalificacionFiscal" data-toggle="modal"><i class="icon-ok icon-white"></i> Calificacion Fiscal</button>');
			$("#tdBotones").append(' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaDoc" href="#myModalPausaDoc" data-toggle="modal"><i class="icon-pause icon-white"></i> Pausa por Falta de Documentos</button>');
			$("#tdBotones").append(' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaNCaso" href="#myModalPausaNCaso" data-toggle="modal"><i class="icon-pause icon-white"></i> Pausa por Nuevo Caso</button>');
			
		}else if(caso.estado == 'Pausa por Falta de Documentos'){
			$("#tdBotones").empty();
			$("#tdBotones").append('<button class="btn btn-outline btn-danger btn-sm" id="btnRemoverPausa"><i class="icon-remove icon-white"></i> Remover Pausa</button>');
			if(caso.cometarioPausaDoc != null){
				$("#divAlertarCasoCriminal").show();
	 			$("#divAlertarCasoCriminal").append('<div class="alert alert-info" id="alertaPausaDocs">'+
					 			        '<a class="close" data-dismiss="alert">×</a>'+
					 			        'Comentraio: <strong id="msgVerde">'+caso.cometarioPausaDoc+'</strong>'+
					 			    '</div>');				
			}
		}else if(caso.estado == 'Pausa por Nuevo Caso'){
			$("#tdBotones").empty();
			$("#tdBotones").append('<button class="btn btn-outline btn-danger btn-sm" id="btnRemoverPausa"><i class="icon-remove icon-white"></i> Remover Pausa</button>');
			//alert(""+caso.cometarioPausaNCaso);
			if(caso.cometarioPausaNCaso != null){
				$("#divAlertarCasoCriminal").show();
	 			$("#divAlertarCasoCriminal").append('<div class="alert alert-info" id="alertaPausaNCaso">'+
					 			        '<a class="close" data-dismiss="alert">×</a>'+
					 			        'Comentraio: <strong id="msgVerde">'+caso.cometarioPausaNCaso+'</strong>'+
					 			    '</div>');				
			}
		}else if(caso.estado == 'Calificacion Fiscal'){
			$("#divAlertarCasoCriminal").show();
 			$("#divAlertarCasoCriminal").append('<div class="alert alert-info" id="alertaPausaNCaso">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        '<strong id="msgVerde"> Cambio de estado a Calificacion por Fiscal a Cargo.</strong>'+
				 			    '</div>');
 			
			$("#tdBotones").empty();
			//$("#tdBotones").prepend(' <button class="btn btn-outline btn-success" id="btnDiligenciasPreAmpliatorio" href="#myModalPlazoAmp" data-toggle="modal"><i class="icon-exclamation-sign icon-white"></i> Aviso Fiscal Superior</button>');
			$("#tdBotones").prepend('<button class="btn btn-outline btn-success btn-sm" id="btnCerrarCaso" href="#myModalCerrarCaso" data-toggle="modal"><i class="icon-remove icon-white"></i> Cerrar Caso</button>');
			$("#tdBotones").append(' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaDoc" href="#myModalPausaDoc" data-toggle="modal"><i class="icon-pause icon-white"></i> Pausa por Falta de Documentos</button>');
			$("#tdBotones").append(' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaNCaso" href="#myModalPausaNCaso" data-toggle="modal"><i class="icon-pause icon-white"></i> Pausa por Nuevo Caso</button>');
		}else if(caso.estado == 'Calificacion Fiscal'){
			$("#divAlertarCasoCriminal").show();
 			$("#divAlertarCasoCriminal").append('<div class="alert alert-info" id="alertaPausaNCaso">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        '<strong id="msgVerde"> '+caso.cometarioCerrarCaso+'</strong>'+
				 			    '</div>');
 			
 			$("#tdBotones").empty();
			$("#tdBotones").prepend(' <button class="btn btn-outline btn-success btn-sm" id="btnDiligenciasPreAmpliatorio" href="#myModalPlazoAmp" data-toggle="modal"><i class="icon-exclamation-sign icon-white"></i> Aviso Fiscal Superior</button>');
		}
		
		///fecha de las diligencias
		if(caso.fecDiligenciasPre != null){
			$("#divDiligenciasPre").remove();
			$("#divFecDiligenciasPre").remove();
			$("#fsPrincipal").append('<div class="form-group" id="divFecDiligenciasPre">'+
										'<label >Fecha Inicial de las Diligencias Preliminares: </label>'+
										'<div class="controls" style="margin-top: 4.6%;">'+
											'<span id="spnfecDiligenciasPre">'+timeStampFormatted(caso.fecDiligenciasPre)+'</span>'+
										'</div>'+
									'</div>');
			$("#fsPrincipal").append('<div class="form-group" id="divDiligenciasPre">'+
										'<label >Dias para las Diligencias Preliminares: </label>'+
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
		<div class="panel panel-default">
			<div class="panel-heading">
				<span>/// Datos del Caso Criminal:</span>
				<div class="pull-right">
					<div class="btn-group">
						<button class="btn btn-outline btn-primary btn-sm" type="button" id="btnEditarCasoCriminal"><i class="fa fa-edit fa-fw"></i> Editar</button>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<div class="form-group">
					<label >Codigo: </label>
					<span id="spnCodigo">&nbsp;</span>
				</div>
				<div class="form-group">
					<label >Estado: </label>
					<span id="spnEstado">&nbsp;</span>
				</div>
				<div class="form-group">
					<label >Fecha de Creacion: </label>
					<span id="spnFecCreacion">&nbsp;</span>
				</div>
				<div class="form-group">
					<label >Referencia: </label>
					<span id="spnReferencia">&nbsp;</span>
				</div>
				<div class="form-group" id="divRango">
					<label >Asunto: </label>
					<span id="spnAsunto">&nbsp;</span>
				</div>
				<div class="form-group" id="divRango">
					<label >Description: </label>
					<p id="spnDescripcion">&nbsp;</p>
				</div>
				<div class="form-group">
					<label >Prioridad: </label>
					<p id="spnPrioridad">&nbsp;</p>
				</div>
			</div>
		</div>
</div>
<!-- EDITAR CAOS CRIMINAL -->
	<fieldset class="well" style="display: none;" id="divEditarCasoCriminal">
		<form:form class="form-horizontal" id="formEditarCasoCriminal" action="editarCasoCriminal" commandName="CasoCriminal">
				<input type="hidden" name="idCasoCriminal" id="hdnIdCasoCriminal">
				<legend>
			       	<span class="colored">///</span> Editar Caso Criminal:
		       	</legend>
		       	<div class="form-group">
	          		<label >Asunto: </label>
	          		<input class="span3" type="text" name="asunto" id="txtAsunto" data-rule-required="true" data-msg-required="*">
	       		</div>
				<hr/>
				<div class="form-group">
	          		<label >Referencia: </label>
	          		<input class="span3" type="text" name="referencia" id="txtReferencia" data-rule-required="true" data-msg-required="*">
	       		</div>
				<hr/>
				<div class="form-group">
	          		<label >Description: </label>
	          		<textarea class="input-xlarge" name="descripcion" id="txtDescription" rows="8" data-rule-required="true" data-msg-required="*"></textarea>
	       		</div>
	       		<div class="form-group">
	          		<label >Prioridad: </label>
	          		<select class="span3" name="importancia" id="sltcImportancia">
          				<option value="">No Precisa</option>
          				<option>Alta</option>
          				<option>Media</option>
          				<option>Baja</option>
		            </select>
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
