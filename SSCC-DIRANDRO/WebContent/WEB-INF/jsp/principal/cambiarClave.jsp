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
<!-- alertas de colores -->
<script src="js/bootstrap-alert.js"></script>
<!-- validacion -->
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
<script>
$(document).ready(function() {
	$("#formCambiarClave").validate({
		submitHandler: function(form){
			if($("#txtClaveNueva").val() == $("#txtClaveRep").val()){
				$("#alertBox").hide();
				$("#msgAlert").empty();
				$.ajax({
			 		url: 'cambiarClave',
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formCambiarClave").serialize(),
			 		success: function(result){
			 			if(result == true){
				 			$("#alertBox").removeClass('alert-error');
				 			$("#alertBox").addClass('alert-success');
				 			$("#alertBox").show();
							$("#msgAlert").empty();
							$("#msgAlert").append('Clave cambiada correctamente.');			 				
			 			}else{
				 			$("#alertBox").show();
							$("#msgAlert").empty();
							$("#msgAlert").append('Tu clave Actual no es la correcta.');	
			 			}
			 		}
			 	});
			}else{
				$("#alertBox").show();
				$("#msgAlert").empty();
				$("#msgAlert").append('Las claves nuevas no coinciden.');
			}			
		}
	});
});
</script>
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
				<div class="alert alert-error" id="alertBox" style="display: none;">
			    	<a class="close" data-dismiss="alert">×</a>
			    	<span id="msgAlert"></span>
			    </div>
				<form:form class="form-horizontal" id="formCambiarClave" action="cambiarClave">
					<legend><span class="colored">///</span> Cambiar Clave:</legend>
					<div class="control-group">
						<label class="control-label">Clave Actual: </label>
						<div class="controls">
							<input class="span2" type="password" name="txtClaveActual" id="txtClaveActual" data-rule-required="true" data-msg-required="*">
							<!-- <input class="span2" type="password" name="claveA" id="hdnClaveA"> -->
						</div>
					</div>
					<hr>
					<div class="control-group">
						<label class="control-label">Clave Nueva: </label>
						<div class="controls">
							<input class="span2" type="password" name="txtClaveNueva" id="txtClaveNueva" data-rule-required="true" data-msg-required="*">
							<!-- <input class="span2" type="hidden" name="claveN" id="hdnClaveN"> -->
						</div>
					</div>
					<hr>
					<div class="control-group">
						<label class="control-label">Repetir Clave: </label>
						<div class="controls">
							<input class="span2" type="password" name="txtClaveRep" id="txtClaveRep" data-rule-required="true" data-msg-required="*">
						</div>
					</div>
					<hr>
					<div class="form-actions">
						<button class="btn btn-success" type="submit"><i class="icon-ok icon-white"></i> Cambiar Clave </button>
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