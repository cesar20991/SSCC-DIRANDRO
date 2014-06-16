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

<!-- para que funcione el jquery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<!-- para que funcione el jquery de la plantilla -->
<script src="js/jquery.js"></script>
<!-- para el menu -->
<script src="js/bootstrap-collapse.js"></script>
<!-- tabs -->
<script src="js/bootstrap-tab.js"></script>
<!-- datepicker librerias -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="http://malsup.github.com/jquery.form.js"></script>
<!-- validacion -->
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<script src="js/formatDates.js"></script>
<!-- alertas de colores -->
<script src="js/bootstrap-alert.js"></script>
<!-- mapas -->
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
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
	/*if($("#hdnIdPerfil").text() != ""){
		idEntidad = $("#hdnIdPerfil").text();
	}else{
		idEntidad = '${pageContext.session.getAttribute("idPerfil")}';
	}*/
</script>
<body>

	<!--HEADER-->
	<jsp:include page="../componentes/header.jsp" />
	<!--/HEADER-->
	<!--CENTRO-->
	<!--MENU-->
	<jsp:include page="../componentes/menu.jsp" />
	<!--/MENU-->
	<div class="container inner_content">
		<section class="span9" style="margin-left: 80px;">
			<c:forEach items="${casoList}" var="caso">
				<span id="hdnIdCaso" style="display: none;"><c:out value="${caso.idCasoCriminal}" /></span>
			</c:forEach>
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
		<section class="span9" style="margin-left: 80px;">
			<div class="tabbable" style="margin-bottom: 9px;">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#1" data-toggle="tab">Principal</a></li>
					<li class=""><a href="#2" data-toggle="tab">Personal Asignado</a></li>
					<li class=""><a href="#3" data-toggle="tab">Sospechosos</a></li>
					<li class=""><a href="#4" data-toggle="tab">Bienes</a></li>
					<li class=""><a href="#5" data-toggle="tab">Archivos Adjuntos</a></li>
					<li class=""><a href="#6" data-toggle="tab">Comentarios</a></li>
					<li class=""><a href="#7" data-toggle="tab">Auditoría</a></li>
					<li class=""><a href="#8" data-toggle="tab">Rutas</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="1">
						<jsp:include page="casoCriminal/tabPrincipalCasoCriminal.jsp" />
					</div>
					<div class="tab-pane" id="2">
						<jsp:include page="casoCriminal/tabPersonalAsignado.jsp" />
					</div>
					<div class="tab-pane" id="3">
						<p>Seccion 2.</p>
					</div>
					<div class="tab-pane" id="4">
						<p>Seccion 3.</p>
					</div>
					<div class="tab-pane" id="5">
						<jsp:include page="../componentes/archivos.jsp" />
					</div>
					<div class="tab-pane" id="6">
						<p>Seccion 6.</p>
					</div>
					<div class="tab-pane" id="7">
						<p>Seccion 7.</p>
					</div>
					<div class="tab-pane" id="8">
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