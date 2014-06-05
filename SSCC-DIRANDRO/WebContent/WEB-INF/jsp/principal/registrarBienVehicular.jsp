<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Registrar Bien Vehicular</title>
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
$(document).on('change','#txtFecFabricacion', function(e){
	if($("#txtFecFabricacion").val() != ''){
		var fec = $("#txtFecFabricacion").val();
		$("#hdnFecFab").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}else{
		$("#hdnFecFab").val("");
	}
});
$(document).ready(function() {
	$( ".datepicker" ).datepicker({ dateFormat: 'dd/mm/yy' });
	
	$("#formRegistrarBien").validate({
		rules:{
			partidaRegistral:{required:true, minlength: 8, maxlength: 8},
			descripcion:{required:true, minlength: 10,maxlength: 250},
			marca:{required:true,maxlength:30},
			modelo:{required:true,maxlength:30},
			placa:{required:true,maxlength:30},
			chasis:{required:true,maxlength:50},
			motor:{required:true,maxlength:50},
			color:{required:true,minlength:1,maxlength:30},
			altura:{required:true,doubleNumber:true},
			longitud:{required:true,doubleNumber:true},
			ancho:{required:true,doubleNumber:true},
			pesoBruto:{doubleNumber:true},
			pesoNeto:{doubleNumber:true},
			ruedas:{number:true},
			ejes:{number:true},
			pasajeros:{number:true},
			asientos:{number:true},
			fecFabricacion:{required:true,peruDate:true}
		},
		messages:{
			partidaRegistral:"Complete los 8 carácteres",
			descripcion:"Minimo 10 carácteres, máximo 250 carácteres",
			marca:"Máximo 30 caracteres",
			modelo:"Máximo 30 caracteres",
			placa:"Máximo 30 caracteres",
			chasis:"Máximo 50 caracteres",
			motor:"Máximo 50 caracteres",
			color:"Máximo 30 caracteres",
			altura:"Solo números decimales",
			longitud:"Solo números decimales",
			ancho:"Solo números decimales",
			pesoBruto:"Solo números decimales",
			pesoNeto:"Solo números decimales",
			ruedas:"Solo números",
			ejes:"Solo números",
			pasajeros:"Solo números",
			asientos:"Solo números",
			fecFabricacion: "Debe tener formato de fecha dd/mm/aaaa"
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
			<form:form class="form-horizontal" id="formRegistrarBien" action="registrarVehiculo" commandName="bien">
		       	<legend><span class="colored">///</span> Bien:</legend>
	       		<div class="control-group">
	          		<label class="control-label">Partida Registral: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="partidaRegistral" id="txtPartida" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Descripcion: </label>
	          		<div class="controls">
	          			<textarea class="input-xlarge" name="descripcion" id="txtDescripcion" rows="3" style="width: 400px" data-rule-required="true" data-msg-required="*"></textarea>
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
	          			<input class="span3" type="text" name="txtCasoCriminal" id="txtCasoCriminal" data-rule-required="false">
	          		</div>
	       		</div>
	       		<hr>
	       		
	       		<!-- Bien del tipo vehiculo -->
	       		<div class="control-group">
	          		<label class="control-label">Marca: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="marca" id="txtMarca" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Modelo: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="modelo" id="txtModelo" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Color: </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="color" id="txtColor" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		
	       		<div class="control-group">
	          		<label class="control-label">Placa: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="placa" id="txtPlaca" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Chasis: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="chasis" id="txtChasis" data-rule-required="false">
	          		</div>
	       		</div>
	       		
	       		<div class="control-group">
	          		<label class="control-label">Motor: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="motor" id="txtMotor" data-rule-required="false">
	          		</div>
	       		</div>
	       		
	       		
	       		<div class="control-group">
	          		<label class="control-label">Altura(m): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="altura" id="txtAltura" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Longitud(m): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="longitud" id="txtLongitud" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Ancho(m): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="ancho" id="txtAncho" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		
	       		
	       		<div class="control-group">
	          		<label class="control-label">Peso Bruto(Kg): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name=pesoBruto id="txtPesoBruto" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Peso Neto(Kg): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="pesoNeto" id="txtPesoNeto" data-rule-required="false">
	          		</div>
	       		</div>
	       		
	       		<div class="control-group">
	          		<label class="control-label">Ruedas: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="ruedas" id="txtRuedas" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Ejes: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="ejes" id="txtEjes" data-rule-required="false">
	          		</div>
	       		</div>
	       		
	       		<div class="control-group">
	          		<label class="control-label">Pasajeros: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="pasajeros" id="txtPasajeros" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Asientos: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="asientos" id="txtAsientos" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Fecha de Fabricación: </label>
	          		<div class="controls">
	          			<input class="span2 datepicker" type="text" name="txtFecFabricacion" id="txtFecFabricacion" data-rule-required="true" data-msg-required="*">
	          			<input class="span2" type="hidden" name="fecFabricacion" id="hdnFecFab">
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