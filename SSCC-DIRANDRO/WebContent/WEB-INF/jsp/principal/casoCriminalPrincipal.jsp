<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Caso Criminal</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/datepicker.css" rel="stylesheet">
<link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
<link href="css/plugins/timeline.css" rel="stylesheet">
<link href="css/sb-admin-2.css" rel="stylesheet">
<link href="css/plugins/morris.css" rel="stylesheet">
<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- js -->
<!-- mapas -->
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script src="js/jquery-1.11.0.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script src="js/bootstrap-datepicker.es.js"></script>
<script src="js/plugins/metisMenu/metisMenu.min.js"></script>
<script src="js/sb-admin-2.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<script src="js/formatDates.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="js/plugins/dataTables/jquery.dataTables.js"></script>
<script src="js/plugins/dataTables/dataTables.bootstrap.js"></script>

</head>
<script type="text/javascript">
var tipoEntidad = "casoCriminal";
var idEntidad = '';

$(document).on('click','#btnAsignarDiligencias', function(e){
	$.ajax({
 		url: 'toDiligenciasPre-'+$("#hdnIdCaso").text(),
 		type: 'post',
 		dataType: 'json',
 		data: $("#editarCaso").serialize(),
 		success: function(caso){
 			initCasoCriminal(caso);
 		}
 	});
});
//cambia el estado a pausa por documentacion
$(document).on('click','#btnPasusaDoc', function(e){
	$.ajax({
 		url: 'toPausaDoc-'+$("#hdnIdCaso").text(),
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(caso){
 			initCasoCriminal(caso);
 		}
 	});
});
//para dejar el comentario de pausa por docs
$(document).on('click','#btnComentarioPausaDoc', function(e){
	$.ajax({
 		url: 'dejarComentarioPausaDoc-'+$("#hdnIdCaso").text(),
 		type: 'post',
 		dataType: 'json',
 		data: $("#editarComentario").serialize(),
 		success: function(caso){
 			initCasoCriminal(caso);
 		}
 	});
});
//remover pausa
$(document).on('click','#btnRemoverPausa', function(e){
	$.ajax({
 		url: 'removerPausa-'+$("#hdnIdCaso").text(),
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(caso){
 			initCasoCriminal(caso);
 		}
 	});
});
//para dejar el comentario de pausa por docs
$(document).on('click','#btnPasusaNCaso', function(e){
	$.ajax({
 		url: 'toPausaNCaso-'+$("#hdnIdCaso").text(),
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(caso){
 			initCasoCriminal(caso);
 		}
 	});
});
//para dejar el comentario de pausa por docs
$(document).on('click','#btnComentarioPausaNCaso', function(e){
	$.ajax({
 		url: 'dejarComentarioPausaNCaso-'+$("#hdnIdCaso").text(),
 		type: 'post',
 		dataType: 'json',
 		data: $("#editarComentarioNCaso").serialize(),
 		success: function(caso){
 			initCasoCriminal(caso);
 		}
 	});
});
//para dejar el comentario de pausa por docs
$(document).on('click','#btnCalificacionFiscal', function(e){
	if(contarInformes >= 1){
		$.ajax({
	 		url: 'calificacionFiscal-'+$("#hdnIdCaso").text(),
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(caso){
	 			initCasoCriminal(caso);
	 		}
	 	});
	}else{
		$("#divAlertarCasoCriminal").show();
			$("#divAlertarCasoCriminal").append('<div class="alert alert-success" id="alertaVerde">'+
			 			        '<a class="close" data-dismiss="alert">×</a>'+
			 			       ' <strong>No ha cargado el Informe policial para la calificación.</strong>'+
			 			    '</div>');
	}
});
//para dejar el comentario de pausa por docs
$(document).on('click','#btnCerrarCaso', function(e){
	$.ajax({
 		url: 'cerrarCaso-'+$("#hdnIdCaso").text(),
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(caso){
 			initCasoCriminal(caso);
 		}
 	});
});

//para dejar el comentario de cerrar caso
$(document).on('click','#btnComentarioCerrarCaso', function(e){
	$.ajax({
 		url: 'dejarComentarioCerrarCaso-'+$("#hdnIdCaso").text(),
 		type: 'post',
 		dataType: 'json',
 		data: $("#editarComentarioCerrarCaso").serialize(),
 		success: function(caso){
 			initCasoCriminal(caso);
 		}
 	});
});
</script>
<style>
.error{
	color: rgb(255, 0, 0);
}
</style>
<body>
<div id="wrapper">
	<!--HEADER-->
	<jsp:include page="../componentes/newHeader.jsp" />
	<!--/HEADER-->
	<!--CENTRO-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
			<c:forEach items="${casoList}" var="caso">
				<span id="hdnIdCaso" style="display: none;"><c:out value="${caso.idCasoCriminal}" /></span>
			</c:forEach>
			<div class="col-lg-12" id="titulo">
				<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
			</div>
			<div id="divAlertarCasoCriminal" class="col-lg-12" style="display: none;">
			</div>
			<div class="col-lg-12">
				<table class="table table-striped table-bordered table-hover">
					<tbody>
						<tr>
							<td>Informe:</td>
							<td><span id="hdrCodigoCaso">&nbsp;</span></td>
							<td>Estado:</td>
							<td><span id="hdrEstado">&nbsp;</span></td>
						</tr>
						<tr>
							<td>Referencia:</td>
							<td><span id="hdrReferencia">&nbsp;</span></td>
							<td>Fecha de Creacion:</td>
							<td><span id="hdrFecCreacion">&nbsp;</span></td>
						</tr>
						<tr>
							<td>Creado por:</td>
							<td colspan="3"><span id="hdrCreador">&nbsp;</span></td>						
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-lg-12">
				<table class="table table-striped table-bordered table-hover">
					<tbody>
						<tr>
							<td>Acciones:</td>
							<td id="tdBotones">
								
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-lg-12">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#liPrincipal" data-toggle="tab">Principal</a></li>
					<li class=""><a href="#liPersonalAsignado" data-toggle="tab">Personal Asignado</a></li>
					<li class=""><a href="#liSospechosos" data-toggle="tab">Investigados</a></li>
					<li class=""><a href="#liRutas" data-toggle="tab">Rutas</a></li>
					<li class=""><a href="#liArchivosAdjuntos" data-toggle="tab">Archivos Adjuntos</a></li>
					<li class=""><a href="#liComentarios" data-toggle="tab">Comentarios</a></li>
					<li class=""><a href="#liAuditoria" data-toggle="tab">Auditoría</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane fade active in" id="liPrincipal">
						<jsp:include page="casoCriminal/tabPrincipalCasoCriminal.jsp" />
					</div>
					<div class="tab-pane fade" id="liPersonalAsignado">
						<jsp:include page="casoCriminal/tabPersonalAsignado.jsp" />
					</div>
					<div class="tab-pane fade" id="liSospechosos">
						<jsp:include page="casoCriminal/tabSospechososAsignados.jsp" />
					</div>
					<div class="tab-pane fade" id="liRutas">
						<jsp:include page="casoCriminal/tabRutas.jsp" />
					</div>
					<div class="tab-pane fade" id="liArchivosAdjuntos">
						<jsp:include page="../componentes/archivos.jsp" />
					</div>
					<div class="tab-pane fade" id="liComentarios">
						<jsp:include page="../componentes/tabComentarios.jsp" />
					</div>
					<div class="tab-pane fade" id="liAuditoria">
						<p>Auditoria.</p>
					</div>
				</div>
			</div>
		</div>
		<!-- MODAL -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
       		<div class="modal-dialog">
       			<div class="modal-content">
	       			<div class="modal-header">
	       				<a class="close" data-dismiss="modal">×</a>
		        		<h3>Seleccionar dias para las diligencias preliminares</h3>
	       			</div>
	       			<div class="modal-body">
	       				<form:form id="editarCaso">
	       					<label>Seleccione la cantidad de dias:</label>
			            	<div class="radio-inline">
			            		<select class="form-control" name="diasDiligenciasPreliminares">
				                	<option>20</option>
				                	<option>40</option>
				                	<option>60</option>
				                	<option>80</option>
				                	<option>100</option>
				              	</select>
			            	</div>
	       				</form:form>
	       			</div>
	       			<div class="modal-footer">
				          <a id="btnAsignarDiligencias" class="btn btn-outline btn-success" data-dismiss="modal">Asignar dias</a>
				          <a class="btn btn-outline btn-default" data-dismiss="modal">Cancelar</a>
			          </div>
       			</div>
       		</div>
       	</div>
        <!-- /MODAL -->
        <!-- MODAL PAUSA -->
		<div id="myModalPausaDoc" class="modal hide fade" style="display: none;">
	        <div class="modal-header">
		        <a class="close" data-dismiss="modal">×</a>
		        <h3>¿Desea Dejar un comentario?</h3>
	        </div>
	        <form:form id="editarComentario">
		        <div class="modal-body">
	            	<label class="control-label">Comentario:</label>
	            	<div class="controls inline">
	            		<textarea class="input-xlarge span3" name="cometarioPausaDoc" id="txtCometarioPausaDoc" rows="8" style="width: 90%;"></textarea>
	            	</div>            	
	            </div>
	        </form:form>
          <div class="modal-footer">
	          <a id="btnComentarioPausaDoc" class="btn btn-success" data-dismiss="modal">Guardar Comentario</a>
	          <a class="btn" data-dismiss="modal">Cancelar</a>
          </div>
        </div>
        <!-- /MODAL PAUSA -->
        <!-- MODAL PAUSA -->
		<div id="myModalCerrarCaso" class="modal hide fade" style="display: none;">
	        <div class="modal-header">
		        <a class="close" data-dismiss="modal">×</a>
		        <h3>¿Desea Dejar un comentario?</h3>
	        </div>
	        <form:form id="editarComentarioCerrarCaso">
		        <div class="modal-body">
	            	<label class="control-label">Comentario:</label>
	            	<div class="controls inline">
	            		<textarea class="input-xlarge span3" name="cometarioPausaDoc" id="txtCometarioPausaDoc" rows="8" style="width: 90%;"></textarea>
	            	</div>            	
	            </div>
	        </form:form>
          <div class="modal-footer">
	          <a id="btnComentarioCerrarCaso" class="btn btn-success" data-dismiss="modal">Guardar Comentario</a>
	          <a class="btn" data-dismiss="modal">Cancelar</a>
          </div>
        </div>
        <!-- /MODAL PAUSA -->
        <!-- MODAL PAUSA NUEVO CASO -->
		<div id="myModalPausaNCaso" class="modal hide fade" style="display: none;">
	        <div class="modal-header">
		        <a class="close" data-dismiss="modal">×</a>
		        <h3>¿Desea Dejar un comentario?</h3>
	        </div>
	        <form:form id="editarComentarioNCaso">
		        <div class="modal-body">
	            	<label class="control-label">Comentario:</label>
	            	<div class="controls inline">
	            		<textarea class="input-xlarge span3" name="cometarioPausaNCaso" id="txtCometarioPausaNCaso" rows="8" style="width: 90%;"></textarea>
	            	</div>            	
	            </div>
	        </form:form>
          <div class="modal-footer">
	          <a id="btnComentarioPausaNCaso" class="btn btn-success" data-dismiss="modal">Guardar Comentario</a>
	          <a class="btn" data-dismiss="modal">Cancelar</a>
          </div>
        </div>
        <!-- /MODAL PAUSA NUEVO CASO  -->
	</div>
	<!--/CENTRO-->
</div>
</body>
</html>