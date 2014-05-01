<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="divMostrarDatosSospechoso">
	<form:form class="form-horizontal">
	   	<fieldset class="well">
	       	<legend><span class="span3"><span class="colored">///</span> Datos Personales del Sospechoso:</span><span class="span2 offset3"><button class="btn btn-primary btn-small" type="button" ><i class="icon-edit"></i> Editar</button></span></legend>
	       		<div class="control-group">
	          		<label class="control-label">Nombres: </label>
	          		<div class="controls">
	          			<span id="spnPrimerNombe">&nbsp;</span>&nbsp;<span id="spnSegundoNombe">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Apellidos: </label>
	          		<div class="controls">
	          			<span id="spnApePaterno">&nbsp;</span>&nbsp;<span id="spnApeMaterno">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">DNI: </label>
	          		<div class="controls">
	          			<span id="spnDni">&nbsp;</span>
	          		</div>
	       		</div>	       		
	       		<div class="control-group">
	          		<label class="control-label">Entidad: </label>
	          		<div class="controls">
	          			<span id="spnEntidad">&nbsp;</span>
	          		</div>
	       		</div> 
	       		<div class="control-group" id="divRango">
	          		<label class="control-label">Rango: </label>
	          		<div class="controls">
	          			<span id="spnRango">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group" id="divCargo">
	          		<label class="control-label">Cargo: </label>
	          		<div class="controls">
	          			<span id="spnCargo">&nbsp;</span>
	          		</div>
	       		</div> 
	       		<div class="control-group" id="divGrado">
	          		<label class="control-label">Grado: </label>
	          		<div class="controls">
	          			<span id="spnGrado">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group" id="divCarnet">
	          		<label class="control-label">Numero de Carnet: </label>
	          		<div class="controls">
	          			CIP N°<span id="spnNCarnet">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group" id="divFiscal" style="display: none;">
	          		<label class="control-label">Tipo Fiscal: </label>
	          		<label class="controls">
	          			<span id="spnTipoFiscal">&nbsp;</span>
	          		</label>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Telefono: </label>
	          		<div class="controls">
	          			<span id="spnTelefono">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Corre Electrónico: </label>
	          		<div class="controls">
	          			<span id="spnCorreo">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Sexo: </label>
	          		<div class="controls">
	          			<span id="spnSexo">&nbsp;</span>
	          		</div>
	       		</div>        
		</fieldset>
	</form:form>
</div>