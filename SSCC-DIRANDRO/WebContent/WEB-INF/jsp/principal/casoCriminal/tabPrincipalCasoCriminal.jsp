<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(document).ready(function(){

	var idCaso = $("#hdnIdCaso").text();
	
		$.ajax({
	 		url: 'getCaso-'+idCaso,
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(caso){
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
	 				 				
	 			$("#hdrCodigoCaso").append(caso.codigo);
	 			$("#hdrEstado").append(caso.estado);
	 			$("#hdrReferencia").append(caso.referencia);
	 			$("#hdrCreador").append('<a href="toPerfil-'+caso.idPerfil+'">'+caso.primerNombre+ ' ' +caso.segundoNombre+ ' ' +caso.apePaterno+ ' ' +caso.apeMaterno+ '('+caso.tipoFiscal+')</a>');
	 			$("#hdrFecCreacion").text(timeStampFormatted(caso.fecCreacion));
	 			
	 			$("#spnCodigo").append(caso.codigo);
	 			$("#spnEstado").append(caso.estado);
	 			$("#spnFecCreacion").append(timeStampFormatted(caso.fecCreacion));
	 			$("#spnReferencia").append(caso.referencia);
	 			$("#spnAsunto").append(caso.asunto);
	 			$("#spnDescripcion").append(caso.descripcion);
	 		}
	 	});
});
</script>
<div id="divMostrarDatos">
	<form:form class="form-horizontal">
		<fieldset>
			<legend>
				<span class="span3"><span class="colored">///</span> Datos del Caso Criminal:</span>
				<span class="span2 offset3"><button class="btn btn-primary btn-small" type="button"><i class="icon-edit"></i> Editar</button></span>
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
		</fieldset>
	</form:form>
</div>