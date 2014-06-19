<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
function initInmueble(inmueble){
	
	// Cabecera	
	$("#hdrCodigo").empty();
	$("#hdrPartida").empty();
	$("#hdrValor").empty();
	$("#hdrCreador").empty();
	$("#hdrAreaTotal").empty();
	$("#hdrDireccion").empty();
	
	$("#hdrAreaTotal").append(inmueble.areaTotal);
	$("#hdrDireccion").append(inmueble.direccion);
	$("#hdrCodigo").append(inmueble.codigo);
	$("#hdrPartida").append(inmueble.partidaRegistral);
	$("#hdrValor").append(inmueble.valor);
	$("#hdrCreador").append('<a href="toPerfil-'+inmueble.idPerfil+'">'+inmueble.primerNombre+ ' ' +inmueble.segundoNombre+ ' ' +inmueble.apePaterno+ ' ' +inmueble.apeMaterno+ '</a>');
	
	// Cuerpo
	$("#spnCodigo").empty();
	$("#spnValor").empty();
	$("#spnPartida").empty();
	$("#spnDescripcion").empty();
	$("#spnAreaTotal").empty();
	$("#spnAreaCercado").empty();
	$("#spnAreaConstruido").empty();
	$("#spnPisos").empty();
	$("#spnAmbientes").empty();
	$("#spnDireccion").empty();
	$("#spnAntiguedad").empty();

	$("#spnCodigo").append(inmueble.codigo);
	$("#spnPartida").append(inmueble.partidaRegistral);
	$("#spnValor").append(inmueble.valor);
	$("#spnDescripcion").append(inmueble.descripcion);
	$("#spnAreaTotal").append(inmueble.areaTotal);
	$("#spnAreaCercado").append(inmueble.areaCercado);
	$("#spnAreaConstruido").append(inmueble.areaConstruido);
	$("#spnPisos").append(inmueble.pisos);
	$("#spnAmbientes").append(inmueble.ambientes);
	$("#spnDireccion").append(inmueble.direccion);
	$("#spnAntiguedad").append(inmueble.antiguedad);
	
}
var flag = false;
$(document).ready(function(){
	var idInmueble = $("#hdnIdInmueble").text();
	$.ajax({
 		url: 'getInmueble-'+idInmueble,
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(inmueble){
 			initInmueble(inmueble);
 		}
 	});
	
	$("#formEditarInmueble").validate({
		rules:{
			partidaRegistral:{required:true, minlength: 8, maxlength: 8},
			valor:{required:true,doubleNumber:true},
			descripcion:{required:true, minlength: 10,maxlength: 250},
			areaTotal:{required:true,doubleNumber:true},
			areaConstruido:{required:true,doubleNumber:true},
			areaCercado:{required:true,doubleNumber:true},
			pisos:{number:true},
			ambientes:{number:true},
			direccion:{required:true, maxlength:100},
			antiguedad:{number:true}
		},
		messages:{
			partidaRegistral:"Complete los 8 carácteres",
			valor:"Solo números decimales",
			descripcion:"Minimo 10 carácteres, máximo 250 carácteres",
			areaTotal:"Solo números decimales",
			areaConstruido:"Solo números decimales",
			areaCercado:"Solo números decimales",
			pisos:"Solo números",
			ambientes:"Solo números",
			direccion:"Máximo 100 carácteres",
			antiguedad:"Solo números"
		},
		submitHandler:function(form){
			$("#hdnIdInmuebleAux").val($("#hdnIdInmueble").text());
			if(flag == true){
				$.ajax({
			 		url: 'editarInmueble',
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarInmueble").serialize(),
			 		success: function(inmueble){
			 			initInmueble(inmueble);
			 			$("#divMostrarInmueble").show();
			 			$("#divEditarInmueble").hide();
			 		}
			 	});
			}else{
				alert("Debe Corregir los datos");
			}
		}
	});
});
$(document).on('click','#btnEditarInmueble', function(e){
	//TABS A OCULTAR Y MOSTRAR
	$("#divMostrarInmueble").hide();
	$("#divEditarInmueble").show();
	
	//Cargar datos
	$("#txtPartida").val($("#spnPartida").text());
	$("#txtValor").val($("#spnValor").text());
	$("#txtDescripcion").val($("#spnDescripcion").text());
	$("#txtAreaTotal").val($("#spnAreaTotal").text());
	$("#txtAreaCercado").val($("#spnAreaCercado").text());
	$("#txtAreaConstruido").val($("#spnAreaConstruido").text());
	$("#txtPisos").val($("#spnPisos").text());
	$("#txtAmbientes").val($("#spnAmbientes").text());
	$("#txtDireccion").val($("#spnDireccion").text());
	$("#txtAntiguedad").val($("#spnAntiguedad").text());
});
$(document).on('click','#btnCancelEditar', function(e){
	//TABS A OCULTAR Y MOSTRAR
	$("#divEditarInmueble").hide();
	$("#divMostrarInmueble").show();
});
$(document).on('change','#txtPartida', function(e){
	$.ajax({
		url: 'getPartidaRegistral-'+$('#txtPartida').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(bien){
			if(bien == true){
				$("#alertasBienNuevo").show();
				$("#alertasBienNuevo").empty();
				$("#alertasBienNuevo").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">×</a>'+
	 			        '<strong id="msgVerde">Partida Registral usado ya existe.</strong>'+
	 			    '</div>');
				flag = false;
			}else{
				flag = true;
			}
		}
	});
});
</script>
<div id="divInmueble">
	<div id="divMostrarInmueble">
	<form:form class="form-horizontal">
		<fieldset>
			<legend>
				<span class=""><span class="colored">///</span> Datos del Bien Inmueble:</span>
				<span class="offset3"><button class="btn btn-primary btn-small" type="button" id="btnEditarInmueble"><i class="icon-edit"></i> Editar</button></span>
			</legend>
			<div class="control-group" >
				<label class="control-label">Codigo: </label>
				<div class="controls">
					<span id="spnCodigo">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Partida Registral: </label>
				<div class="controls">
					<span id="spnPartida">&nbsp;</span>
				</div>
			</div>
			<div class="control-group" >
				<label class="control-label">Valor Monetario: </label>
				<div class="controls">
					S/. <span id="spnValor">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Descripcion: </label>
				<div class="controls">
					<span id="spnDescripcion">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Area total: </label>
				<div class="controls">
					<span id="spnAreaTotal">&nbsp;</span> m2
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Area cercado: </label>
				<div class="controls">
					<span id="spnAreaCercado">&nbsp;</span> m2
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Area construido: </label>
				<div class="controls">
					<span id="spnAreaConstruido">&nbsp;</span> m2
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Pisos: </label>
				<div class="controls">
					<span id="spnPisos">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Ambientes: </label>
				<div class="controls">
					<span id="spnAmbientes">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Dirección: </label>
				<div class="controls">
					<span id="spnDireccion">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Antigüedad: </label>
				<div class="controls">
					<span id="spnAntiguedad">&nbsp;</span> años
				</div>
			</div>
		</fieldset>
	</form:form>
</div>
<!-- EDITAR CAOS CRIMINAL -->
	<fieldset class="well" style="display: none;" id="divEditarInmueble">
	<div id="alertasBienNuevo" style="display: none;">
	</div>
		<form:form class="form-horizontal" id="formEditarInmueble" action="editarInmueble" commandName="bien">
				<input type="hidden" name="idInmueble" id="hdnIdInmuebleAux">
				<legend>
			       	<span class="colored">///</span> Editar Bien Inmueble:
		       	</legend>
		       	<div class="control-group">
	          		<label class="control-label">Partida Registral: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="partidaRegistral" id="txtPartida" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Valor Monetario: </label>
	          		<div class="controls">
	          			<div class="input-prepend">
		          			<span class="add-on">S/.</span>
		          			<input class="span3" type="text" name="valor" id="txtValor" data-rule-required="true" data-msg-required="*">
		          		</div>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Descripcion: </label>
	          		<div class="controls">
	          			<textarea class="input-xlarge" name="descripcion" id="txtDescripcion" rows="3" style="width: 400px" data-rule-required="true" data-msg-required="*"></textarea>
	          		</div>
	       		</div>
	       		<hr>
	       
	       		
	       		<!-- Bien del tipo inmueble -->
	       		<div class="control-group" id="divATotal">
	          		<label class="control-label">Area total: </label>
	          		<div class="controls">
	          			<div class="input-append">
		          			<input class="span2" type="text" name="areaTotal" id="txtAreaTotal" data-rule-required="false" data-msg-required="*">
		          			<span class="add-on">m2</span>
	          			</div>	          			
	          		</div>
	       		</div>
	       		<div class="control-group" id="divACercado">
	          		<label class="control-label">Area Cercado: </label>
	          		<div class="controls">
	          			<div class="input-append">
	          				<input class="span2" type="text" name="areaCercado" id="txtAreaCercado" data-rule-required="false" data-msg-required="*">
	          				<span class="add-on">m2</span>
	          			</div>	          			
	          		</div>
	       		</div>
	       		<div class="control-group" id="divAConstruido">
	          		<label class="control-label">Area Construido: </label>
	          		<div class="controls">
	          			<div class="input-append">
	          				<input class="span2" type="text" name="areaConstruido" id="txtAreaConstruido" data-rule-required="false" data-msg-required="*">
	          				<span class="add-on">m2</span>
	          			</div>	          			
	          		</div>
	       		</div>
	       		<div class="control-group" id="divPisos">
	          		<label class="control-label">Pisos: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="pisos" id="txtPisos" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group" id="divAmbientes">
	          		<label class="control-label">Ambientes: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="ambientes" id="txtAmbientes" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group" id="divDireccion">
	          		<label class="control-label">Dirección: </label>
	          		<div class="controls">
	          			<input class="span4" type="text" name="direccion" id="txtDireccion" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group" id="divAntiguedad">
	          		<label class="control-label">Antigüedad: </label>
	          		<div class="controls">
	          			<div class="input-append">
	          				<input class="span4" type="text" name="antiguedad" id="txtAntiguedad" data-rule-required="true" data-msg-required="*">
	          				<span class="add-on">años</span>
	          			</div>	          			
	          		</div>
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
