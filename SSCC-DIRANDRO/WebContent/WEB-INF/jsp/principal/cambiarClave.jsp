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
			<fieldset class="well">
				<form:form class="form-horizontal" id="formCrearSospechoso"
					action="crearSospechoso" commandName="sospechoso">
					<legend>
						<span class="colored">///</span> Cambiar Clave:
					</legend>
					<div class="control-group">
						<label class="control-label">Código Único de Identificación: </label>
						<div class="controls">
							<input class="span2" type="text" name="txtCodUnico" id="txtCodUnico" data-rule-required="true" data-msg-required="*">
							<input class="span2" type="hidden" name="codigoUnicoDeIdentificacion" id="hdnCodUnico">
						</div>
					</div>
					<hr>
					<div class="control-group">
						<label class="control-label">Primer Apellido: </label>
						<div class="controls">
							<input class="span2" type="text" name="primerApellido" data-rule-required="true" data-msg-required="*">
						</div>
					</div>
					<hr>
					<div class="control-group">
						<label class="control-label">Segundo Apellido: </label>
						<div class="controls">
							<input class="span2" type="text" name="segundoApellido" data-rule-required="true" data-msg-required="*">
						</div>
					</div>
					<hr>
					<div class="form-actions">
						<button class="btn btn-success" id="btnGuardar" type="submit"><i class="icon-ok icon-white"></i> Cambiar Clave </button>
						<button class="btn btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset </button>
					</div>
				</form:form>
			</fieldset>
		</section>
	</div>
	<!--/CENTRO-->
	<!-- sticky footer -->
	<jsp:include page="../componentes/footer.jsp" />
	<!-- /sticky footer -->
</body>
</html>