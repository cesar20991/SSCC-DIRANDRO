<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="divMostrarDatos">
	<form:form class="form-horizontal">
		<fieldset>
			<legend>
				<span class="span3"><span class="colored">///</span> Datos Principales del Caso Criminal:</span>
				<span class="span2 offset3"><button class="btn btn-primary btn-small" type="button"><i class="icon-edit"></i> Editar</button></span>
			</legend>
			<div class="control-group">
				<label class="control-label">Codigo: </label>
				<div class="controls">
					<span id="spnPrimerNombe">&nbsp;</span>&nbsp;<span id="spnSegundoNombe">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Estado: </label>
				<div class="controls">
					<span id="spnApePaterno">&nbsp;</span>&nbsp;<span id="spnApeMaterno">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Fecha de Creacion: </label>
				<div class="controls">
					<span id="spnDni">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Referencia: </label>
				<div class="controls">
					<span id="spnEntidad">&nbsp;</span>
				</div>
			</div>
			<div class="control-group" id="divRango">
				<label class="control-label">Asunto: </label>
				<div class="controls">
					<span id="spnRango">&nbsp;</span>
				</div>
			</div>
			<div class="control-group" id="divRango">
				<label class="control-label">Description: </label>
				<div class="controls">
					<span id="spnRango">&nbsp;</span>
				</div>
			</div>
		</fieldset>
	</form:form>
</div>