<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.controls{
	margin-top: 3px;
}
</style>
<script>
$(document).ready(function(){
	var idPerfil = '${pageContext.session.getAttribute("idPerfil")}';
		$.ajax({
	 		url: 'getPerfil-'+idPerfil,
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(perfil){
	 			$("#spnPrimerNombe").empty();
	 			$("#spnSegundoNombe").empty();
	 			$("#hdrPrimerNombe").empty();
	 			$("#hdrSegundoNombe").empty();
	 			$("#hdrApePaterno").empty();
	 			$("#hdrApeMaterno").empty();
	 			$("#spnApePaterno").empty();
	 			$("#spnApeMaterno").empty();
	 			$("#spnDni").empty();
	 			$("#hrdDni").empty();
	 			$("#spnTelefono").empty();
	 			$("#hdrTelefono").empty();
	 			$("#spnCorreo").empty();
	 			$("#hdrCorreo").empty();
	 			$("#spnFecNac").empty();
	 			$("#spnSexo").empty();
	 			$("#spnEntidad").empty();
	 			$("#spnCargo").empty();
	 			$("#hdrCargo").empty();
	 			$("#spnNCarnet").empty();
	 				
	 			$("#spnPrimerNombe").text(perfil.primerNombre);
	 			$("#spnSegundoNombe").text(perfil.segundoNombre);
	 			$("#hdrPrimerNombe").text(perfil.primerNombre);
	 			$("#hdrSegundoNombe").text(perfil.segundoNombre);
	 			$("#hdrApePaterno").text(perfil.apePaterno);
	 			$("#hdrApeMaterno").text(perfil.apeMaterno);
	 			$("#spnApePaterno").text(perfil.apePaterno);
	 			$("#spnApeMaterno").text(perfil.apeMaterno);
	 			$("#spnDni").text(perfil.dni);
	 			$("#hdrDni").text(perfil.dni);
	 			$("#spnTelefono").text(perfil.telefono);
	 			$("#spnCorreo").text(perfil.email);
	 			$("#hdrCorreo").text(perfil.email);
	 			$("#spnFecNac").text(perfil.fecNacimiento);
	 			if(perfil.sexo == 'M'){
	 				$("#spnSexo").text('Masculino');
	 			}else{
	 				$("#spnSexo").text('Femenino');
	 			}
	 			if(perfil.entidadPerteneciente == 'D'){
	 				$("#spnEntidad").text("DIRANDRO");
	 			}else if(perfil.entidadPerteneciente == 'M'){
	 				$("#spnEntidad").text("Ministerio P�blico");
	 			}
	 			$("#spnCargo").text(perfil.Cargo);
	 			$("#hdrCargo").text(perfil.Cargo);
	 			$("#spnNCarnet").text(perfil.numeroDeCarnet);
	 		}
	 	});
});
</script>
<div id="divMostrarDatos">
	<form:form class="form-horizontal">
	   	<fieldset>
	       	<legend><span class="span3"><span class="colored">///</span> Datos Personales:</span><span class="span2 offset3"><button class="btn btn-primary btn-small" type="button" ><i class="icon-edit"></i> Editar</button></span></legend>
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
	          		<label class="control-label">Cargo: </label>
	          		<div class="controls">
	          			<span id="spnCargo">&nbsp;</span>
	          		</div>
	       		</div> 
	       		<div class="control-group">
	          		<label class="control-label">Grado: </label>
	          		<div class="controls">
	          			<span id="spnGrado">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Numero de Carnet: </label>
	          		<div class="controls">
	          			CIP N�<span id="spnNCarnet">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Telefono: </label>
	          		<div class="controls">
	          			<span id="spnTelefono">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Corre Electr�nico: </label>
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
	       		<div class="control-group">
	          		<label class="control-label">Entidad: </label>
	          		<div class="controls">
	          			<span id="spnEntidad">&nbsp;</span>
	          		</div>
	       		</div>         
		</fieldset>
	</form:form>
</div>