<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Sospechoso</title>
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
<!-- validacion -->
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
</head>
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
			<c:forEach items="${sospechosoList}" var="sospechoso">
				<span id="hdnIdSospechoso" style="display: none;"><c:out value="${sospechoso.idSospechoso}" /></span>
			</c:forEach>
			<table class="table table-bordered table-condensed">
				<tbody>
					<tr>
						<td>Código Único de Identificación:</td>
						<td align="center"><span id="hdrCodigoUnicoDeIdentificacion">&nbsp;</span></td>
						<td rowspan="5" align="center"><img src="img/skills.png" alt="logo" style="margin-bottom: 7px; margin-top: 7px;" /></td>
					</tr>
					<tr>
						<td>Apellidos y Nombres:</td>
						<td><span id="hdrPrimerApellido">&nbsp;</span>&nbsp;&nbsp;<span id="hdrSegundoApellido">&nbsp;</span>&nbsp;<span id="hdrPrenombres">&nbsp;</span></td>
					</tr>
					<tr>
						<td>Alias:</td>
						<td><span id="hdrAlias">&nbsp;</span></td>
					</tr>
					<tr>
						<td>Caso:</td>
						<td><span id="hdrCaso">&nbsp;</span></td>
					</tr>
				</tbody>
			</table>
		</section>
		<section class="span9" style="margin-left: 80px;">
			<div class="tabbable" style="margin-bottom: 9px;">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#1" data-toggle="tab">Principal</a></li>
					<li class=""><a href="#2" data-toggle="tab">Rasgos Particulares</a></li>
					<li class=""><a href="#3" data-toggle="tab">Archivos Adjuntos</a></li>
					<li class=""><a href="#4" data-toggle="tab">Comentarios</a></li>
					<li class=""><a href="#5" data-toggle="tab">Auditoría</a></li>
				</ul>
				<div class="tab-content" style="margin-left: -3.5%;">
					<div class="tab-pane active span9" id="1">
						<jsp:include page="sospechoso/tabPrincipalSospechoso.jsp" />
					</div>
					<div class="tab-pane" id="2">
						<jsp:include page="sospechoso/tabRasgosParticulares.jsp" />
					</div>
					<div class="tab-pane" id="3">
						<p>Seccion 3.</p>
					</div>
					<div class="tab-pane" id="4">
						<p>Seccion 4.</p>
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