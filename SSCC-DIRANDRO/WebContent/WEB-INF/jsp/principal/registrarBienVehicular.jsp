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
<script src="js/jquery-ui.js"></script>
<link href="css/smoothness/jquery-ui.css" rel="stylesheet">
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css"> -->
<!-- para el menu -->
<script src="js/bootstrap-collapse.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<!-- alertas de colores -->
<script src="js/bootstrap-alert.js"></script>
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
var flag = true;
var flag2= true;
$(document).ready(function() {
	$( ".datepicker" ).datepicker({ dateFormat: 'dd/mm/yy' });
	
	$("#formRegistrarBien").validate({
		rules:{
			partidaRegistral:{required:true, minlength: 8, maxlength: 8},
			valor:{required:false,doubleNumber:true},
			descripcion:{required:false, minlength: 10,maxlength: 250},
			marca:{required:false,maxlength:30},
			modelo:{required:false,maxlength:30},
			placa:{required:true,maxlength:30},
			chasis:{required:false,maxlength:50},
			motor:{required:false,maxlength:50},
			color:{required:false,minlength:1,maxlength:30},
			altura:{required:false,doubleNumber:true},
			longitud:{required:false,doubleNumber:true},
			ancho:{required:false,doubleNumber:true},
			pesoBruto:{required:false, doubleNumber:true},
			pesoNeto:{required:false, doubleNumber:true},
			ruedas:{required:false, number:true},
			ejes:{number:true},
			pasajeros:{number:true},
			asientos:{number:true},
			fecFabricacion:{required:true,peruDate:true}
		},
		messages:{
			partidaRegistral:"Complete los 8 carácteres",
			valor:"Solo números decimales",
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
			//form.submit();
			if(flag == true && flag2 == true){
				form.submit();
			}else{
				alert("Debe Corregir los datos");
			}
		}
	});
});
$(document).on('change','#txtPartida', function(e){
	$.ajax({
		url: 'getPartidaRegistral-'+$('#txtPartida').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(bien){
			if(bien == true){
				$("#alertasBienNuevo").show();
				$("#alertasBienNuevo").empty();
				$("#alertasBienNuevo").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">×</a>'+
	 			        '<strong id="msgVerde">Partida Registral usado ya existe.</strong>'+
	 			    '</div>');
				flag = false;
			}else{
				flag = true;
			}
		}
	});
});
//
$(document).on('change','#txtPlaca', function(e){
	$.ajax({
		url: 'getPlaca-'+$('#txtPlaca').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(bien){
			if(bien == true){
				$("#alertasBienNuevo2").show();
				$("#alertasBienNuevo2").empty();
				$("#alertasBienNuevo2").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">×</a>'+
	 			        '<strong id="msgVerde">Placa usada ya existe.</strong>'+
	 			    '</div>');
				flag = false;
			}else{
				flag = true;
			}
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
		<div id="alertasBienNuevo" style="display: none;">
		</div>
		<div id="alertasBienNuevo2" style="display: none;">
		</div>
			<form:form class="form-horizontal" id="formRegistrarBien" action="registrarVehiculo" commandName="bien">
		       	<legend><span class="colored">///</span> Bien:</legend>
	       		<div class="control-group">
	          		<label class="control-label">Partida Registral: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="partidaRegistral" id="txtPartida" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Valor Monetario: </label>
	          		<div class="controls">
	          			<div class="input-prepend">
		          			<span class="add-on">S/.</span>
	          				<input class="span3" type="text" name="valor"  id="txtValor" data-rule-required="true" data-msg-required="*">
	          			</div>
	          		</div>
	       		</div>	   
	       		<div class="control-group">
	          		<label class="control-label">Descripcion: </label>
	          		<div class="controls">
	          			<textarea class="input-xlarge" name="descripcion" id="txtDescripcion" rows="3" style="width: 400px" data-rule-required="true" data-msg-required="*"></textarea>
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
	          		<label class="control-label">Altura: </label>
	          		<div class="controls">
	          			<div class="input-append">
	          				<input class="span2" type="text" name="altura" id="txtAltura" data-rule-required="true" data-msg-required="*">
	          				<span class="add-on">m</span>
	          			</div>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Longitud: </label>
	          		<div class="controls">
	          			<div class="input-append">
		          			<input class="span2" type="text" name="longitud" id="txtLongitud" data-rule-required="true" data-msg-required="*">
		          			<span class="add-on">m</span>
		          		</div>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Ancho: </label>
	          		<div class="controls">
	          			<div class="input-append">
		          			<input class="span2" type="text" name="ancho" id="txtAncho" data-rule-required="true" data-msg-required="*">
		          			<span class="add-on">m</span>
	          			</div>
	          		</div>
	       		</div>
	       		
	       		
	       		<div class="control-group">
	          		<label class="control-label">Peso Bruto: </label>
	          		<div class="controls">
	          			<div class="input-append">
	          				<input class="span2" type="text" name=pesoBruto id="txtPesoBruto" data-rule-required="false">
	          				<span class="add-on">Kg</span>
	          			</div>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Peso Neto: </label>
	          		<div class="controls">
	          			<div class="input-append">
		          			<input class="span2" type="text" name="pesoNeto" id="txtPesoNeto" data-rule-required="false">
		          			<span class="add-on">Kg</span>
	          			</div>
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
