<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Bien Inmueble</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
<link href="css/plugins/timeline.css" rel="stylesheet">
<link href="css/sb-admin-2.css" rel="stylesheet">
<link href="css/plugins/morris.css" rel="stylesheet">
<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- js -->
<script src="js/jquery-1.11.0.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/plugins/metisMenu/metisMenu.min.js"></script>
<script src="js/sb-admin-2.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<script src="js/formatDates.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>

</head>
<script type="text/javascript">
var tipoEntidad = "inmueble";
var idEntidad = '';

	$(document).on('change','#hdrAreaTotal', function(e){
		if($("#hdrAreaTotal").val('')){
			$("#hdrAreaTotal").val('---');
		}
	});
</script>
<body>
	<div id="wrapper">
		<!--HEADER-->
		<jsp:include page="../componentes/newHeader.jsp" />
		<!--/HEADER-->
		<div id="page-wrapper" style="min-height: 393px;">
			<div class="row">
				<c:forEach items="${inmuebleList}" var="inmueble">
					<span id="hdnIdInmueble" style="display: none;"><c:out value="${inmueble.idInmueble}" /></span>
				</c:forEach>
				<div class="col-lg-12" id="titulo">
					<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
				</div>	
				<div class="col-lg-12">
					<table class="table table-striped table-bordered table-hover">
						<tbody>
							<tr>
								<td>Codigo:</td>
								<td><span id="hdrCodigo">&nbsp;</span></td>
								<td>Partida Registral:</td>
								<td><span id="hdrPartida">&nbsp;</span></td>
								<td rowspan="3" style="width: 10%; height: 50%;" id="tdImagen"><img src="img/casaVerde.jpg" alt="foto" style="width: 90px; height: 120px;"/></td>
							</tr>
							<tr>
								<td>Area Total:</td>
								<td><span id="hdrAreaTotal">&nbsp;</span> m2</td>
								<td>Direccion:</td>
								<td><span id="hdrDireccion">&nbsp;</span></td>
							</tr>
							<tr>
								<td>Valor Monetario:</td>
								<td>S/. <span id="hdrValor">&nbsp;</span></td>
								<td>Creado por:</td>
								<td><span id="hdrCreador">&nbsp;</span></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="col-lg-12">
					<ul class="nav nav-tabs">
		                <li class="active"><a href="#liPrincipal" data-toggle="tab">Principal</a></li>
		                <li class=""><a href="#liSospechoso" data-toggle="tab">Sospechoso</a></li>
						<li class=""><a href="#liArchivosAdjuntos" data-toggle="tab">Archivos Adjuntos</a></li>
						<li class=""><a href="#liComentarios" data-toggle="tab">Comentarios</a></li>
						<li class=""><a href="#liAuditoria" data-toggle="tab">Auditoria</a></li>
		            </ul>
		            <div class="tab-content">
		            	<div class="tab-pane fade active in" id="liPrincipal">
		            		<jsp:include page="bien/tabPrincipalInmueble.jsp" />
		            	</div>
		            	<div class="tab-pane fade" id="liSospechoso">
		            		<p>Sospechoso.</p>
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
		</div>
	</div>
</body>
</html>