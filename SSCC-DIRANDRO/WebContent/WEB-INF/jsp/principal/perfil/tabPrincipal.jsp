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

	var idPerfil;
	if($("#hdnIdPerfil").text() != ""){
		idPerfil = $("#hdnIdPerfil").text();
	}else{
		idPerfil = '${pageContext.session.getAttribute("idPerfil")}';
	}
	
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
	 			$("#spnGrado").empty();
	 			$("#spnRango").empty();
	 				
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
	 			$("#spnCorreo").text(perfil.correoElectronico);
	 			$("#hdrCorreo").text(perfil.correoElectronico);
	 			$("#spnFecNac").text(perfil.fecNacimiento);
	 			if(perfil.sexo == 'M'){
	 				$("#spnSexo").text('Masculino');
	 			}else{
	 				$("#spnSexo").text('Femenino');
	 			}
	 			if(perfil.entidadPerteneciente == 'D'){
	 				$("#spnEntidad").text("DIRANDRO");
		 			$("#spnCargo").text(perfil.cargo);
		 			$("#hdrCargo").text(perfil.cargo);
	 			}else if(perfil.entidadPerteneciente == 'M'){
	 				$("#spnEntidad").text("Ministerio Público");
	 				
	 				$("#divCargo").hide();
	 				$("#divGrado").hide();
	 				$("#divCarnet").hide();
	 				$("#divRango").hide();
	 				$("#tdCargo").empty();
	 				$("#tdCargo").append("Tipo Fiscal");
	 				
	 				$("#divFiscal").show();
	 				$("#hdrCargo").text(perfil.tipoFiscal);
	 				$("#spnTipoFiscal").text(perfil.tipoFiscal);
	 			}
	 			$("#spnNCarnet").text(perfil.numeroDeCarnet);
	 			$("#spnGrado").text(perfil.grado);
	 			$("#spnRango").text(perfil.rango);
	 		}
	 	});
});//# carnet -> sub 8 -> oficiales 6
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
