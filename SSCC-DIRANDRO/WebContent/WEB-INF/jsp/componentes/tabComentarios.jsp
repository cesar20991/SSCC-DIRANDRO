<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
function initComentarios(comentarios){
	$("#divMostrarComentarios").empty();
	$.each(comentarios, function(i, comentario) {		
		var url = '';
		if(comentario.urlUsuario == null){
			url += 'img/skills.png';
		}else{
			url += comentario.urlUsuario;
		}
		$("#divMostrarComentarios").append(
			'<div class="well">'+
				'<table class="table table-bordered table-condensed">'+
					'<tbody>'+
						'<tr>'+
							'<td rowspan="3" style="width: 90px; height: 100px;"><img src="'+url+'" alt="logo" style="width: 90px; height: 120px;"></td>'+
							'<td colspan="2"><a href="toPerfil-'+comentario.idPerfil+'">'+comentario.nombreCompleto+'</a></td>'+
							'<td><button type="button" class="btn btn-success comentario" id="responderComentario_'+comentario.idComentario+'"><i class="icon-comment icon-white"></i> Responder</button></td>'+
						'</tr>'+
						'<tr>'+
							'<td colspan="3">Mensaje ('+comentario.visibilidad+'):</td>'+
						'</tr>'+
						'<tr>'+
							'<td colspan="3">'+comentario.comentario+'</td>'+			
						'</tr>'+
						'<tr id="trTA_'+comentario.idComentario+'" style="display: none;">'+
							'<td colspan="4">'+
									'<form id="formComentarios_'+comentario.idComentario+'">'+
									'<textarea class="span8" name="comentario" id="txtComentario_'+comentario.idComentario+'" data-rule-required="true" data-msg-required="*"></textarea>'+
			        	
						        	'<div class="control-group">'+
						        		'<label class="control-label">Visibilidad:</label>'+
						        		'<div class="controls">'+
							        		'<select id="sltcVisibility" name="visibilidad">'+
							        			'<option>Público</option>'+
						                		'<option>DIRANDRO</option>'+
						                		'<option>Ministerio Públic</option>'+
						                		'<option>Solo Yo</option>'+
						              		'</select>'+
						        		'</div>'+	
						        	'</div>'+
						        	
						        	'<input type="hidden" id="hdnTipoEntidadCommentario_'+comentario.idComentario+'" name="tipoEntidadCommentario" value="'+tipoEntidad+'">'+
						        	'<input type="hidden" id="hdnIdEntidadCommentario_'+comentario.idComentario+'" name="idEntidadCommentario">'+
								    '<div class="form-actions">'+
							        	'<button type="button" class="btn btn-success comentario" id="respuesta_'+comentario.idComentario+'"><i class="icon-comment icon-white"></i> Guardar Comentario</button>'+
							        	' <button type="reset" class="btn btn-danger" id="guardarArchivos"><i class="icon-refresh icon-white"></i> Reset</button>'+
							        	' <button type="button" class="btn btn-warning comentario" id="cancel_'+comentario.idComentario+'"><i class="icon-arrow-left icon-white"></i> Cancel</button>'+
							        '</div>'+
							        '</form>'+
			        		'</td>'+			
						'</tr>'+
						'<tr>'+
							'<td colspan="4" id="respuestas_'+comentario.idComentario+'"></td>'+			
						'</tr>'+
					'</tbody>'+
				'</table>'+
			'</div>');
	});
}

function initRespuestas(respuestas){
	//$("#respuestas_"+id).empty();
		$.each(respuestas, function(i, respuesta) {
			var url = '';
			if(respuesta.urlUsuario == null){
				url += 'img/skills.png';
			}else{
				url += respuesta.urlUsuario;
			}
			$("#respuestas_"+respuesta.idComentarioPadre).append(
					'<table class="table table-bordered table-condensed offset1 span10">'+
						'<tbody>'+
							'<tr>'+
								'<td rowspan="3" style="width: 90px; height: 100px;"><img src="'+url+'" alt="logo" style="width: 90px; height: 120px;"></td>'+
								'<td colspan="2"><a href="toPerfil-'+respuesta.idPerfil+'">'+respuesta.nombreCompleto+'</a></td>'+
							'</tr>'+
							'<tr>'+
								'<td colspan="3">Mensaje ('+respuesta.visibilidad+'):</td>'+
							'</tr>'+
							'<tr>'+
								'<td colspan="3">'+respuesta.comentario+'</td>'+			
							'</tr>'+
						'</tbody>'+
					'</table>');
		});
}

$(document).on('click','.comentario', function(e){
	var id = (this.id).split("_")[0];
	var id1 = (this.id).split("_")[1];
	
	switch(id){
		case 'responderComentario':
			$("#trTA_"+id1).show();
		break;
		case 'cancel':
			$("#trTA_"+id1).hide();
		break;
		case 'respuesta':
			switch(tipoEntidad){
				case 'usuario':
					if($("#hdnIdPerfil").text() != ""){
						$("#hdnIdEntidadCommentario_"+id1).val($("#hdnIdPerfil").text());
					}else{
						$("#hdnIdEntidadCommentario_"+id1).val('${pageContext.session.getAttribute("idPerfil")}');
					}
				break;
				case 'sospechoso':
					$("#hdnIdEntidadCommentario_"+id1).val($("#hdnIdSospechoso").text());
				break;
				case 'casoCriminal':
					$("#hdnIdEntidadCommentario_"+id1).val($("#hdnIdCaso").text());
				break;
				case 'inmueble':
					$("#hdnIdEntidadCommentario_"+id1).val($("#hdnIdInmueble").text());
				break;
				case 'vehiculo':
					$("#hdnIdEntidadCommentario_"+id1).val($("#hdnIdVehiculo").text());
				break;
			}
			
			$.ajax({
		 		url: 'guardarRespuesta-'+id1,
		 		type: 'post',
		 		dataType: 'json',
		 		data: $("#formComentarios_"+id1).serialize(),
		 		success: function(respuesta){
		 			if(respuesta == true){
		 				$("#txtComentario_"+id1).val("");
			 			$("#trTA_"+id1).hide();
			 			$("#alertasComentario").show();
						$("#alertasComentario").append('<div class="alert alert-success" id="alertaVerde">'+
						 			        '<a class="close" data-dismiss="alert">×</a>'+
						 			        '<strong id="msgVerde">Mensaje guardado correctamente.</strong>'+
						 			    '</div>');
						initComentariosReady();
		 			}		 			
		 		}
		 	});
		break;
	}
	
});


function initComentariosReady(){
	$.ajax({
 		url: 'getComentarios',
 		type: 'post',
 		dataType: 'json',
 		data: $("#formComentarios").serialize(),
 		success: function(comentarios){
 			initComentarios(comentarios);

 			$.ajax({
 		 		url: 'getRespuestas',
 		 		type: 'post',
 		 		dataType: 'json',
 		 		data: $("#formComentarios").serialize(),
 		 		success: function(respuestas){
 			 		initRespuestas(respuestas);
 		 		}
 		 	});			
 		}
 	});
}

$(document).ready(function(){
	$("#hdnTipoEntidadCommentario").val(tipoEntidad);
	
	switch(tipoEntidad){
		case 'usuario':
			if($("#hdnIdPerfil").text() != ""){
				$("#hdnIdEntidadCommentario").val($("#hdnIdPerfil").text());
				idEntidad = $("#hdnIdPerfil").text();
			}else{
				$("#hdnIdEntidadCommentario").val('${pageContext.session.getAttribute("idPerfil")}');
				idEntidad = '${pageContext.session.getAttribute("idPerfil")}';
			}
		break;
		case 'sospechoso':
			$("#hdnIdEntidadCommentario").val($("#hdnIdSospechoso").text());
			idEntidad = $("#hdnIdSospechoso").text();
		break;
		case 'casoCriminal':
			$("#hdnIdEntidadCommentario").val($("#hdnIdCaso").text());
			idEntidad = $("#hdnIdCaso").text();
		break;
		case 'inmueble':
			$("#hdnIdEntidadCommentario").val($("#hdnIdInmueble").text());
			idEntidad = $("#hdnIdInmueble").text();
		break;
		case 'vehiculo':
			$("#hdnIdEntidadCommentario").val($("#hdnIdVehiculo").text());
			idEntidad = $("#hdnIdVehiculo").text();
		break;
	}
	
	initComentariosReady();	
	
	$("#formComentarios").validate({
		submitHandler: function(form){
			$.ajax({
		 		url: 'guardarComentario',
		 		type: 'post',
		 		dataType: 'json',
		 		data: $("#formComentarios").serialize(),
		 		success: function(comentarios){
		 			$("#alertasComentario").show();
					$("#alertasComentario").append('<div class="alert alert-success" id="alertaVerde">'+
					 			        '<a class="close" data-dismiss="alert">×</a>'+
					 			        '<strong id="msgVerde">Mensaje guardado correctamente.</strong>'+
					 			    '</div>');
					$("#txtComentario").val("");
					initComentariosReady();
		 		}
		 	});
		}
	});
});
</script>
<div id="alertasComentario" style="display: none;">
</div>
<div id="divComentarios">
	<div id="divGuardarArchivo">
		<form:form method="post" action="newComentario" id="formComentarios">
			<legend>
				<span class="colored">///</span> Dejar Comentarios: 
			</legend>
			<div id="formularioGuardarComentario">
		        	<textarea class="span8" name="comentario" id="txtComentario" data-rule-required="true" data-msg-required="*"></textarea>
		        	
		        	<div class="control-group">
		        		<label class="control-label">Visibilidad:</label>
		        		<div class="controls">
			        		<select id="sltcVisibility" name="visibilidad">
			        			<option>Público</option>
		                		<option>DIRANDRO</option>
		                		<option>Ministerio Públic</option>
		                		<option>Solo Yo</option>
		              		</select>
		        		</div> 		        		
		        	</div>
		        	
		        	<input type="hidden" id="hdnTipoEntidadCommentario" name="tipoEntidadCommentario">
		        	<input type="hidden" id="hdnIdEntidadCommentario" name="idEntidadCommentario">
			    <div class="form-actions">
		        	<button type="submit" class="btn btn-success" id="guardarArchivos"><i class="icon-comment icon-white"></i> Guardar Comentario</button>
		        	<button type="reset" class="btn btn-danger" id="guardarArchivos"><i class="icon-refresh icon-white"></i> Reset</button>
		        </div>
			</div>
		</form:form>
	</div>
	<div id="divMostrarComentarios">
	
	</div>
</div>