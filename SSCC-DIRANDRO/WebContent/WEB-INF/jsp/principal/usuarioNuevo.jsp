<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Crear Usuario</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- styles -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
<link href="css/plugins/timeline.css" rel="stylesheet">
<link href="css/sb-admin-2.css" rel="stylesheet">
<link href="css/plugins/morris.css" rel="stylesheet">
<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- js -->
<script src="js/jquery-1.11.0.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/plugins/metisMenu/metisMenu.min.js"></script>
<script src="js/sb-admin-2.js"></script>
<script src="js/jquery.validate.min.js"></script>

<script>
$(document).on('click','#rangoOficial', function(e){
	$("#sltcGrado").empty();
	$("#sltcGrado").append('<option>Alfz. PNP</option><option>Tnte. PNP</option><option>Cap. PNP</option>'+
			'<option>May. PNP</option><option>Cmdte PNP</option><option>Crnel PNP</option><option>Gral. PNP</option>');
});

$(document).on('click','#rangoSubOficial', function(e){
	$("#sltcGrado").empty();
	$("#sltcGrado").append('<option>SO3 PNP</option><option>SO2 PNP</option><option>SO1 PNP</option>'+
	'<option>SOT3 PNP</option><option>SOT2 PNP</option><option>SOT1 PNP</option><option>SOB PNP</option><option>SOS PNP</option>');
});

$(document).on('click','#radioD', function(e){
	$("#divCargo").show();
	$("#divRango").show();
	$("#divGrado").show();
	$("#divNCarnet").show();
	$("#hrCargo").show();
	$("#hrRango").show();
	$("#hrGrado").show();
	$("#hrNCarnet").show();
	$("#divFiscal").hide();
	$("#hrFiscal").hide();
	
	$("#rangoOficial").prop("checked", true);
	$("#chkFiscal").prop("checked", false);
	$("#chkFiscalSup").prop("checked", false);
	$("#sltcGrado").empty();
	$("#sltcGrado").append('<option>Alfz. PNP</option><option>Tnte. PNP</option><option>Cap. PNP</option>'+
			'<option>May. PNP</option><option>Cmdte PNP</option><option>Crnel PNP</option><option>Gral. PNP</option>');
});

$(document).on('click','#radioM', function(e){
	$("#divCargo").hide();
	$("#divRango").hide();
	$("#divGrado").hide();
	$("#divNCarnet").hide();
	$("#hrCargo").hide();
	$("#hrRango").hide();
	$("#hrGrado").hide();
	$("#hrNCarnet").hide();
	$("#divFiscal").show();
	$("#hrFiscal").show();
	
	$("#rangoOficial").prop("checked", false);
	$("#rangoSubOficial").prop("checked", false);
	$("#chkFiscal").prop("checked", true);
});

/*$(document).on('click','#btnGuardar', function(e){
	$("#formCrearUsuario").submit();
});*/
var flag = true;
var flag2 = true;
var flag3 = true;
$(document).ready(function() {
	$("#chkFiscal").prop("checked", false);
	$("#chkFiscalSup").prop("checked", false);
	
	$("#formCrearUsuario").validate({
		rules:{
			txtNumeroDeCarnet:  {required: true, number: true, minlength: 6, maxlength: 8},
			txtCorreo: {required: true, email:true},
			txtDni: {required: true, number: true, minlength: 8, maxlength: 8}
		},
		messages:{
			txtNumeroDeCarnet : "Solo Números, con 8 digitos",
			txtCorreo : "Debe ser un Correo Electronico",
			txtDni : "Solo Números"
		},
		submitHandler: function(form){
			
			$("#hdnNumeroDeCarnet").val($("#txtNumeroDeCarnet").val());
			$("#hdnCorreo").val($("#txtCorreo").val());
			$("#hdnDni").val($("#txtDni").val());
			
			//form.submit();
			if(flag == true && flag2 == true && flag3 == true){
				form.submit();
			}else if($("#txtDni").val() == '' || $("#txtNumeroDeCarnet").val() == '' || $("#txtCorreo").val() == ''){
				form.submit();
			}else{
				alert("Debe Corregir los datos");
			}
		}
	});
});
$(document).on('change','#txtDni', function(e){
	$.ajax({
		url: 'getDni-'+$('#txtDni').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(perfil){
			if(perfil == true){
				$("#alertasDniNuevo").show();
				$("#alertasDniNuevo").empty();
				$("#alertasDniNuevo").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">×</a>'+
	 			        '<strong id="msgVerde">El D.N.I usado ya existe.</strong>'+
	 			    '</div>');
				flag = false;
			}else{
				flag = true;
			}
		}
	});
});
$(document).on('change','#txtNumeroDeCarnet', function(e){
	$.ajax({
		url: 'getNumeroCarnet-'+$('#txtNumeroDeCarnet').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(perfil){
			if(perfil == true){
				$("#alertasCarnetNuevo").show();
				$("#alertasCarnetNuevo").empty();
				$("#alertasCarnetNuevo").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">×</a>'+
	 			        '<strong id="msgVerde">Número de Carnet usado ya existe.</strong>'+
	 			    '</div>');
				flag = false;
			}else{
				flag = true;
			}
		}
	});
});
$(document).on('change','#txtCorreo', function(e){
	$.ajax({
		url: 'getCorreo-'+$('#txtCorreo').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(usuario){
			if(usuario == true){
				$("#alertasCorreoNuevo").show();
				$("#alertasCorreoNuevo").empty();
				$("#alertasCorreoNuevo").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">×</a>'+
	 			        '<strong id="msgVerde">Correo usado ya existe.</strong>'+
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
<div id="wrapper">

	<!--HEADER-->
	<jsp:include page="../componentes/newHeader.jsp" />
	<!--/HEADER-->
	<!--CENTRO-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
				<div class="col-lg-12" id="titulo">
					<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
				</div>
				<div id="alertasDniNuevo" style="display: none;">
				</div>
				<div id="alertasCarnetNuevo" style="display: none;">
				</div>
				<div id="alertasCorreoNuevo" style="display: none;">
				</div>			
			<div class="panel panel-default col-md-6 col-md-offset-1">
				<div class="panel-heading">
					Datos Personales:
				</div>			
				<div class="panel-body">
					<form:form class="form-horizontal" id="formCrearUsuario" action="crearUsuario" commandName="perfil">
						<div class="form-group">
							<label>Primer Nombre: </label>
							<input type="text" name="primerNombre" data-rule-required="true" data-msg-required="*" class="form-control">
						</div>
						<div class="form-group">
							<label>Segundo Nombre: </label>
							<input type="text" name="segundoNombre" class="form-control">
						</div>
						<div class="form-group">
							<label>Apellido Paterno: </label>
							<input type="text" name="apePaterno" data-rule-required="true" data-msg-required="*" class="form-control">
						</div>
						<div class="form-group">
							<label>Apellidos Materno: </label>
							<input type="text" name="apeMaterno" data-rule-required="true" data-msg-required="*" class="form-control">
						</div>
						<div class="form-group">
							<label>DNI: </label>
							<input type="text" name="txtDni" id="txtDni"  class="form-control">
							<input class="span2" type="hidden" name="dni" id="hdnDni">
						</div>
						<div class="form-group">
							<label>Entidad: </label> 
							<label class="radio-inline"> 
								<input type="radio" name="entidadPerteneciente" id="radioD" value="D" checked>DIRANDRO
							</label>
							<label class="radio-inline">
								<input type="radio" name="entidadPerteneciente" id="radioM" value="M">Ministerio Público
							</label>
						</div>
						<div class="form-group" id="divFiscal" style="display: none;">
							<label>Tipo Fiscal: </label> 
							<label class="radio-inline"> 
								<input type="radio" name="tipoFiscal" id="chkFiscal" value="Fiscal" checked>Fiscal
							</label> 
							<label class="radio-inline"> 
								<input type="radio" name="tipoFiscal" id="chkFiscalSup" value="Fiscal Superior">Fiscal Superior
							</label>
						</div>
						<div class="form-group" id="divCargo">
							<label>Cargo: </label>
							<select name="cargo" data-rule-required="true" data-msg-required="*" class="form-control">
								<option>Jefe de Unidad</option>
								<option>Superior</option>
								<option>Investigador</option>
							</select>
						</div>
						<div class="form-group" id="divRango">
							<label>Jerarquía: </label> 
							<label class="radio-inline">  
								<input type="radio" name="rango" id="rangoOficial" value="Oficial" checked>Oficial
							</label> 
							<label class="radio-inline">  
								<input type="radio" name="rango" id="rangoSubOficial" value="Sub Oficial">Sub Oficial
							</label>
						</div>
						<div class="form-group" id="divGrado">
							<label>Grado: </label>
							<select name="grado" id="sltcGrado" data-rule-required="true" data-msg-required="*" class="form-control">
								<option>Alfz. PNP</option>
								<option>Tnte. PNP</option>
								<option>Cap. PNP</option>
								<option>May. PNP</option>
								<option>Cmdte PNP</option>
								<option>Crnel PNP</option>
								<option>Gral. PNP</option>
							</select>
						</div>
						<div class="form-group" id="divNCarnet">
							<label>Numero de Carnet: </label>
							<div class="form-group input-group">
								<span class="input-group-addon">CIP N°</span>
								<input class="form-control" type="text" id="txtNumeroDeCarnet" name="txtNumeroDeCarnet"> 							
							</div>
							<input type="hidden" name="numeroDeCarnet" id="hdnNumeroDeCarnet">
						</div>
						<div class="form-group">
							<label>Telefono: </label>
							<input type="text" name="telefono" class="form-control">
						</div>
						<div class="form-group">
							<label>Corre Electrónico: </label>
							<div class="form-group input-group">
								<span class="input-group-addon">@</span>
								<input class="form-control" type="text" id="txtCorreo" name="txtCorreo"> 							
							</div>
							<input class="form-control" type="hidden" id="hdnCorreo" name="correo">
						</div>
						<div class="form-group">
							<label>Sexo: </label> 
							<label class="radio-inline"> 
								<input type="radio" name="sexo" id="" value="M" checked>Masculino
							</label> 
							<label class="radio-inline"> 
								<input type="radio" name="sexo" id="" value="F">Femenino
							</label>
						</div>
						<hr>
						<div class="well">
							<button class="btn btn-outline btn-success" id="btnGuardar" type="submit"><i class="fa fa-check"></i> Guardar Usuario </button>
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