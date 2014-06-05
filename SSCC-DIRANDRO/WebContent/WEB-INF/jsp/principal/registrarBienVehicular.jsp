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
			txtDescripcion:{minlength:10, maxlength:250},
			txtAltura:{doubleNumber:true},
			txtLongitud:{doubleNumber:true},
			txtAncho:{doubleNumber:true},
			txtPesoBruto:{doubleNumber:true},
			txtPesoNeto:{doubleNumber:true},
			txtRuedas:{number:true},
			txtEjes:{number:true},
			txtPasajeros:{number:true},
			txtAsientos:{number:true},
			txtColor:{required:true,minlength:1,maxlength:30},
			txtFecFabricacion:{peruDate:true}
		},
		messages:{
			txtDescripcion:"Máximo 250 caracteres",
			txtAltura:"Solo números decimales",
			txtLongitud:"Solo números decimales",
			txtAncho:"Solo números decimales",
			txtPesoBruto:"Solo números decimales",
			txtPesoNeto:"Solo números decimales",
			txtRuedas:"Solo números",
			txtEjes:"Solo números",
			txtPasajeros:"Solo números",
			txtAsientos:"Solo números",
			txtColor:"Máximo 30 caracteres",
			txtFecFabricacion: "Debe tener formato de fecha dd/mm/aaaa"
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
			<form:form class="form-horizontal" id="formRegistrarBien" action="registrarBien" commandName="bien">
		       	<legend><span class="colored">///</span> Bien:</legend>
	       		<div class="control-group">
	          		<label class="control-label">Partida Registral: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="txtPartida" id="txtPartida" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Descripcion: </label>
	          		<div class="controls">
	          			<textarea class="input-xlarge" name="txtDescripcion" id="txtDescripcion" rows="3" style="width: 400px" data-rule-required="true" data-msg-required="*"></textarea>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Propietario: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="txtPropietario" id="txtPropietario" data-rule-required="false">
	          		</div>
	       		</div>
	       		<hr>
	       		
	       		<!-- Bien del tipo vehiculo -->
	       		
	       		<div class="control-group">
	          		<label class="control-label">Placa: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="txtPlaca" id="txtPlaca" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Chasis: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="txtChasis" id="txtChasis" data-rule-required="false">
	          		</div>
	       		</div>
	       		
	       		<div class="control-group">
	          		<label class="control-label">Motor: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="txtMotor" id="txtMotor" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Marca: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="txtMarca" id="txtMarca" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Modelo: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="txtModelo" id="txtModelo" data-rule-required="false">
	          		</div>
	       		</div>
	       		
	       		<div class="control-group">
	          		<label class="control-label">Altura(m): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="txtAltura" id="txtAltura" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Longitud(m): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="txtLongitud" id="txtLongitud" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Ancho(m): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="txtAncho" id="txtAncho" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		
	       		
	       		<div class="control-group">
	          		<label class="control-label">Peso Bruto(Kg): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="txtPesoBruto" id="txtPesoBruto" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Peso Neto(Kg): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="txtPesoNeto" id="txtPesoNeto" data-rule-required="false">
	          		</div>
	       		</div>
	       		
	       		<div class="control-group">
	          		<label class="control-label">Ruedas: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="txtRuedas" id="txtRuedas" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Ejes: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="txtEjes" id="txtEjes" data-rule-required="false">
	          		</div>
	       		</div>
	       		
	       		<div class="control-group">
	          		<label class="control-label">Pasajeros: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="txtPasajeros" id="txtPasajeros" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Asientos: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="txtAsientos" id="txtAsientos" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Color: </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="txtColor" id="txtColor" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Fecha de Fabricación: </label>
	          		<div class="controls">
	          			<input class="span2 datepicker" type="text" name="txtFecFabricacion" id="txtFecFabricacion" data-rule-required="true" data-msg-required="*">
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