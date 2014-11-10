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
	if(inmueble.urlInmueble != null){
		$("#tdImagen").empty();
		$("#tdImagen").append('<img src="'+inmueble.urlInmueble+'" alt="foto" style="width: 90px; height: 120px;"/>');
	}
	
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
			//if(flag == true){
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
			/*}else{
				alert("Debe Corregir los datos");
			}*/
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
		<div class="panel panel-default">
			<div class="panel-heading">
				<span>/// Datos del Bien Inmueble:</span>
				<div class="pull-right">
					<div class="btn-group">
						<button class="btn btn-outline btn-primary btn-sm" type="button" id="btnEditarInmueble"><i class="fa fa-edit fa-fw"></i> Editar</button>
					</div>
				</div>
			</div>
			<div class="panel-body" id="divPerfilMostrar">
				<div class="form-group">
					<label >Codigo: </label>
					<span id="spnCodigo">&nbsp;</span>
				</div>
				<div class="form-group">
					<label >Partida Registral: </label>
					<span id="spnPartida">&nbsp;</span>
				</div>
				<div class="form-group" >
					<label >Valor Monetario: </label>
					S/. <span id="spnValor">&nbsp;</span>
				</div>
				<div class="form-group">
					<label >Descripcion: </label>
					<span id="spnDescripcion">&nbsp;</span>
				</div>
				<div class="form-group">
					<label >Area total: </label>
					<span id="spnAreaTotal">&nbsp;</span> m2
				</div>
				<div class="form-group">
					<label >Area cercado: </label>
					<span id="spnAreaCercado">&nbsp;</span> m2
				</div>
				<div class="form-group">
					<label >Area construido: </label>
					<span id="spnAreaConstruido">&nbsp;</span> m2
				</div>
				<div class="form-group">
					<label >Pisos: </label>
					<span id="spnPisos">&nbsp;</span>
				</div>
				<div class="form-group">
					<label >Ambientes: </label>
					<span id="spnAmbientes">&nbsp;</span>
				</div>
				<div class="form-group">
					<label >Dirección: </label>
					<span id="spnDireccion">&nbsp;</span>
				</div>
				<div class="form-group">
					<label >Antigüedad: </label>
					<span id="spnAntiguedad">&nbsp;</span> años
				</div>
			</div>
		</div>
</div>
<!-- EDITAR CAOS CRIMINAL -->
<div style="display: none;" id="divEditarInmueble">
	<div class="panel panel-default">
		<div class="panel-heading">
			/// Editar Bien Inmueble:
		</div>
		<div class="panel-body" id="divPerfilMostrar">
		<div id="alertasBienNuevo" style="display: none;">
		</div>
		<div class="col-lg-10">
			<form:form class="form-horizontal" id="formEditarInmueble" action="editarInmueble" commandName="bien">
				<input type="hidden" name="idInmueble" id="hdnIdInmuebleAux">
				<div class="form-group">
	          		<label >Partida Registral: </label>
	          		<input class="form-control" type="text" name="partidaRegistral" id="txtPartida" data-rule-required="true" data-msg-required="*">
	       		</div>
	       		<div class="form-group">
	          		<label >Valor Monetario: </label>
	         			<div class="input-prepend input-group">
	          			<span class="input-group-addon">S/.</span>
	          			<input class="form-control" type="text" name="valor" id="txtValor" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="form-group">
	          		<label >Descripcion: </label>
	          		<textarea class="form-control" name="descripcion" id="txtDescripcion" rows="3" data-rule-required="true" data-msg-required="*"></textarea>
	       		</div>
	       		<!-- Bien del tipo inmueble -->
	       		<div class="form-group" id="divATotal">
	          		<label >Area total: </label>
	         			<div class="input-append input-group">
	          			<input class="form-control" type="text" name="areaTotal" id="txtAreaTotal" data-rule-required="false" data-msg-required="*">
	          			<span class="input-group-addon">m2</span>
	         			</div>	
	       		</div>
	       		<div class="form-group" id="divACercado">
	          		<label >Area Cercado: </label>
	         			<div class="input-append input-group">
	         				<input class="form-control" type="text" name="areaCercado" id="txtAreaCercado" data-rule-required="false" data-msg-required="*">
	         				<span class="input-group-addon">m2</span>
	         			</div>	
	       		</div>
	       		<div class="form-group" id="divAConstruido">
	          		<label >Area Construido: </label>
	         			<div class="input-append input-group">
	         				<input class="form-control" type="text" name="areaConstruido" id="txtAreaConstruido" data-rule-required="false" data-msg-required="*">
	         				<span class="input-group-addon">m2</span>
	         			</div>	
	       		</div>
	       		<div class="form-group" id="divPisos">
	          		<label >Pisos: </label>
	          		<input class="form-control" type="text" name="pisos" id="txtPisos" data-rule-required="true" data-msg-required="*">
	       		</div>
	       		<div class="form-group" id="divAmbientes">
	          		<label >Ambientes: </label>
	          		<input class="form-control" type="text" name="ambientes" id="txtAmbientes" data-rule-required="true" data-msg-required="*">
	       		</div>
	       		<div class="form-group" id="divDireccion">
	          		<label >Dirección: </label>
	          		<input class="form-control" type="text" name="direccion" id="txtDireccion" data-rule-required="true" data-msg-required="*">
	       		</div>
	       		<div class="form-group" id="divAntiguedad">
	          		<label >Antigüedad: </label>
         			<div class="input-append input-group">
         				<input class="form-control" type="text" name="antiguedad" id="txtAntiguedad" data-rule-required="true" data-msg-required="*">
         				<span class="input-group-addon">años</span>
         			</div>	
	       		</div>
	       		<hr class="col-lg-12">			
	       		<div class="well col-lg-12">
	       			<button class="btn btn-outline btn-success" id="btnGuardar" type="submit"><i class="fa fa-check"></i> Guardar</button>
			        <button class="btn btn-outline btn-danger" type="reset"><i class="fa fa-refresh fa-fw"></i> Reset</button>
			        <button class="btn btn-outline btn-warning" type="button" id="btnCancelEditar"><i class="fa fa-arrow-left"></i> Cancel</button>
	       		</div>
			</form:form>
		</div>			
		</div>
	</div>		
	</div>
</div>
