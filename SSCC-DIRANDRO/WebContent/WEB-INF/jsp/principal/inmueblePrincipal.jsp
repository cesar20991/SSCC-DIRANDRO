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

<!-- para que funcione el jquery -->
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<!-- para que funcione el jquery de la plantilla -->
<script src="js/jquery.js"></script>
<!-- para el menu -->
<script src="js/bootstrap-collapse.js"></script>
<!-- tabs -->
<script src="js/bootstrap-tab.js"></script>
<!-- para los archivos -->
<script src="http://malsup.github.com/jquery.form.js"></script>
<!-- datepicker librerias -->
<script src="js/jquery-ui.js"></script>
<link href="css/smoothness/jquery-ui.css" rel="stylesheet">
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">-->
<!-- validacion -->
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<script src="js/formatDates.js"></script>
<!-- alertas de colores -->
<script src="js/bootstrap-alert.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css"
	media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
</head>
<script type="text/javascript">
var tipoEntidad = "inmueble";
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
			<c:forEach items="${inmuebleList}" var="inmueble">
				<span id="hdnIdInmueble" style="display: none;"><c:out value="${inmueble.idInmueble}" /></span>
			</c:forEach>
			<table class="table table-bordered table-condensed">
				<tbody>
					<tr>
						<td>Codigo:</td>
						<td align="center"><span id="hdrCodigo">&nbsp;</span></td>
						<td>Partida Registral:</td>
						<td align="center"><span id="hdrPartida">&nbsp;</span></td>
					</tr>
					<tr>
						<td>Area Total:</td>
						<td align="center"><span id="hdrAreaTotal">&nbsp;</span> m2</td>
						<td>Direccion:</td>
						<td align="center"><span id="hdrDireccion">&nbsp;</span></td>
					</tr>
					<tr>
						<td>Valor Monetario:</td>
						<td align="center">S/. <span id="hdrValor">&nbsp;</span></td>
						<td>Creado por:</td>
						<td><span id="hdrCreador">&nbsp;</span></td>
					</tr>
				</tbody>
			</table>
		</section>
		<section class="span9" style="margin-left: 80px;">
			<div class="tabbable" style="margin-bottom: 9px;">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#1" data-toggle="tab">Principal</a></li>
					<li class=""><a href="#2" data-toggle="tab">sospechoso</a></li>
					<li class=""><a href="#3" data-toggle="tab">Archivos Adjuntos</a></li>
					<li class=""><a href="#4" data-toggle="tab">Comentarios</a></li>
					<li class=""><a href="#5" data-toggle="tab">Auditoria</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="1">
						<jsp:include page="bien/tabPrincipalInmueble.jsp" />
					</div>
					<div class="tab-pane" id="2">
						<p>Seccion 2.</p>
					</div>
					<div class="tab-pane" id="3">
						<jsp:include page="../componentes/archivos.jsp" />
					</div>
					<div class="tab-pane" id="4">
						<jsp:include page="../componentes/tabComentarios.jsp" />
					</div>
					<div class="tab-pane" id="5">
						<p>Seccion 5.</p>
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