<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Registrar Bien</title>
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
	$( ".datepicker" ).datepicker({ dateFormat: 'dd/mm/yy' });
	
	$("#formRegistrarBien").validate({
		rules:{
			partidaRegistral:{required:true, minlength: 8, maxlength: 8},
			descripcion:{required:true, minlength: 10,maxlength: 250},
			areaTotal:{required:true,doubleNumber:true},
			areaConstruido:{required:true,doubleNumber:true},
			areaCercado:{required:true,doubleNumber:true},
			pisos:{number:true},
			ambientes:{number:true},
			direccion:{required:true, maxlength:100},
			antiguedad:{number:true}
		},
		messages:{
			partidaRegistral:"Complete los 8 carácteres",
			descripcion:"Minimo 10 carácteres, máximo 250 carácteres",
			areaTotal:"Solo números decimales",
			areaConstruido:"Solo números decimales",
			areaCercado:"Solo números decimales",
			pisos:"Solo números",
			ambientes:"Solo números",
			direccion:"Máximo 100 carácteres",
			antiguedad:"Solo números"
		},
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
			<form:form class="form-horizontal" id="formRegistrarBien" action="registrarInmueble" commandName="bien">
		       	<legend><span class="colored">///</span> Bien:</legend>
	       		<div class="control-group">
	          		<label class="control-label">Partida Registral: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="partidaRegistral" maxlength="8" id="txtPartida" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Descripcion: </label>
	          		<div class="controls">
	          			<textarea class="input-xlarge" name="descripcion" id="txtDescripcion" maxlength="250" rows="3" style="width: 400px" data-rule-required="true" data-msg-required="*"></textarea>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Propietario: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="txtPropietario" id="txtPropietario" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Caso Criminal: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="txtCasoCriminal" id="txtCasoCrominal" data-rule-required="false">
	          		</div>
	       		</div>
	       		<hr>
	       
	       		
	       		<!-- Bien del tipo inmueble -->
	       		<div class="control-group" id="divATotal">
	          		<label class="control-label">Area total(m2): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="areaTotal" id="txtAreaTotal" data-rule-required="false" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group" id="divACercado">
	          		<label class="control-label">Area Cercado(m2): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="areaCercado" id="txtAreaCercado" data-rule-required="false" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group" id="divAConstruido">
	          		<label class="control-label">Area Construido(m2): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="areaConstruido" id="txtAreaConstruido" data-rule-required="false" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group" id="divPisos">
	          		<label class="control-label">Pisos: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="pisos" maxlength="2" id="txtPisos" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group" id="divAmbientes">
	          		<label class="control-label">Ambientes: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="ambientes" id="txtAmbientes" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group" id="divDireccion">
	          		<label class="control-label">Dirección: </label>
	          		<div class="controls">
	          			<input class="span4" type="text" name="direccion" id="txtDireccion" maxlength="100" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group" id="divAntiguedad">
	          		<label class="control-label">Antigüedad: </label>
	          		<div class="controls">
	          			<input class="span4" type="text" name="antiguedad" id="txtAntiguedad" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		
	       		
	       		
	       		<div class="form-actions">
		        	<button class="btn btn-success" id="btnRegistrar" type="submit"><i class="icon-ok icon-white"></i> Registrar Bien</button>
		        	<button class="btn btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset</button>
		        </div> 		       		 
			</form:form>
		</fieldset>
	</section>
</div>
<!--/CENTRO-->
<!-- sticky footer -->
<jsp:include page="../componentes/footer.jsp"/>
<!-- /sticky footer -->
</body>
</html>