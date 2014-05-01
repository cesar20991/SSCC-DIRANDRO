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
			<form:form class="form-horizontal" id="formCrearUsuario" action="crearUsuario" commandName="perfil">
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
		          			<input class="span2" type="text" name="segundoApellido">
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
		          		<div class="controls">
		          			<input class="span2" type="text" name="sexo" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Fecha de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="fechaDeNacimiento" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="departamentoDeNacimiento" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="provinciaDeNacimiento" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="distritoDeNacimiento" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Grado de Instrucción: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="gradoDeInstruccion" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Estado Civil: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="estadoCivil" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		
		       		<div class="control-group">
		          		<label class="control-label">DNI: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtDni" id="txtDni">
		          			<input class="span2" type="hidden" name="dni" id="hdnDni">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Entidad: </label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="entidadPerteneciente" id="radioD" value="D" checked>DIRANDRO
		          		</label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="entidadPerteneciente" id="radioM" value="M">Ministerio Público
		          		</label>
		       		</div>
		       		<hr>
		       		<div class="control-group" id="divFiscal" style="display: none;">
		          		<label class="control-label">Tipo Fiscal: </label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="tipoFiscal" id="chkFiscal" value="Fiscal" checked>Fiscal
		          		</label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="tipoFiscal" id="chkFiscalSup" value="Fiscal Superior">Fiscal Superior
		          		</label>
		       		</div>
		       		<hr id="hrFiscal" style="display: none;">
		       		<div class="control-group" id="divCargo">
		          		<label class="control-label">Cargo: </label>
		          		<div class="controls">
		          			<select class="span2" name="cargo" data-rule-required="true" data-msg-required="*">
		          				<option>Jefe de Unidad</option>
		          				<option>Superior</option>
		          				<option>Investigador</option>
				            </select>
		          		</div>
		       		</div>
		       		<hr id="hrCargo">
		       		<div class="control-group" id="divRango">
		          		<label class="control-label">Rango: </label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="rango" id="rangoOficial" value="Oficial" checked>Oficial
		          		</label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="rango" id="rangoSubOficial" value="Sub Oficial">Sub Oficial
		          		</label>
		       		</div>
		       		<hr id="hrRango"> 
		       		<div class="control-group" id="divGrado">
		          		<label class="control-label">Grado: </label>
		          		<div class="controls">
		          			<select class="span2" name="grado" id="sltcGrado" data-rule-required="true" data-msg-required="*">
		          				<option>Alfz. PNP</option>
		          				<option>Tnte. PNP</option>
		          				<option>Cap. PNP</option>
								<option>May. PNP</option>
								<option>Cmdte PNP</option>
								<option>Crnel PNP</option>
								<option>Gral. PNP</option>
				            </select>
		          		</div>
		       		</div>
		       		<hr id="hrGrado">
		       		<div class="control-group" id="divNCarnet">
		          		<label class="control-label">Numero de Carnet: </label>
		          		<div class="input-prepend" style="margin-left: 20px;">
		          			<span class="add-on">CIP N°</span><input class="input-small" type="text" id="txtNumeroDeCarnet" name="txtNumeroDeCarnet" style="width: 110px;">
		          			<input class="input-small" type="hidden" name="numeroDeCarnet" id="hdnNumeroDeCarnet" style="width: 110px;">
		          		</div>
		       		</div>
		       		<hr id="hrNCarnet">
		       		<div class="control-group">
		          		<label class="control-label">Telefono: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="telefono">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Corre Electrónico: </label>
		          		<div class="input-prepend" style="margin-left: 20px;">
		          			<span class="add-on">@</span><input class="input-medium" type="text" id="txtCorreo" name="txtCorreo" style="width: 135px;">
		          			<input class="input-medium" type="hidden" id="hdnCorreo" name="correo">
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
		       		<div class="form-actions">
			        	<button class="btn btn-success" id="btnGuardar" type="submit"><i class="icon-ok icon-white"></i> Guardar Usuario</button>
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