<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Crear Sospechoso</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- para que funcione el jquery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<!-- para que funcione el jquery de la plantilla -->
<script src="js/jquery.js"></script>
<!-- para el menu -->
<script src="js/bootstrap-collapse.js"></script>
<script src="js/jquery.validate.min.js"></script>
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
	$("#formCrearSospechoso").validate({
		rules:{
			txtFecNac: {date: true},
			txtEstatura: {number: true},
			txtInscripcion: {date: true},
			txtEmision: {date: true},
		},
		messages:{
			txtFecNac: "Debe tener formato de fecha dd/mm/aaaa",
			txtEstatura: "Solo números",
			txtInscripcion: "Debe tener formato de fecha dd/mm/aaaa",
			txtEmision: "Debe tener formato de fecha dd/mm/aaaa",
		},
		submitHandler: function(form){
			//Se usa 1000-12-12 para que pase de la vista al controlador
			//y en el implements se seteara como null.
			if($("#hdnFecNac").val() == ''){
				$("#hdnFecNac").val('1000-12-12');
			}else{
				$("#hdnFecNac").val($("#txtFecNac").val());
			}
			
			if($("#hdnFecIns").val() == ''){
				$("#hdnFecIns").val('1000-12-12');
			}else{
				$("#hdnFecIns").val($("#txtInscripcion").val());
			}
			
			$("#hdnEstatura").val($("#txtEstatura").val());
			
			if($("#hdnFecEmi").val() == ''){
				$("#hdnFecEmi").val('1000-12-12');
			}else{
				$("#hdnFecEmi").val($("#txtEmision").val());
			}
			//$("#hdnFecEmi").val($("#txtEmision").val());
			
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
			<form:form class="form-horizontal" id="formCrearSospechoso" action="crearSospechoso" commandName="sospechoso">
		       	<legend><span class="colored">///</span> Datos Personales del Sospechoso:</legend>
		       		<div class="control-group">
		          		<label class="control-label">Código Único de Identificación: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="codigoUnicoDeIdentificacion" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Primer Apellido: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="primerApellido" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Segundo Apellido: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="segundoApellido" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Prenombres: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="preNombres" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Sexo: </label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="sexo" id="" value="M" checked>Masculino
		          		</label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="sexo" id="" value="F">Femenino
		          		</label>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Fecha de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtFecNac" id="txtFecNac">
		          			<input class="span2" type="hidden" name="fechaDeNacimiento" id="hdnFecNac">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="departamentoDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="provinciaDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="distritoDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Grado de Instrucción: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="gradoDeInstruccion">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group" id="divGrado">
		          		<label class="control-label">Estado Civil: </label>
		          		<div class="controls">
		          			<select class="span2" name="estadoCivil" id="sltcEstadoCivil">
		          				<option> </option>
		          				<option>Casado</option>
		          				<option>Divorciado</option>
		          				<option>Soltero</option>
		          				<option>Viudo</option>
				            </select>
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Estatura: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtEstatura" id="txtEstatura">
		          			<input class="span2" type="hidden" name="estatura" id="hdnEstatura">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Fecha de Inscripción: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtInscripcion" id="txtInscripcion">
		          			<input class="span2" type="hidden" name="fechaDeInscripcion" id="hdnFecIns">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Nombre del Padre: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="nombrePadre">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Nombre de la Madre: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="nombreMadre">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Fecha de Emisión: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtEmision" id="txtEmision">
		          			<input class="span2" type="hidden" name="fechaDeEmision" id="hdnFecEmi">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Restricción: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="restriccion">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="domicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="departamentoDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="provinciaDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="distritoDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Multas Electorales: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="multasElectoraleso">
		          		</div>
		       		</div>
		       		<div class="form-actions">
			        	<button class="btn btn-success" id="btnGuardar" type="submit"><i class="icon-ok icon-white"></i> Guardar Sospechoso</button>
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