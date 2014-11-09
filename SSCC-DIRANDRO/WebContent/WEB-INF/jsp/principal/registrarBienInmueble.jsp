<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Registrar Bien Inmueble</title>
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
var flag = false;
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
			areaTotal:{required:false,doubleNumber:true},
			areaConstruido:{required:false,doubleNumber:true},
			areaCercado:{required:false,doubleNumber:true},
			pisos:{required:false, number:true},
			ambientes:{required:false, number:true},
			direccion:{required:true, maxlength:100},
			antiguedad:{required:false, number:true}
		},
		messages:{
			partidaRegistral:"Complete los 8 carácteres",
			valor:"Solo números decimales",
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
			//form.submit();
			if(flag == true){
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
</script>
</head>
<body>
<!--HEADER-->
<jsp:include page="../componentes/newHeader.jsp"/>
<!--/HEADER-->
<!--CENTRO-->
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
				<form:form class="form-horizontal" id="formRegistrarBien" action="registrarInmueble" commandName="bien">
					<div class="form-group">
		          		<label >Partida Registral: </label>
		          		<input class=form-control type="text" name="partidaRegistral" maxlength="8" id="txtPartida" data-rule-required="true" data-msg-required="*">
		       		</div>
		       		<div class="form-group">
		          		<label >Valor Monetario: </label>
	          			<div class="input-prepend input-group">
		          			<span class="input-group-addon">S/.</span>
	          				<input class="form-control" type="text" name="valor"  id="txtValor" data-rule-required="true" data-msg-required="*">
	          			</div>
		       		</div>	       		
		       		<div class="form-group">
		          		<label >Descripcion: </label>
		          		<textarea class="form-control" rows="3" name="descripcion" id="txtDescripcion" maxlength="250" data-rule-required="true" data-msg-required="*"></textarea>
		       		</div>
		       		<!-- Bien del tipo inmueble -->
		       		<div class="form-group" id="divATotal">
		          		<label >Area total: </label>
	          			<div class="input-append input-group">
	          				<input class="form-control" type="text" name="areaTotal" id="txtAreaTotal" data-rule-required="false" data-msg-required="*">
	          				<span class="input-group-addon">m2</span>
	          			</div>
		       		</div>
		       		<div class="form-group" id="divACercado">
		          		<label >Area Cercado: </label>
	          			<div class="input-append input-group">
	          				<input class="form-control" type="text" name="areaCercado" id="txtAreaCercado" data-rule-required="false" data-msg-required="*">
	          				<span class="input-group-addon">m2</span>
	          			</div>
		       		</div>
		       		<div class="form-group" id="divAConstruido">
		          		<label >Area Construido: </label>
	          			<div class="input-append input-group">
		          			<input class="form-control" type="text" name="areaConstruido" id="txtAreaConstruido" data-rule-required="false" data-msg-required="*">
		          			<span class="input-group-addon">m2</span>
	          			</div>
		       		</div>
		       		<div class="form-group" id="divPisos">
		          		<label >Pisos: </label>
		          		<input class="form-control" type="text" name="pisos" maxlength="2" id="txtPisos" data-rule-required="true" data-msg-required="*">
		       		</div>
		       		<div class="form-group" id="divAmbientes">
		          		<label >Ambientes: </label>
		          		<input class="form-control" type="text" name="ambientes" id="txtAmbientes" data-rule-required="true" data-msg-required="*">
		       		</div>
		       		<div class="form-group" id="divDireccion">
		          		<label >Dirección: </label>
		          		<input class="form-control" type="text" name="direccion" id="txtDireccion" maxlength="100" data-rule-required="true" data-msg-required="*">
		       		</div>
		       		<div class="form-group" id="divAntiguedad">
		          		<label >Antigüedad: </label>
		          		<div class="input-append input-group">
		          			<input class="form-control" type="text" name="antiguedad" id="txtAntiguedad" data-rule-required="true" data-msg-required="*">
		          			<span class="input-group-addon">Años</span>
		          		</div>	 
		       		</div>
		       		<hr class="">			
		       		<div class="well">
		       			<button class="btn btn-outline btn-success" id="btnRegistrar" type="submit"><i class="fa fa-check"></i> Registrar Bien</button>
		        		<button class="btn btn-outline btn-danger" type="reset"><i class="fa fa-refresh fa-fw"></i> Reset</button>
		       		</div>
				</form:form>
				</div>
			</div>
		</div>
	</div>
<!--/CENTRO-->
</body>
</html>