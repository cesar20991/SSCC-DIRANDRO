<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.controls{
	margin-top: 3px;
}
</style>
<script>
var totalCorreos = 0;
var totalTelefonos = 0;
var totalCelulares = 0;
var totalDirecciones = 0;

function initDatosContacto(sospechoso){
	$("#spnCorreos").empty();
	$("#spnTelefonos").empty();
	$("#spnCelulares").empty();
	$("#spnDirecciones").empty();
	
	$("#spnCorreos").append(sospechoso.correos);
	$("#spnTelefonos").append(sospechoso.telefonos);
	$("#spnCelulares").append(sospechoso.celulares);
	$("#spnDirecciones").append(sospechoso.direcciones);
	
	if($("#spnCorreos").text() == ''){
		totalCorreos = 0;
	}else{
		totalCorreos = ((sospechoso.correos).split(", ").length);
	}
	
	if($("#spnTelefonos").text() == ''){
		totalTelefonos = 0;
	}else{
		totalTelefonos = (sospechoso.telefonos).split(", ").length;
	}
	
	if($("#spnCelulares").text() == ''){
		totalCelulares = 0;
	}else{
		totalCelulares = (sospechoso.celulares).split(", ").length;
	}
	
	if($("#spnDirecciones").text() == ''){
		totalDirecciones = 0;
	}else{
		totalDirecciones = (sospechoso.direcciones).split(", ").length;	
	}
}

$(document).ready(function(){

	$("#formEditarContacto").validate({
		submitHandler: function(form){
			$("#hdnIdSospechosoDatos").val($("#hdnIdSospechoso").text());
			$.ajax({
				url: 'editarDatosContacto',
		 		type: 'post',
		 		dataType: 'json',
		 		data: $("#formEditarContacto").serialize(),
		 		success: function(sospechoso){
		 			initDatosContacto(sospechoso);
		 			$("#divMostrarContacto").show();
		 			$("#divEditarContacto").hide();

		 			$('#txtTelefonos_0').val("");
		 			$('#txtCorreo_0').val("");
		 			$('#txtCelulares_0').val("");
		 			$('#txtDirecciones_0').val("");
		 		}
			});
		}
	});
});
$(document).on('click','#btnEditarContacto', function(e){
	//TABS A OCULTAR Y MOSTRAR
	var correo = $("#spnCorreos").text().split(", ");
	if((totalCorreos+1) >= 2){
		$("#camposCorreo").empty();
		$("#txtCorreo_0").val(correo[0]);
		for(var numCorreos = 1; numCorreos < totalCorreos; numCorreos++){
			$("#camposCorreo").append('<div class="control-group" id="campoCorreo_'+numCorreos+'">'+
				      		'<label class="control-label">Correo Electrónico: </label>'+
				      		'<div class="controls">'+
				      			'<input class="span2" type="text" name="txtCorreo" value="'+correo[numCorreos]+'" id="txtCorreo_'+numCorreos+'" data-rule-email="true" data-msg-email="Debe ingresar un correo electronico válido."> <button class="btn btn-danger eliminarCamposCorreo" id="btnEliminarCampos_'+num+'" type="button"><i class="icon-minus icon-white"></i></button>'+
				      		'</div>'+
				   		'</div>');
		}
	}
	
	var tel = $("#spnTelefonos").text().split(", ");
	if(totalTelefonos >= 2){
		$("#camposTelefonos").empty();
		$("#txtTelefonos_0").val(tel[0]);
		for(var numTelefonos = 1; numTelefonos < totalTelefonos; numTelefonos++){
			$("#camposTelefonos").append('<div class="control-group" id="campoTelefono_'+numTelefonos+'">'+
		      		'<label class="control-label">Teléfonos: </label>'+
		      		'<div class="controls">'+
		      			'<input class="span2" type="text" name="txtTelefonos" value="'+tel[numTelefonos]+'" id="txtTelefonos_'+numTelefonos+'" data-rule-number="true" data-rule-minlength="7" data-rule-maxlength="7" data-msg-number="Debe ingresar un número de teléfono válido."> <button class="btn btn-danger eliminarCamposTelefonos" id="btnEliminarTelefonos_'+x+'" type="button"><i class="icon-minus icon-white"></i></button>'+
		      		'</div>'+
		   		'</div>');
		}
		x = totalTelefonos;
	}
	
	var cel = $("#spnCelulares").text().split(", ");
	if(totalCelulares >= 2){
		$("#camposCelulares").empty();
		$("#txtCelulares_0").val(cel[0]);
		for(var numCelulares = 1; numCelulares < totalCelulares; numCelulares++){
			$("#camposCelulares").append('<div class="control-group" id="campoCelulares_'+numCelulares+'">'+
		      		'<label class="control-label">Celulares: </label>'+
		      		'<div class="controls">'+
		      			'<input class="span2" type="text" name="txtCelulares" value="'+cel[numCelulares]+'" id="txtCelulares_'+numCelulares+'" data-rule-number="true"  data-rule-minlength="9" data-rule-maxlength="9" data-msg-number="Debe ingresar un número de celular válido."> <button class="btn btn-danger eliminarCamposCelulares" id="btnEliminarCelulares_'+y+'" type="button"><i class="icon-minus icon-white"></i></button>'+
		      		'</div>'+
		   		'</div>');
		}
	}
	
	var direc = $("#spnDirecciones").text().split(", ");
	if(totalDirecciones >= 2){
		$("#camposDirecciones").empty();
		$("#txtDirecciones_0").val(direc[0]);
		for(var numDirecciones = 1; numDirecciones < totalDirecciones; numDirecciones++){
			$("#camposDirecciones").append('<div class="control-group" id="campoDirecciones_'+numDirecciones+'">'+
		      		'<label class="control-label">Direcciones: </label>'+
		      		'<div class="controls">'+
		      			'<input class="span2" type="text" name="txtDirecciones" value="'+direc[numDirecciones]+'" id="txtDirecciones_'+numDirecciones+'"> <button class="btn btn-danger eliminarCamposDirecciones" id="btnEliminarDirecciones_'+z+'" type="button"><i class="icon-minus icon-white"></i></button>'+
		      		'</div>'+
		   		'</div>');
		}
	}
	
	$("#divMostrarContacto").hide();
	$("#divEditarContacto").show();
});
$(document).on('click','#btnCancelEditar', function(e){
	//TABS A MOSTRAR Y OCULTAR
	$("#divMostrarContacto").show();
	$("#divEditarContacto").hide();
});
var num=1;
//METODOS PARA GENERAR Y ELIMINAR COMPONENTES
$(document).on('click','#btnGeneraCampos', function(e){
	$("#camposCorreo").append('<div class="control-group" id="campoCorreo_'+num+'">'+
					      		'<label class="control-label">Correo Electrónico: </label>'+
					      		'<div class="controls">'+
					      			'<input class="span2" type="text" name="txtCorreo" id="txtCorreo_'+num+'" data-rule-email="true" data-msg-email="Debe ingresar un correo electronico válido."> <button class="btn btn-danger eliminarCamposCorreo" id="btnEliminarCampos_'+num+'" type="button"><i class="icon-minus icon-white"></i></button>'+
					      		'</div>'+
					   		'</div>');
	num++;
});
$(document).on('click','.eliminarCamposCorreo', function(e){
	var id0 = (this.id).split('_')[0];
	var id1 = (this.id).split('_')[1];
	$("#campoCorreo_"+id1).remove();
});
var x=1;
$(document).on('click','#btnGenerarTelefonos', function(e){
	$("#camposTelefonos").append('<div class="control-group" id="campoTelefono_'+x+'">'+
					      		'<label class="control-label">Teléfonos: </label>'+
					      		'<div class="controls">'+
					      			'<input class="span2" type="text" name="txtTelefonos" id="txtTelefonos_'+x+'" data-rule-number="true" data-rule-minlength="7" data-rule-maxlength="7" data-msg-number="Debe ingresar un número de teléfono válido."> <button class="btn btn-danger eliminarCamposTelefonos" id="btnEliminarTelefonos_'+x+'" type="button"><i class="icon-minus icon-white"></i></button>'+
					      		'</div>'+
					   		'</div>');
	x++;
});
$(document).on('click','.eliminarCamposTelefonos', function(e){
	var id0 = (this.id).split('_')[0];
	var id1 = (this.id).split('_')[1];
	$("#campoTelefono_"+id1).remove();
});
var y=1;
$(document).on('click','#btnGenerarCelulares', function(e){
	$("#camposCelulares").append('<div class="control-group" id="campoCelulares_'+y+'">'+
					      		'<label class="control-label">Celulares: </label>'+
					      		'<div class="controls">'+
					      			'<input class="span2" type="text" name="txtCelulares" id="txtCelulares_'+y+'" data-rule-number="true"  data-rule-minlength="9" data-rule-maxlength="9" data-msg-number="Debe ingresar un número de celular válido."> <button class="btn btn-danger eliminarCamposCelulares" id="btnEliminarCelulares_'+y+'" type="button"><i class="icon-minus icon-white"></i></button>'+
					      		'</div>'+
					   		'</div>');
	y++;
});
$(document).on('click','.eliminarCamposCelulares', function(e){
	var id0 = (this.id).split('_')[0];
	var id1 = (this.id).split('_')[1];
	$("#campoCelulares_"+id1).remove();
});
var z=1;
$(document).on('click','#btnGenerarDirecciones', function(e){
	$("#camposDirecciones").append('<div class="control-group" id="campoDirecciones_'+z+'">'+
					      		'<label class="control-label">Direcciones: </label>'+
					      		'<div class="controls">'+
					      			'<input class="span2" type="text" name="txtDirecciones" id="txtDirecciones_'+z+'"> <button class="btn btn-danger eliminarCamposDirecciones" id="btnEliminarDirecciones_'+z+'" type="button"><i class="icon-minus icon-white"></i></button>'+
					      		'</div>'+
					   		'</div>');
	z++;
});
$(document).on('click','.eliminarCamposDirecciones', function(e){
	var id0 = (this.id).split('_')[0];
	var id1 = (this.id).split('_')[1];
	$("#campoDirecciones_"+id1).remove();
});
</script>
<!-- MOSTRAR DATOS DE CONTACTO -->
<div id="divMostrarDatosContacto">
	<div id="divMostrarContacto">
		<form:form class="form-horizontal">
			<legend>
	       		<span class=""><span class="colored">///</span> Datos de Contacto del Sospechoso:</span>
	       		<span class="offset3"><button class="btn btn-primary" type="button" id="btnEditarContacto"><i class="icon-edit"></i> Editar</button></span>
       		</legend>
       		<div class="control-group">
          		<label class="control-label">Correo Electrónicos: </label>
          		<div class="controls">
          			<span id="spnCorreos">&nbsp;</span>
          		</div>
       		</div>
       		<div class="control-group">
          		<label class="control-label">Teléfonos: </label>
          		<div class="controls">
          			<span id="spnTelefonos">&nbsp;</span>
          		</div>
       		</div>
       		<div class="control-group">
          		<label class="control-label">Celulares: </label>
          		<div class="controls">
          			<span id="spnCelulares">&nbsp;</span>
          		</div>
       		</div>
       		<div class="control-group">
          		<label class="control-label">Direcciones: </label>
          		<div class="controls">
          			<span id="spnDirecciones">&nbsp;</span>
          		</div>
       		</div>
		</form:form>
	</div>
	<!-- EDITAR DATOS DE CONTACTO -->
	<fieldset class="well" style="display: none;" id="divEditarContacto">
		<form:form class="form-horizontal" id="formEditarContacto" action="editarContacto" commandName="sospechoso">
			<input type="hidden" name="idSospechoso" id="hdnIdSospechosoDatos">
			<legend>
		       	<span class="colored">///</span> Datos de Contacto del Sospechoso:
	       	</legend>
	       	<div class="control-group">
          		<label class="control-label">Correo Electrónico: </label>
          		<div class="controls">
          			<input class="span2" type="text" name="txtCorreo" id="txtCorreo_0" data-rule-email="true" data-msg-email="Debe ingresar un correo electronico válido."> <button class="btn btn-success" id="btnGeneraCampos" type="button"><i class="icon-plus icon-white"></i></button>
          		</div>
       		</div>
       		<div id="camposCorreo">
       		</div>
       		<div class="control-group">
          		<label class="control-label">Teléfonos: </label>
          		<div class="controls">
          			<input class="span2" type="text" name="txtTelefonos" id="txtTelefonos_0" data-rule-number="true" data-rule-minlength="7" data-rule-maxlength="7" data-msg-number="Debe ingresar un número de teléfono válido."> <button class="btn btn-success" id="btnGenerarTelefonos" type="button"><i class="icon-plus icon-white"></i></button>
          		</div>
       		</div>
       		<div id="camposTelefonos">
       		</div>
       		<div class="control-group">
          		<label class="control-label">Celulares: </label>
          		<div class="controls">
          			<input class="span2" type="text" name="txtCelulares" id="txtCelulares_0" data-rule-number="true"  data-rule-minlength="9" data-rule-maxlength="9" data-msg-number="Debe ingresar un número de celular válido."> <button class="btn btn-success" id="btnGenerarCelulares" type="button"><i class="icon-plus icon-white"></i></button>
          		</div>
       		</div>
       		<div id="camposCelulares">
       		</div>
       		<div class="control-group">
          		<label class="control-label">Direcciones: </label>
          		<div class="controls">
          			<input class="span2" type="text" name="txtDirecciones" id="txtDirecciones_0"> <button class="btn btn-success" id="btnGenerarDirecciones" type="button"><i class="icon-plus icon-white"></i></button>
          		</div>
       		</div>
       		<div id="camposDirecciones">
       		</div>
			<!-- BOTONES -->
			<div class="form-actions">
				<button class="btn btn-success" id="btnGuardar" type="submit"><i class="icon-ok icon-white"></i> Guardar</button>
		        <button class="btn btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset</button>
		        <button class="btn btn-warning" type="button" id="btnCancelEditar"><i class="icon-arrow-left icon-white"></i> Cancel</button>
		    </div>
		</form:form>
	</fieldset>
</div>