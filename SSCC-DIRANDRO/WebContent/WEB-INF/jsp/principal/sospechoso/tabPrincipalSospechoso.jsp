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

	var idSospechoso;
	if($("#hdnIdSospechoso").text() != ""){
		idSospechoso = $("#hdnIdSospechoso").text();
	}else{
		idSospechoso = '${pageContext.session.getAttribute("idSospechoso")}';
	}
	
		$.ajax({
	 		url: 'getSopechoso-'+idSospechoso,
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(sospechoso){
	 			$("#spnCodigoUnicoDeIdentificacion").empty();
	 			$("#hdrCodigoUnicoDeIdentificacion").empty();
	 			
	 			$("#spnPrimerApellido").empty();
	 			$("#hdrPrimerApelllido").empty();
	 			
	 			$("#spnSegundoApellido").empty();
	 			$("#hdrSegundoApellido").empty();
	 			
	 			$("#spnPrenombres").empty();
	 			$("#hdrPrenombres").empty();
	 			
	 			$("#spnSexo").empty();
	 			$("#hdrSexo").empty();
	 			
	 			$("#spnFecNac").empty();
	 			$("#hdrFecNac").empty();
	 			///////////////////////////////////////////
	 			$("#spnCodigoUnicoDeIdentificacion").text(sospechoso.codigoUnicoDeIdentificacion);
	 			$("#hdrCodigoUnicoDeIdentificacion").text(sospechoso.codigoUnicoDeIdentificacion);
	 			
	 			$("#spnPrimerApellido").text(sospechoso.primerApellido);
	 			$("#hdrPrimerApellido").text(sospechoso.primerApellido);
	 			
	 			$("#spnSegundoApellido").text(sospechoso.segundoApellido);
	 			$("#hdrSegundoApellido").text(sospechoso.segundoApellido);
	 			
	 			$("#spnPrenombres").text(sospechoso.preNombres);
	 			$("#hdrPrenombres").text(sospechoso.preNombres);
	 			
	 			$("#spnSexo").text(sospechoso.sexo);
	 			$("#hdrSexo").text(sospechoso.sexo);
	 			
	 			$("#spnFecNac").text(sospechoso.fechaDeNacimiento);
	 			$("#hdrFecNac").text(sospechoso.fechaDeNacimiento);
	 			
	 			if(perfil.sexo == 'M'){
	 				$("#spnSexo").text('Masculino');
	 			}else{
	 				$("#spnSexo").text('Femenino');
	 			}
	 		}
	 	});
});
</script>
<div id="divMostrarDatosSospechoso">
	<form:form class="form-horizontal">
	   	<fieldset class="well">
	       	<legend><span class="span3"><span class="colored">///</span> Datos del Sospechoso:</span><span class="span2 offset3"><button class="btn btn-primary btn-small" type="button" ><i class="icon-edit"></i> Editar</button></span></legend>
	       		<div class="control-group">
	          		<label class="control-label">C.U.I: </label>
	          		<div class="controls">
	          			<span id="spnCodigoUnicoDeIdentificacion">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Primer Apellido: </label>
	          		<div class="controls">
	          			<span id="spnPrimerApellido">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Segundo Apellido: </label>
	          		<div class="controls">
	          			<span id="spnSegundoApellido">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Prenombres: </label>
	          		<div class="controls">
	          			<span id="spnPrenombres">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Sexo: </label>
	          		<div class="controls">
	          			<span id="spnSexo">&nbsp;</span>
	          		</div>
	       		</div> 
	       		<div class="control-group">
	          		<label class="control-label">Fecha de Nacimiento: </label>
	          		<div class="controls">
	          			<span id="spnFecNac">&nbsp;</span>
	          		</div>
	       		</div>       
		</fieldset>
	</form:form>
</div>