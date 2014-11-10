<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(document).on('change','#txtFecFabricacion', function(e){
	if($("#txtFecFabricacion").val() != ''){
		var fec = $("#txtFecFabricacion").val();
		$("#hdnFecFab").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}else{
		$("#hdnFecFab").val("");
	}
});
function initVehiculo(vehiculo){
	
	// Cabecera	
	$("#hdrCodigo").empty();
	$("#hdrPartida").empty();
	$("#hdrDescripcion").empty();
	$("#hdrValor").empty();
	$("#hdrCreador").empty();
	
	$("#hdrCodigo").append(vehiculo.codigo);
	$("#hdrPartida").append(vehiculo.partidaRegistral);
	$("#hdrDescripcion").append(vehiculo.descripcion);
	$("#hdrValor").append(vehiculo.valor);
	$("#hdrCreador").append('<a href="toPerfil-'+vehiculo.idPerfil+'">'+vehiculo.primerNombre+ ' ' +vehiculo.segundoNombre+ ' ' +vehiculo.apePaterno+ ' ' +vehiculo.apeMaterno+'</a>');
	if(vehiculo.urlVehiculo != null){
		$("#tdImagen").empty();
		$("#tdImagen").append('<img src="'+vehiculo.urlVehiculo+'" alt="foto" style="width: 90px; height: 120px;"/>');
	}
	
	// Cuerpo
	$("#spnCodigo").empty();
	$("#spnValor").empty();
	$("#spnPartida").empty();
	$("#spnDescripcion").empty();
	$("#spnMarca").empty();
	$("#spnModelo").empty();
	$("#spnColor").empty();
	$("#spnPlaca").empty();
	$("#spnChasis").empty();
	$("#spnMotor").empty();
	$("#spnAltura").empty();
	$("#spnLongitud").empty();
	$("#spnAncho").empty();
	$("#spnPesoBruto").empty();
	$("#spnPesoNeto").empty();
	$("#spnRuedas").empty();
	$("#spnEjes").empty();
	$("#spnPasajeros").empty();
	$("#spnAsientos").empty();
	$("#spnFecFabricacion").empty();

	
	$("#spnCodigo").append(vehiculo.codigo);
	$("#spnPartida").append(vehiculo.partidaRegistral);
	$("#spnValor").append(vehiculo.valor);
	$("#spnDescripcion").append(vehiculo.descripcion);
	$("#spnMarca").append(vehiculo.marca);
	$("#spnModelo").append(vehiculo.modelo);
	$("#spnColor").append(vehiculo.color);
	$("#spnPlaca").append(vehiculo.placa);
	$("#spnChasis").append(vehiculo.chasis);
	$("#spnMotor").append(vehiculo.motor);
	$("#spnAltura").append(vehiculo.altura);
	$("#spnLongitud").append(vehiculo.longitud);
	$("#spnAncho").append(vehiculo.ancho);
	$("#spnPesoBruto").append(vehiculo.pesoBruto);
	$("#spnPesoNeto").append(vehiculo.pesoNeto);
	$("#spnRuedas").append(vehiculo.ruedas);
	$("#spnEjes").append(vehiculo.ejes);
	$("#spnPasajeros").append(vehiculo.pasajeros);
	$("#spnAsientos").append(vehiculo.asientos);
	var fec = vehiculo.fecFabricacion;
	$("#spnFecFabricacion").append(fec.split("-")[2]+"/"+fec.split("-")[1]+"/"+fec.split("-")[0]);
	
}
var flag = true;
var flag2 = true;
$(document).ready(function(){
	var idVehiculo = $("#hdnIdVehiculo").text();
	$.ajax({
 		url: 'getVehiculo-'+idVehiculo,
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(vehiculo){
 			initVehiculo(vehiculo);
 		}
 	});
	
//$( ".datepicker" ).datepicker({ dateFormat: 'dd/mm/yy' });
	$('#sandbox-container .input-group.date').datepicker({
		format: "dd/mm/yyyy",
		language: "es",
	    autoclose: true,
	    todayHighlight: true
	});
	
	$("#formEditarVehiculo").validate({
		rules:{
			partidaRegistral:{required:true, minlength: 8, maxlength: 8},
			valor:{required:true,doubleNumber:true},
			descripcion:{required:true, minlength: 10,maxlength: 250},
			marca:{required:true,maxlength:30},
			modelo:{required:true,maxlength:30},
			placa:{required:true,maxlength:30},
			chasis:{required:true,maxlength:50},
			motor:{required:true,maxlength:50},
			color:{required:true,minlength:1,maxlength:30},
			altura:{required:true,doubleNumber:true},
			longitud:{required:true,doubleNumber:true},
			ancho:{required:true,doubleNumber:true},
			pesoBruto:{doubleNumber:true},
			pesoNeto:{doubleNumber:true},
			ruedas:{number:true},
			ejes:{number:true},
			pasajeros:{number:true},
			asientos:{number:true},
			fecFabricacion:{required:true,peruDate:true}
		},
		messages:{
			partidaRegistral:"Complete los 8 carácteres",
			valor:"Solo números decimales",
			descripcion:"Minimo 10 carácteres, máximo 250 carácteres",
			marca:"Máximo 30 caracteres",
			modelo:"Máximo 30 caracteres",
			placa:"Máximo 30 caracteres",
			chasis:"Máximo 50 caracteres",
			motor:"Máximo 50 caracteres",
			color:"Máximo 30 caracteres",
			altura:"Solo números decimales",
			longitud:"Solo números decimales",
			ancho:"Solo números decimales",
			pesoBruto:"Solo números decimales",
			pesoNeto:"Solo números decimales",
			ruedas:"Solo números",
			ejes:"Solo números",
			pasajeros:"Solo números",
			asientos:"Solo números",
			fecFabricacion: "Debe tener formato de fecha dd/mm/aaaa"
		},
		submitHandler: function(form){			
			$("#hdnIdVehiculoAux").val($("#hdnIdVehiculo").text());
			if(flag == true && flag2 == true){
				$.ajax({
			 		url: 'editarVehiculo',
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarVehiculo").serialize(),
			 		success: function(vehiculo){
			 			initVehiculo(vehiculo);
			 			$("#divMostrarVehiculo").show();
			 			$("#divEditarVehiculo").hide();
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
	$("#divMostrarVehiculo").hide();
	$("#divEditarVehiculo").show();
	
	//Cargar datos
	$("#txtPartida").val($("#spnPartida").text());
	$("#txtValor").val($("#spnValor").text());
	$("#txtDescripcion").val($("#spnDescripcion").text());
	$("#txtMarca").val($("#spnMarca").text());
	$("#txtModelo").val($("#spnModelo").text());
	$("#txtColor").val($("#spnColor").text());
	$("#txtPlaca").val($("#spnPlaca").text());
	$("#txtChasis").val($("#spnChasis").text());
	$("#txtMotor").val($("#spnMotor").text());
	$("#txtAltura").val($("#spnAltura").text());
	$("#txtLongitud").val($("#spnLongitud").text());
	$("#txtAncho").val($("#spnAncho").text());
	$("#txtPesoBruto").val($("#spnPesoBruto").text());
	$("#txtPesoNeto").val($("#spnPesoNeto").text());
	$("#txtRuedas").val($("#spnRuedas").text());
	$("#txtEjes").val($("#spnEjes").text());
	$("#txtPasajeros").val($("#spnPasajeros").text());
	$("#txtAsientos").val($("#spnAsientos").text());
	$("#txtFecFabricacion").val($("#spnFecFabricacion").text());
	var fec = $("#txtFecFabricacion").val();
	$("#hdnFecFab").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
});
$(document).on('click','#btnCancelEditar', function(e){
	//TABS A OCULTAR Y MOSTRAR
	$("#divEditarVehiculo").hide();
	$("#divMostrarVehiculo").show();
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
$(document).on('change','#txtPlaca', function(e){
	$.ajax({
		url: 'getPlaca-'+$('#txtPlaca').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(bien){
			if(bien == true){
				$("#alertasBienNuevo2").show();
				$("#alertasBienNuevo2").empty();
				$("#alertasBienNuevo2").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">×</a>'+
	 			        '<strong id="msgVerde">Placa usada ya existe.</strong>'+
	 			    '</div>');
				flag = false;
			}else{
				flag = true;
			}
		}
	});
});
</script>
<div id="divVehiculo">
	<div id="divMostrarVehiculo">
		<div class="panel panel-default">
			<div class="panel-heading">
				<span>/// Datos del Bien Vehicular:</span>
				<div class="pull-right">
					<div class="btn-group">
						<button class="btn btn-outline btn-primary btn-sm" type="button" id="btnEditarInmueble"><i class="fa fa-edit fa-fw"></i> Editar</button>
					</div>
				</div>
			</div>
			<div class="panel-body" id="divPerfilMostrar">
				<div class="col-lg-6">
					<div class="form-group" >
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
						<label >Marca: </label>
						<span id="spnMarca">&nbsp;</span>
					</div>
					<div class="form-group">
						<label >Modelo: </label>
						<span id="spnModelo">&nbsp;</span>
					</div>
					<div class="form-group">
						<label >Color: </label>
						<span id="spnColor">&nbsp;</span>
					</div>
					<div class="form-group">
						<label >Placa: </label>
						<span id="spnPlaca">&nbsp;</span>
					</div>
					<div class="form-group">
						<label >Chasis: </label>
						<span id="spnChasis">&nbsp;</span>
					</div>
					<div class="form-group">
						<label >Motor: </label>
						<span id="spnMotor">&nbsp;</span>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="form-group">
						<label >Altura: </label>
						<span id="spnAltura">&nbsp;</span> m
					</div>
					<div class="form-group">
						<label >Longitud: </label>
						<span id="spnLongitud">&nbsp;</span> m
					</div>
					<div class="form-group">
						<label >Ancho: </label>
						<span id="spnAncho">&nbsp;</span> m
					</div>
					<div class="form-group">
						<label >Peso Bruto: </label>
						<span id="spnPesoBruto">&nbsp;</span> Kg
					</div>
					<div class="form-group">
						<label >Peso Neto: </label>
						<span id="spnPesoNeto">&nbsp;</span> Kg
					</div>
					<div class="form-group">
						<label >Ruedas: </label>
						<span id="spnRuedas">&nbsp;</span>
					</div>
					<div class="form-group">
						<label >Ejes: </label>
						<span id="spnEjes">&nbsp;</span>
					</div>
					<div class="form-group">
						<label >Pasajeros: </label>
						<span id="spnPasajeros">&nbsp;</span>
					</div>
					<div class="form-group">
						<label >Asientos: </label>
						<span id="spnAsientos">&nbsp;</span>
					</div>
					<div class="form-group">
						<label >Fecha de Fabricación: </label>
						<span id="spnFecFabricacion">&nbsp;</span>
					</div>
				</div>				
			</div>
		</div>
</div>
<!-- EDITAR CAOS CRIMINAL -->
	<div style="display: none;" id="divEditarVehiculo">
		<div class="panel panel-default">
			<div class="panel-heading">
				<span>/// Editar Bien Vehicular:</span>
			</div>
			<div class="panel-body" id="divPerfilMostrar">
			<div id="alertasBienNuevo" style="display: none;">
			</div>
			<div id="alertasBienNuevo2" style="display: none;">
			</div>
			<form:form class="form-horizontal" id="formEditarVehiculo" action="editarVehiculo" commandName="editarVehiculo">
				<div class="col-lg-5">				
					<input type="hidden" name="idVehiculo" id="hdnIdVehiculoAux">
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
		       		<div class="form-group">
		          		<label >Marca: </label>
		          		<input class="form-control" type="text" name="marca" id="txtMarca" data-rule-required="true" data-msg-required="*">
		       		</div>
		       		<div class="form-group">
		          		<label >Modelo: </label>
		          		<input class="form-control" type="text" name="modelo" id="txtModelo" data-rule-required="false">
		       		</div>
		       		<div class="form-group">
		          		<label >Color: </label>
		          		<input class="form-control" type="text" name="color" id="txtColor" data-rule-required="true" data-msg-required="*">
		       		</div>		       		
		       		<div class="form-group">
		          		<label >Placa: </label>
		          		<input class="form-control" type="text" name="placa" id="txtPlaca" data-rule-required="true" data-msg-required="*">
		       		</div>
		       		<div class="form-group">
		          		<label >Chasis: </label>
		          		<input class="form-control" type="text" name="chasis" id="txtChasis" data-rule-required="false">
		       		</div>		       		
		       		<div class="form-group">
		          		<label >Motor: </label>
		          		<input class="form-control" type="text" name="motor" id="txtMotor" data-rule-required="false">
		       		</div>
	       		</div>
	       		<div class="col-lg-5 col-md-offset-1">
		       		<div class="form-group">
		          		<label >Altura: </label>
	          			<div class="input-append input-group">
	          				<input class="form-control" type="text" name="altura" id="txtAltura" data-rule-required="true" data-msg-required="*">
	          				<span class="input-group-addon">m</span>
	          			</div>
		       		</div>
		       		<div class="form-group">
		          		<label >Longitud: </label>
	          			<div class="input-append input-group">
	          				<input class="form-control" type="text" name="longitud" id="txtLongitud" data-rule-required="true" data-msg-required="*">
	          				<span class="input-group-addon">m</span>
	          			</div>
		       		</div>
		       		<div class="form-group">
		          		<label >Ancho: </label>
	          			<div class="input-append input-group">
	          				<input class="form-control" type="text" name="ancho" id="txtAncho" data-rule-required="true" data-msg-required="*">
	          				<span class="input-group-addon">m</span>
	          			</div>
		       		</div>
		       		<div class="form-group">
		          		<label >Peso Bruto: </label>
	          			<div class="input-append input-group">
	          				<input class="form-control" type="text" name=pesoBruto id="txtPesoBruto" data-rule-required="false">
	          				<span class="input-group-addon">Kg</span>
	          			</div>
		       		</div>
		       		<div class="form-group">
		          		<label >Peso Neto: </label>
	          			<div class="input-append input-group">
	          				<input class="form-control" type="text" name="pesoNeto" id="txtPesoNeto" data-rule-required="false">
	          				<span class="input-group-addon">Kg</span>
	          			</div>
		       		</div>		       		
		       		<div class="form-group">
		          		<label >Ruedas: </label>
		          		<input class="form-control" type="text" name="ruedas" id="txtRuedas" data-rule-required="false">
		       		</div>
		       		<div class="form-group">
		          		<label >Ejes: </label>
		          		<input class="form-control" type="text" name="ejes" id="txtEjes" data-rule-required="false">
		       		</div>		       		
		       		<div class="form-group">
		          		<label >Pasajeros: </label>
		          		<input class="form-control" type="text" name="pasajeros" id="txtPasajeros" data-rule-required="false">
		       		</div>
		       		<div class="form-group">
		          		<label >Asientos: </label>
		          		<input class="form-control" type="text" name="asientos" id="txtAsientos" data-rule-required="false">
		       		</div>
		       		<div class="form-group">
		          		<label >Fecha de Fabricación: </label>
		          		<div id="sandbox-container">
					          <div class="input-group date">
		          				<input class="form-control datepicker" type="text" name="txtFecFabricacion" id="txtFecFabricacion" data-rule-required="true" data-msg-required="*">
		          				<span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
		          			</div>
		          		</div>
		       		</div>
		       		<input class="span2" type="hidden" name="fecFabricacion" id="hdnFecFab">		       		
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
