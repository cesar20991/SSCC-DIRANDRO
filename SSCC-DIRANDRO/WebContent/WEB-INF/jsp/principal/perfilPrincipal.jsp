<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Principal</title>
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
<script src="http://malsup.github.com/jquery.form.js"></script>
<!-- alertas de colores -->
<script src="js/bootstrap-alert.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
</head>
<script type="text/javascript">
var tipoEntidad = "usuario";
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
		<c:forEach items="${perfilList}" var="perfil">
			<span id="hdnIdPerfil" style="display: none;"><c:out value="${perfil.idPerfil}" /></span>
			<span id="hdnEntidad" style="display: none;"><c:out value="${perfil.entidadPerteneciente}" /></span>
		</c:forEach>
		<section class="span9" style="margin-left: 80px;">
			<table class="table table-bordered table-condensed">
				<tbody>
					<tr>
						<td>Nombre Completo:</td>
						<td align="center"><span id="hdrPrimerNombe"></span>&nbsp;<span id="hdrSegundoNombe"></span>&nbsp;<span id="hdrApePaterno"></span>&nbsp;<span id="hdrApeMaterno"></span></td>
						<td>Codigo de Usuario:</td>
						<td><span id="hdrCodigo"></span></td>
						<td rowspan="4" align="center" style="width: 90px; height: 100px;" id="tdImagen"></td>
					</tr>
					<tr>
						<td id="tdCargo">Cargo:</td>
						<td><span id="hdrCargo">&nbsp;</span></td>
						<td id="tdGrado">Grado:</td>
						<td id="tdGradoResult"><span id="hdrGrado"></span></td>
					</tr>
					<tr>
						<td>Número de DNI:</td>
						<td><span id="hdrDni">&nbsp;</span></td>
						<td id="tdNCarnet">N° Carnet:</td>
						<td id="tdNCarnetResult"><span id="hdrNCarnet"></span></td>
					</tr>
					<tr>
						<td>Correo Electrónico:</td>
						<td><span id="hdrCorreo">&nbsp;</span></td>
						<td>Entidad:</td>
						<td><span id="hdrEntidad"></span></td>
					</tr>
				</tbody>
			</table>
		</section>
		<section class="span9" style="margin-left: 80px;">
			<div class="tabbable" style="margin-bottom: 9px;">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#1" data-toggle="tab">Principal</a></li>
					<li class=""><a href="#2" data-toggle="tab">Archivos Adjuntos</a></li>
					<li class=""><a href="#3" data-toggle="tab">Comentarios</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="1">
						<jsp:include page="perfil/tabPrincipalPerfil.jsp" />
					</div>
					<div class="tab-pane" id="2">
						<jsp:include page="../componentes/archivos.jsp" />
					</div>
					<div class="tab-pane" id="3">
						<p>Comentarios.</p>
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