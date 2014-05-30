<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Crear Caso</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- para que funcione el jquery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<!-- para que funcione el jquery de la plantilla -->
<script src="js/jquery.js"></script>
<!-- datepicker librerias -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">
<!-- para el menu -->
<script src="js/bootstrap-collapse.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
<style>
.error{
	color: rgb(255, 0, 0);
}
</style>
<script>
$(document).ready(function() {
	
	$("#formCrearCaso").validate({
		submitHandler: function(form){			
			form.submit();
		}
	});
});
</script>
</head>
<body>
<!--HEADER-->
<jsp:include page="../componentes/header.jsp"/>
<!--/HEADER-->
<!--CENTRO-->
<!--MENU-->
<jsp:include page="../componentes/menu.jsp"/>
<!--/MENU-->
<div class="container inner_content">
	<section class="span9" style="margin-left: 80px;">
		<fieldset class="well">
			<form:form class="form-horizontal" id="formCrearCaso" action="crearCaso" commandName="caso">
		       	<legend>
		       		<span class="colored">///</span> Caso Criminal:
		       	</legend>
	       		<div class="control-group">
	          		<label class="control-label">Asunto: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="asunto" id="txtAsunto" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<hr>
	       		<div class="control-group">
	          		<label class="control-label" title="Nombre Clave">Referencia: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="referencia" id="txtReferencia" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<hr>
	       		<div class="control-group">
	          		<label class="control-label">Descripción: </label>
	          		<div class="controls">
	          			<textarea class="input-xlarge" name="descripcion" id="txtDescription" rows="5" data-rule-required="true" data-msg-required="*"></textarea>
	          		</div>
	       		</div>
	       		<div class="form-actions">
		        	<button class="btn btn-success" id="btnCrear" type="submit"><i class="icon-ok icon-white"></i> Crear Caso Criminal</button>
		        	<button class="btn btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset</button>
		        </div> 		       		 
			</form:form>
		</fieldset>
	</section>
</div>
<!-- AGREGADO 29/05/14 -->
<!--/CENTRO-->
<!-- sticky footer -->
<jsp:include page="../componentes/footer.jsp"/>
<!-- /sticky footer -->
</body>
</html>