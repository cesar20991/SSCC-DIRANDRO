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
			$("#tdBotones").append('<button class="btn btn-outline btn-success btn-sm" id="btnDiligenciasPre" href="#myModal" data-toggle="modal"><i class="glyphicon glyphicon-ok"></i> Diligencias Preliminares</button>'+
					' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaDoc" href="#myModalPausaDoc" data-toggle="modal"><i class="glyphicon glyphicon-pause"></i> Pausa por Falta de Documentos</button>'+
					' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaNCaso" href="#myModalPausaNCaso" data-toggle="modal"><i class="glyphicon glyphicon-pause"></i> Pausa por Nuevo Caso</button>');

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
			$("#tdBotones").prepend(' <button class="btn btn-outline btn-success btn-sm" id="btnDiligenciasPreAmpliatorio" href="#myModalPlazoAmp" data-toggle="modal"><i class="glyphicon glyphicon-plus"></i> Plazo Ampliatorio</button>');
			$("#tdBotones").prepend('<button class="btn btn-outline btn-success btn-sm" id="btnCalificacionFiscal" href="#myModalCalificacionFiscal" data-toggle="modal"><i class="glyphicon glyphicon-ok"></i> Calificacion Fiscal</button>');
			$("#tdBotones").append(' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaDoc" href="#myModalPausaDoc" data-toggle="modal"><i class="glyphicon glyphicon-pause"></i> Pausa por Falta de Documentos</button>');
			$("#tdBotones").append(' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaNCaso" href="#myModalPausaNCaso" data-toggle="modal"><i class="glyphicon glyphicon-pause"></i> Pausa por Nuevo Caso</button>');
			
		}else if(caso.estado == 'Pausa por Falta de Documentos'){
			$("#tdBotones").empty();
			$("#tdBotones").append('<button class="btn btn-outline btn-danger btn-sm" id="btnRemoverPausa"><i class="glyphicon glyphicon-remove"></i> Remover Pausa</button>');
			if(caso.cometarioPausaDoc != null){
				$("#divAlertarCasoCriminal").show();
	 			$("#divAlertarCasoCriminal").append('<div class="alert alert-info" id="alertaPausaDocs">'+
					 			        '<a class="close" data-dismiss="alert">×</a>'+
					 			        'Comentraio: <strong id="msgVerde">'+caso.cometarioPausaDoc+'</strong>'+
					 			    '</div>');				
			}
		}else if(caso.estado == 'Pausa por Nuevo Caso'){
			$("#tdBotones").empty();
			$("#tdBotones").append('<button class="btn btn-outline btn-danger btn-sm" id="btnRemoverPausa"><i class="glyphicon glyphicon-remove"></i> Remover Pausa</button>');
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
			//$("#tdBotones").prepend(' <button class="btn btn-outline btn-success btn-sm" id="btnDiligenciasPreAmpliatorio" href="#myModalPlazoAmp" data-toggle="modal"><i class=""></i> Plazo Ampliatorio</button>');
			$("#tdBotones").prepend(' <button class="btn btn-outline btn-danger btn-sm" id="btnCerrarCaso" href="#myModalCerrarCaso" data-toggle="modal"><i class="glyphicon glyphicon-ban-circle"></i> Cerrar Caso</button>');
			$("#tdBotones").prepend('<button class="btn btn-outline btn-success btn-sm" id="btnFormalizar" href="#myModalFormalizar" data-toggle="modal"><i class="glyphicon glyphicon-ok"></i> Formalizar Investigacion</button>');
			$("#tdBotones").append(' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaDoc" href="#myModalPausaDoc" data-toggle="modal"><i class="glyphicon glyphicon-pause"></i> Pausa por Falta de Documentos</button>');
			$("#tdBotones").append(' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaNCaso" href="#myModalPausaNCaso" data-toggle="modal"><i class="glyphicon glyphicon-pause"></i> Pausa por Nuevo Caso</button>');
		}else if(caso.estado == 'Conclusion de la Investigacion'){
			$("#divAlertarCasoCriminal").show();
			$("#divAlertarCasoCriminal").empty();
 			$("#divAlertarCasoCriminal").append('<div class="alert alert-info" id="alertaPausaNCaso">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        '<strong id="msgVerde"> '+caso.cometarioCerrarCaso+'</strong>'+
				 			    '</div>');
 			
 			$("#tdBotones").empty();
			//$("#tdBotones").prepend(' <button class="btn btn-outline btn-success btn-sm" id="btnDiligenciasPreAmpliatorio" href="#myModalPlazoAmp" data-toggle="modal"><i class="icon-exclamation-sign icon-white"></i> Aviso Fiscal Superior</button>');
		}else if(caso.estado == 'Formalizacion de la Investigacion'){
			var coment = '';
			if(caso.cometarioFormalizar != null){
				coment = '<strong id="msgVerde"> Comentario: '+caso.cometarioFormalizar+'</strong>';
			}
			$("#divAlertarCasoCriminal").show();
			$("#divAlertarCasoCriminal").empty();
 			$("#divAlertarCasoCriminal").append('<div class="alert alert-success" id="alertaPausaNCaso">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        '<strong id="msgVerde"> Estado Cambiado a Formalizacion de la Investigacion.</strong>'+
				 			       coment+
				 			    '</div>');
 			$("#tdBotones").empty();
 			$("#tdBotones").prepend('<button class="btn btn-outline btn-success btn-sm" id="btnDiligenciasInv" href="#myModalDilInv" data-toggle="modal"><i class="glyphicon glyphicon-ok"></i> Diligencias de la Investigacion</button>');
			$("#tdBotones").append(' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaDoc" href="#myModalPausaDoc" data-toggle="modal"><i class="glyphicon glyphicon-pause"></i> Pausa por Falta de Documentos</button>');
			$("#tdBotones").append(' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaNCaso" href="#myModalPausaNCaso" data-toggle="modal"><i class="glyphicon glyphicon-pause"></i> Pausa por Nuevo Caso</button>');
		}else if(caso.estado == "Diligencias de la Investigacion"){
			$("#divAlertarCasoCriminal").show();
			$("#divAlertarCasoCriminal").empty();
 			$("#divAlertarCasoCriminal").append('<div class="alert alert-success" id="alertaVerde">'+
				 			        '<a class="close" data-dismiss="alert">×</a>'+
				 			        'Se han asignado <strong>'+caso.diasDiligenciasInvestigacion+'</strong> dias para las diligencias preliminares.<br>'+
				 			       'Apartir de <strong>'+timeStampFormatted(caso.fecDiligenciasInv)+'.</strong>'+
				 			    '</div>');
 			$("#tdBotones").empty();
 			$("#tdBotones").prepend(' <button class="btn btn-outline btn-danger btn-sm" id="btnCerrarCaso" href="#myModalCerrarCaso" data-toggle="modal"><i class="glyphicon glyphicon-ban-circle"></i> Cerrar Caso</button>');
			$("#tdBotones").append(' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaDoc" href="#myModalPausaDoc" data-toggle="modal"><i class="glyphicon glyphicon-pause"></i> Pausa por Falta de Documentos</button>');
			$("#tdBotones").append(' <button class="btn btn-outline btn-info btn-sm" id="btnPasusaNCaso" href="#myModalPausaNCaso" data-toggle="modal"><i class="glyphicon glyphicon-pause"></i> Pausa por Nuevo Caso</button>');
		}
		
		///fecha de las diligencias
		console.log(timeStampFormatted(caso.fecDiligenciasPre));
		if(caso.fecDiligenciasPre != null){
			$("#divDiligenciasPre").remove();
			$("#divFecDiligenciasPre").remove();
			$("#fsPrincipal").append('<div class="form-group" id="divFecDiligenciasPre">'+
										'<label >Fecha Inicial de las Diligencias Preliminares: </label>'+
										'<span id="spnfecDiligenciasPre">'+timeStampFormatted(caso.fecDiligenciasPre)+'</span>'+
									'</div>');
			$("#fsPrincipal").append('<div class="form-group" id="divDiligenciasPre">'+
										'<label >Dias para las Diligencias Preliminares: </label>'+
										'<span id="spnDiligenciasPre">'+caso.diasDiligenciasPreliminares+' dias.</span>'+
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
			<div class="panel-body" id="fsPrincipal">
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
<div class="panel panel-default" style="display: none;" id="divEditarCasoCriminal">
	<div class="panel-heading">
	/// Editar Caso Criminal:
	</div>
	<div class="panel-body">
		<form:form class="form-horizontal" id="formEditarCasoCriminal" action="editarCasoCriminal" commandName="CasoCriminal">
		<input type="hidden" name="idCasoCriminal" id="hdnIdCasoCriminal">
			<div class="form-group">
          		<label >Asunto: </label>
          		<input class="form-control" type="text" name="asunto" id="txtAsunto" data-rule-required="true" data-msg-required="*">
       		</div>
			<div class="form-group">
          		<label >Referencia: </label>
          		<input class="form-control" type="text" name="referencia" id="txtReferencia" data-rule-required="true" data-msg-required="*">
       		</div>
			<div class="form-group">
          		<label >Description: </label>
          		<textarea class="form-control" name="descripcion" id="txtDescription" rows="8" data-rule-required="true" data-msg-required="*"></textarea>
       		</div>
       		<div class="form-group">
          		<label >Prioridad: </label>
          		<select class="form-control" name="importancia" id="sltcImportancia">
         				<option value="">No Precisa</option>
         				<option>Alta</option>
         				<option>Media</option>
         				<option>Baja</option>
	            </select>
       		</div>
       		<hr>
			<div class="well">
				<button class="btn btn-outline btn-success" id="btnGuardar" type="submit"><i class="fa fa-check"></i> Guardar</button>
		        <button class="btn btn-outline btn-danger" type="reset"><i class="fa fa-refresh fa-fw"></i> Reset</button>
		        <button class="btn btn-outline btn-warning" type="button" id="btnCancelEditar"><i class="fa fa-arrow-left"></i> Cancel</button>
			</div>
		</form:form>
	</div>
</div>
</div>
