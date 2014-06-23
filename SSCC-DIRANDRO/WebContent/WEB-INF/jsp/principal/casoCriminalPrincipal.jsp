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
<!-- mapas -->
 <script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<!-- para que funcione el jquery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<!-- para que funcione el jquery de la plantilla -->
<script src="js/jquery.js"></script>
<!-- para el menu -->
<script src="js/bootstrap-collapse.js"></script>
<!-- tabs -->
<script src="js/bootstrap-tab.js"></script>
<!-- datepicker librerias -->
<script src="js/jquery-ui.js"></script>
<link href="css/smoothness/jquery-ui.css" rel="stylesheet">
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css"> -->
<script src="http://malsup.github.com/jquery.form.js"></script>
<!-- validacion -->
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<script src="js/formatDates.js"></script>
<!-- alertas de colores -->
<script src="js/bootstrap-alert.js"></script>
 
<!-- modal -->
<script src="js/bootstrap-modal.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
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
</script>
<style>
.error{
	color: rgb(255, 0, 0);
}
</style>
<body>

	<!--HEADER-->
	<jsp:include page="../componentes/header.jsp" />
	<!--/HEADER-->
	<!--CENTRO-->
	<!--MENU-->
	<jsp:include page="../componentes/menu.jsp" />
	<!--/MENU-->
	<div class="container inner_content">
		<section class="span9" style="margin-left: 7%;">
			<c:forEach items="${casoList}" var="caso">
				<span id="hdnIdCaso" style="display: none;"><c:out value="${caso.idCasoCriminal}" /></span>
			</c:forEach>
			<div id="divAlertarCasoCriminal" style="display: none;">
			</div>
			<table class="table table-bordered table-condensed">
				<tbody>
					<tr>
						<td>Informe:</td>
						<td align="center"><span id="hdrCodigoCaso">&nbsp;</span></td>
						<td>Estado:</td>
						<td align="center"><span id="hdrEstado">&nbsp;</span></td>
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
		</section>
		<!-- Acciones -->
		<section class="span9" style="margin-left: 7%; height: 1px;">
			<table class="table table-bordered table-condensed" style="margin-top: -6%;">
				<tbody>
					<tr>
						<td>Acciones:</td>
						<td id="tdBotones">
							
						</td>
					</tr>
				</tbody>
			</table>
		</section>
		<!-- /Acciones -->
		<!-- MODAL -->
		<div id="myModal" class="modal hide fade" style="display: none;">
	        <div class="modal-header">
		        <a class="close" data-dismiss="modal">×</a>
		        <h3>Seleccionar dias para las diligencias preliminares</h3>
	        </div>
	        <form:form id="editarCaso">
		        <div class="modal-body">
	            	<label class="control-label">Seleccione la cantidad de dias:</label>
	            	<div class="controls inline">
	            		<select class="span2" name="diasDiligenciasPreliminares">
		                	<option>20</option>
		                	<option>40</option>
		                	<option>60</option>
		                	<option>80</option>
		                	<option>100</option>
		              	</select>
	            	</div>            	
	            </div>
	        </form:form>
          <div class="modal-footer">
	          <a id="btnAsignarDiligencias" class="btn btn-success" data-dismiss="modal">Asignar dias</a>
	          <a class="btn" data-dismiss="modal">Cancelar</a>
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
        <!-- TABS -->
		<section class="span9" style="margin-left: 7%;">
			<div class="tabbable" style="margin-top: -6%;">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#1" data-toggle="tab">Principal</a></li>
					<li class=""><a href="#2" data-toggle="tab">Personal Asignado</a></li>
					<li class=""><a href="#3" data-toggle="tab">Sospechosos</a></li>
					<li class=""><a href="#4" data-toggle="tab">Archivos Adjuntos</a></li>
					<li class=""><a href="#5" data-toggle="tab">Comentarios</a></li>
					<li class=""><a href="#6" data-toggle="tab">Auditoría</a></li>
					<li class=""><a href="#7" data-toggle="tab">Rutas</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="1">
						<jsp:include page="casoCriminal/tabPrincipalCasoCriminal.jsp" />
					</div>
					<div class="tab-pane" id="2">
						<jsp:include page="casoCriminal/tabPersonalAsignado.jsp" />
					</div>
					<div class="tab-pane" id="3">
						<jsp:include page="casoCriminal/tabSospechososAsignados.jsp" />
					</div>
					<div class="tab-pane" id="4">
						<jsp:include page="../componentes/archivos.jsp" />
					</div>
					<div class="tab-pane" id="5">
						<jsp:include page="../componentes/tabComentarios.jsp" />
					</div>
					<div class="tab-pane" id="6">
						<p>Seccion 7.</p>
					</div>
					<div class="tab-pane" id="7">
						<jsp:include page="casoCriminal/tabRutas.jsp" />
					</div>
				</div>
			</div>
		</section>
	</div>
	<!--/CENTRO-->
	<!-- sticky footer -->
	<jsp:include page="../componentes/footer.jsp" />
	<!-- /sticky footer -->
</body>
</html>