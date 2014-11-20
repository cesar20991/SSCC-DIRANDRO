<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Crear Investigado</title>
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
$(document).on('change','#txtFecNac', function(e){
	if($("#txtFecNac").val() != ''){
		var fec = $("#txtFecNac").val();
		$("#hdnFecNac").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});
$(document).on('change','#txtInscripcion', function(e){
	if($("#txtInscripcion").val() != ''){
		var fec = $("#txtInscripcion").val();
		$("#hdnFecIns").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});
$(document).on('change','#txtEmision', function(e){
	if($("#txtEmision").val() != ''){
		var fec = $("#txtEmision").val();
		$("#hdnFecEmi").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});

var flag = false;
var flag2 = false;
$(document).ready(function() {
	
	$('#sandbox-container .input-group.date').datepicker({
		format: "dd/mm/yyyy",
		language: "es",
	    autoclose: true,
	    todayHighlight: true
	});
	
	//$( ".datepicker" ).datepicker({ dateFormat: 'dd/mm/yy' });
	
	$("#formCrearSospechoso").validate({
		rules:{
			txtFecNac: {peruDate: true},
			txtEstatura: {doubleNumber: true},
			txtInscripcion: {peruDate: true},
			txtEmision: {peruDate: true},
			txtCodUnico: {number: true, minlength: 8, maxlength: 8},
			multasElectoraleso:{number:true, maxlength:4}
		},
		messages:{
			txtFecNac: "Debe tener formato de fecha dd/mm/aaaa",
			txtEstatura: "Solo Números",
			txtInscripcion: "Debe tener formato de fecha dd/mm/aaaa",
			txtEmision: "Debe tener formato de fecha dd/mm/aaaa",
			multasElectoraleso:"Sólo Números",
			txtCodUnico: "Sólo Números, 8 digitos",
			txtCodUnico: "Código Único de Identificación ya existes."
		},
		submitHandler: function(form){
			//Se usa 1000-12-12 para que pase de la vista al controlador
			//y en el implements se seteara como null.
			if($("#txtFecNac").val() == ''){
				$("#hdnFecNac").val('1000-12-12');
			}
			
			if($("#txtInscripcion").val() == ''){
				$("#hdnFecIns").val('1000-12-12');
			}
			
			$("#hdnEstatura").val($("#txtEstatura").val());
			$("#hdnCodUnico").val($("#txtCodUnico").val());
			
// 			if($("#txtEmision").val() == ''){
// 				$("#hdnFecEmi").val('1000-12-12');
// 			}
			if(flag == true && flag2 == true){
				form.submit();
			}else if($("#txtCodUnico").val() == ''){
				form.submit();
			}else{
				alert("Debe Corregir los datos");
			}			
		}
	});
});
$(document).on('change','#txtAlias', function(e){
	$.ajax({
		url: 'getAlias-'+$('#txtAlias').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(sospechoso){
			if(sospechoso == true){
				$("#alertasSospechosoNuevo").show();
				$("#alertasSospechosoNuevo").empty();
				$("#alertasSospechosoNuevo").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">×</a>'+
	 			        '<strong id="msgVerde">El Alias usado ya existe en otro Investigado.</strong>'+
	 			    '</div>');
				flag = false;
			}else{
				flag = true;
			}
		}
	});
});
$(document).on('change','#txtCodUnico', function(e){
	$.ajax({
		url: 'getCUI-'+$('#txtCodUnico').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(sospechoso){
			if(sospechoso == true){
				$("#alertasSospechosoNuevo2").show();
				$("#alertasSospechosoNuevo2").empty();
				$("#alertasSospechosoNuevo2").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">×</a>'+
	 			        '<strong id="msgVerde">El Código Único de Identificación usado ya existe en otro Investigado.</strong>'+
	 			    '</div>');
				flag2 = false;
			}else{
				flag2 = true;
			}
		}
	});
});
</script>
</head>
<body>
<div id="wrapper">
	<!--HEADER-->
	<jsp:include page="../componentes/newHeader.jsp"/>
	<!--/HEADER-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
		
			<div class="col-lg-12" id="titulo">
				<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
			</div>
			
			<div class="panel panel-default col-md-12">
				<div class="panel-heading">
					/// Datos Personales del Sospechoso:
				</div>
				<div class="panel-body">
				<div id="alertasSospechosoNuevo" style="display: none;">
				</div>
				<div id="alertasSospechosoNuevo2" style="display: none;">
				</div>
				<form:form class="form-horizontal" id="formCrearSospechoso" action="crearSospechoso" commandName="sospechoso">
					<div class="col-lg-5">
						<div class="form-group">
			          		<label title="Tipo de documento">Tipo de Documento: </label>
		          			<select class="form-control" name="tipodocumento">
		          				<option value="DNI">DNI</option>
		          				<option value="Carnet Extranjeria">CARNET DE EXTRANJERIA</option>
		          				<option value="Pasaporte">Pasaporte</option>
		          				<option value="Otros">Otros</option>		          				
		          			</select>
			       		</div>
						<div class="form-group">
			          		<label title="Código Único de Identificación">Número de Documento: </label>
		          			<input class="form-control" type="text" name="txtCodUnico" id="txtCodUnico">
			       		</div>
			       		<input class="span2" type="hidden" name="codigoUnicoDeIdentificacion" id="hdnCodUnico">
			       		<div class="form-group">
			          		<label>Primer Apellido: </label>
			          		<input class="form-control" type="text" name="primerApellido">
			       		</div>
			       		<div class="form-group">
			          		<label>Segundo Apellido: </label>
			          		<input class="form-control" type="text" name="segundoApellido">
			       		</div>
			       		<div class="form-group">
			          		<label>Prenombres: </label>
			          		<input class="form-control" type="text" name="preNombres">
			       		</div>
			       		<div class="form-group">
			          		<label>Alias: </label>
			          		<input class="form-control" type="text" name="alias" id="txtAlias" data-rule-required="true" data-msg-required="*">
			       		</div>
			       		<div class="form-group">
			          		<label>Sexo: </label>
			          		<label class="radio-inline">
			          			<input type="radio" name="sexo" id="" value="M">Masculino
			          		</label>
			          		<label class="radio-inline">
			          			<input type="radio" name="sexo" id="" value="F">Femenino
			          		</label>
			       		</div>
			       		<div class="form-group">
			          		<label>Fecha de Nacimiento: </label>
			          		<div id="sandbox-container">
				          		<div class="input-group date">
			          				<input class="form-control" type="text" name="txtFecNac" id="txtFecNac">
			          				<span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
			          			</div>
		          			</div>
			       		</div>
			       		<input class="span2" type="hidden" name="fechaDeNacimiento" id="hdnFecNac">
			       		<div class="form-group">
			          		<label class="control-label">Departamento de Nacimiento: </label>
			          		<select class="form-control" name="departamentoDeNacimiento">
			          			<jsp:include page="../componentes/selectDepartamento.jsp" />
			          		</select>
			       		</div>
			       		<div class="form-group">
			          		<label>Provincia de Nacimiento: </label>
			          		<select class="form-control" name="provinciaDeNacimiento">
			          			<jsp:include page="../componentes/selectProvincia.jsp" />
			          		</select>
				          	<!-- <input class="form-control" type="text" name="provinciaDeNacimiento"> -->
			       		</div>
			       		<div class="form-group">
			          		<label>Distrito de Nacimiento: </label>
			          		<select class="form-control" name="provinciaDistrito">
			          			<jsp:include page="../componentes/selectDistrito.jsp" />
			          		</select>
			          		<!-- <input class="form-control" type="text" name="distritoDeNacimiento"> -->
			       		</div>
					</div>
					<div class="col-lg-5 col-md-offset-1">
						<div class="form-group">
			          		<label>Estatura: </label>
		          			<input class="form-control" type="text" name="txtEstatura" id="txtEstatura">
			       		</div>
		          		<input class="span2" type="hidden" name="estatura" id="hdnEstatura">
		          		<!-- <div class="form-group">
			          		<label>Fecha de Inscripción: </label>
			          		<div id="sandbox-container">
				          		<div class="input-group date">
			          				<input class="form-control" type="text" name="txtInscripcion" id="txtInscripcion">
			          				<span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
			          			</div>
		          			</div>
			       		</div>
			       		<input class="span2" type="hidden" name="fechaDeInscripcion" id="hdnFecIns"> -->
			       		<div class="form-group">
			          		<label>Nombre del Padre: </label>
			          		<input class="form-control" type="text" name="nombrePadre">
			       		</div>
			       		<div class="form-group">
			          		<label>Nombre de la Madre: </label>
			          		<input class="form-control" type="text" name="nombreMadre">
			       		</div>
			       		<!-- <div class="form-group">
			          		<label>Fecha de Emisión: </label>
			          		<div id="sandbox-container">
				          		<div class="input-group date">
			          				<input class="form-control" type="text" name="txtEmision" id="txtEmision">
			          				<span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
			          			</div>
		          			</div>
			       		</div>
			       		<input class="span2" type="hidden" name="fechaDeEmision" id="hdnFecEmi"> -->
			       		<div class="form-group">
			          		<label>Restricción: </label>
			          		<input class="form-control" type="text" name="restriccion">
			       		</div>
			       		<div class="form-group">
			          		<label>Domicilio: </label>
			          		<input class="form-control" type="text" name="domicilio">
			       		</div>
			       		<div class="form-group">
			          		<label>Departamento de Domicilio: </label>
			          		<select class="form-control" name="departamentoDeDomicilio">
			          			<jsp:include page="../componentes/selectDepartamento.jsp" />
			          		</select>
			       		</div>
			       		<div class="form-group">
			          		<label>Provincia de Domicilio: </label>
			          		<select class="form-control" name="provinciaDeDomicilio">
			          			<jsp:include page="../componentes/selectProvincia.jsp" />
			          		</select>
			       		</div>
			       		<div class="form-group">
			          		<label>Distrito de Domicilio: </label>
			          		<select class="form-control" name="distritoDeDomicilio">
			          			<jsp:include page="../componentes/selectDistrito.jsp" />
			          		</select>
			       		</div>
			       		<!-- <div class="form-group">
			          		<label>Multas Electorales: </label>
			          		<input class="form-control" type="text" name="multasElectoraleso">
			       		</div> -->
			       		<div class="form-group">
			          		<label>Grado de Instrucción: </label>
		          			<select class="form-control" name="gradoDeInstruccion">
		          				<option value="">No Precisa</option>
		          				<option>Preescolar</option>
		          				<option>Primaria</option>
		          				<option>Secundaria</option>
		          				<option>Superior</option>
				            </select>
			       		</div>
			       		<div class="form-group">
			          		<label>Estado Civil: </label>
		          			<select class="form-control" name="estadoCivil" id="sltcEstadoCivil">
		          				<option value="">No Precisa</option>
		          				<option>Casado</option>
		          				<option>Divorciado</option>
		          				<option>Soltero</option>
		          				<option>Viudo</option>
				            </select>
			       		</div>
					</div>		
					<hr class="col-lg-12">			
		       		<div class="well col-lg-12">		       		
		       			<button class="btn btn-outline btn-success" id="btnGuardar" type="submit"><i class="fa fa-check"></i> Guardar Investigado</button>
		        		<button class="btn btn-outline btn-danger" type="reset"><i class="fa fa-refresh fa-fw"></i> Reset</button>
		       		</div>
				</form:form>				
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>