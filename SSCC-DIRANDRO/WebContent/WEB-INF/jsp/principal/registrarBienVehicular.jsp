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

<!-- styles -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/datepicker.css" rel="stylesheet">
<link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
<link href="css/plugins/timeline.css" rel="stylesheet">
<link href="css/sb-admin-2.css" rel="stylesheet">
<link href="css/plugins/morris.css" rel="stylesheet">
<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- js -->
<script src="js/jquery-1.11.0.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script src="js/bootstrap-datepicker.es.js"></script>
<script src="js/plugins/metisMenu/metisMenu.min.js"></script>
<script src="js/sb-admin-2.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>

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
	
	$('#sandbox-container .input-group.date').datepicker({
		format: "dd/mm/yyyy",
		language: "es",
	    autoclose: true,
	    todayHighlight: true
	});
	
	//$( ".datepicker" ).datepicker({ dateFormat: 'dd/mm/yy' });
	
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
<jsp:include page="../componentes/newHeader.jsp"/>
<!--/HEADER-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
		
			<div class="col-lg-12" id="titulo">
				<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
			</div>
			
			<div class="panel panel-default col-md-6 col-md-offset-1">
				<div class="panel-heading">
					/// Bien:
				</div>
				<div class="panel-body">
				<div id="alertasBienNuevo" style="display: none;">
				</div>
				<div id="alertasBienNuevo2" style="display: none;">
				</div>
				<form:form class="form-horizontal" id="formRegistrarBien" action="registrarVehiculo" commandName="bien">
					<div class="form-group">
		          		<label>Partida Registral: </label>
		          		<input class="form-control" type="text" name="partidaRegistral" id="txtPartida" data-rule-required="true" data-msg-required="*">
		       		</div>
		       		<div class="form-group">
		          		<label>Valor Monetario: </label>
	          			<div class="input-prepend input-group">
		          			<span class="input-group-addon">S/.</span>
	          				<input class="form-control" type="text" name="valor"  id="txtValor" data-rule-required="true" data-msg-required="*">
	          			</div>
		       		</div>	   
		       		<div class="form-group">
		          		<label>Descripcion: </label>
		          		<textarea class="form-control" name="descripcion" id="txtDescripcion" rows="3" data-rule-required="true" data-msg-required="*"></textarea>
		       		</div>		       		
		       		<!-- Bien del tipo vehiculo -->
		       		<div class="form-group">
		          		<label>Marca: </label>
		          		<input class="form-control" type="text" name="marca" id="txtMarca" data-rule-required="true" data-msg-required="*">
		       		</div>
		       		<div class="form-group">
		          		<label>Modelo: </label>
		          		<input class="form-control" type="text" name="modelo" id="txtModelo" data-rule-required="false">
		       		</div>
		       		<div class="form-group">
		          		<label>Color: </label>
		          		<input class="form-control" type="text" name="color" id="txtColor" data-rule-required="true" data-msg-required="*">
		       		</div>
		       		
		       		<div class="form-group">
		          		<label>Placa: </label>
		          		<input class="form-control" type="text" name="placa" id="txtPlaca" data-rule-required="true" data-msg-required="*">
		       		</div>
		       		<div class="form-group">
		          		<label>Chasis: </label>
		          		<input class="form-control" type="text" name="chasis" id="txtChasis" data-rule-required="false">
		       		</div>
		       		
		       		<div class="form-group">
		          		<label>Motor: </label>
		          		<input class="form-control" type="text" name="motor" id="txtMotor" data-rule-required="false">
		       		</div>
		       		
		       		<div class="form-group">
		          		<label>Altura: </label>
	          			<div class="input-append input-group">
	          				<input class="form-control" type="text" name="altura" id="txtAltura" data-rule-required="true" data-msg-required="*">
	          				<span class="input-group-addon">m</span>
	          			</div>
		       		</div>
		       		<div class="form-group">
		          		<label>Longitud: </label>
	          			<div class="input-append input-group">
		          			<input class="form-control" type="text" name="longitud" id="txtLongitud" data-rule-required="true" data-msg-required="*">
		          			<span class="input-group-addon">m</span>
		          		</div>
		       		</div>
		       		<div class="form-group">
		          		<label>Ancho: </label>
	          			<div class="input-append input-group">
		          			<input class="form-control" type="text" name="ancho" id="txtAncho" data-rule-required="true" data-msg-required="*">
		          			<span class="input-group-addon">m</span>
	          			</div>
		       		</div>
		       		
		       		
		       		<div class="form-group">
		          		<label>Peso Bruto: </label>
	          			<div class="input-append input-group">
	          				<input class="form-control" type="text" name=pesoBruto id="txtPesoBruto" data-rule-required="false">
	          				<span class="input-group-addon">Kg</span>
	          			</div>
		       		</div>
		       		<div class="form-group">
		          		<label>Peso Neto: </label>
	          			<div class="input-append input-group">
		          			<input class="form-control" type="text" name="pesoNeto" id="txtPesoNeto" data-rule-required="false">
		          			<span class="input-group-addon">Kg</span>
	          			</div>
		       		</div>
		       		
		       		<div class="form-group">
		          		<label>Ruedas: </label>
		          		<input class="form-control" type="text" name="ruedas" id="txtRuedas" data-rule-required="false">
		       		</div>
		       		<div class="form-group">
		          		<label>Ejes: </label>
		          		<input class="form-control" type="text" name="ejes" id="txtEjes" data-rule-required="false">
		       		</div>
		       		
		       		<div class="form-group">
		          		<label>Pasajeros: </label>
		          		<input class="form-control" type="text" name="pasajeros" id="txtPasajeros" data-rule-required="false">
		       		</div>
		       		<div class="form-group">
		          		<label>Asientos: </label>
		          		<input class="form-control" type="text" name="asientos" id="txtAsientos" data-rule-required="false">
		       		</div>
		       		<div class="form-group">
		          		<label>Fecha de Fabricación: </label>
		          		<div id="sandbox-container">
		          			<div class="input-group date">
			          			<input class="form-control" type="text" name="txtFecFabricacion" id="txtFecFabricacion" data-rule-required="true" data-msg-required="*">
			          			<span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
		          			</div>
	          			</div>
	          			<input class="span2" type="hidden" name="fecFabricacion" id="hdnFecFab">
		          	</div>
		          	<hr class="">			
		       		<div class="well">
			       		<button class="btn btn-outline btn-success" id="btnRegistrar" type="submit"><i class="icon-ok icon-white"></i> Registrar Bien</button>
			        	<button class="btn btn-outline btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset</button>
		       		</div>
				</form:form>
				</div>
			</div>
		</div>
	</div>
<!--CENTRO-->
<!-- <div class="container inner_content">
	<section class="span9" style="margin-left: 80px;">
		<fieldset class="well">
		
			
		       	<legend><span class="colored">///</span> Bien:</legend>
	       		
	       		
	       		<div class="form-actions">
		        	<
		        </div> 		   
		</fieldset>
	</section>
</div> -->
<!--/CENTRO-->
</body>
</html>
