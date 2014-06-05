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
	$("#hdrCreador").empty();
	
	$("#hdrCodigo").append(vehiculo.codigo);
	$("#hdrPartida").append(vehiculo.partidaRegistral);
	$("#hdrDescripcion").append(vehiculo.descripcion);
	$("#hdrCreador").append('<a href="toPerfil-'+vehiculo.idPerfil+'">'+vehiculo.primerNombre+ ' ' +vehiculo.segundoNombre+ ' ' +vehiculo.apePaterno+ ' ' +vehiculo.apeMaterno+ '('+vehiculo.tipoFiscal+')</a>');
	
	// Cuerpo
	$("#spnCodigo").empty();
	$("#spnPartida").empty();
	$("#spnDescripcion").empty();
	$("#spnPropietario").empty();
	$("#spnCasoCriminal").empty();
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
	$("#spnDescripcion").append(vehiculo.descripcion);
	$("#spnPropietario").append("");
	$("#spnCasoCriminal").append("");
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
	
$( ".datepicker" ).datepicker({ dateFormat: 'dd/mm/yy' });
	
	$("#formEditarVehiculo").validate({
		rules:{
			partidaRegistral:{required:true, minlength: 8, maxlength: 8},
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
		}
	});
	
});
$(document).on('click','#btnEditarInmueble', function(e){
	//TABS A OCULTAR Y MOSTRAR
	$("#divMostrarVehiculo").hide();
	$("#divEditarVehiculo").show();
	
	//Cargar datos
	$("#txtPartida").val($("#spnPartida").text());
	$("#txtDescripcion").val($("#spnDescripcion").text());
	$("#txtPropietario").val($("#spnPropietario").text());
	$("#txtCasoCriminal").val($("#spnCasoCriminal").text());
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

</script>
<div id="divVehiculo">
	<div id="divMostrarVehiculo">
	<form:form class="form-horizontal">
		<fieldset>
			<legend>
				<span class=""><span class="colored">///</span> Datos del Bien Vehicular:</span>
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
			<div class="control-group">
				<label class="control-label">Descripcion: </label>
				<div class="controls">
					<span id="spnDescripcion">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Propietario: </label>
				<div class="controls">
					<span id="spnPropietario">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Caso Criminal: </label>
				<div class="controls">
					<span id="spnAsunto">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Marca: </label>
				<div class="controls">
					<span id="spnMarca">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Modelo: </label>
				<div class="controls">
					<span id="spnModelo">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Color: </label>
				<div class="controls">
					<span id="spnColor">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Placa: </label>
				<div class="controls">
					<span id="spnPlaca">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Chasis: </label>
				<div class="controls">
					<span id="spnChasis">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Motor: </label>
				<div class="controls">
					<span id="spnMotor">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Altura(m): </label>
				<div class="controls">
					<span id="spnAltura">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Longitud(m): </label>
				<div class="controls">
					<span id="spnLongitud">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Ancho(m): </label>
				<div class="controls">
					<span id="spnAncho">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Peso Bruto(Kg): </label>
				<div class="controls">
					<span id="spnPesoBruto">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Peso Neto(Kg): </label>
				<div class="controls">
					<span id="spnPesoNeto">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Ruedas: </label>
				<div class="controls">
					<span id="spnRuedas">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Ejes: </label>
				<div class="controls">
					<span id="spnEjes">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Pasajeros: </label>
				<div class="controls">
					<span id="spnPasajeros">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Asientos: </label>
				<div class="controls">
					<span id="spnAsientos">&nbsp;</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Fecha de Fabricación: </label>
				<div class="controls">
					<span id="spnFecFabricacion">&nbsp;</span>
				</div>
			</div>
		</fieldset>
	</form:form>
</div>
<!-- EDITAR CAOS CRIMINAL -->
	<fieldset class="well" style="display: none;" id="divEditarVehiculo">
		<form:form class="form-horizontal" id="formEditarVehiculo" action="editarVehiculo" commandName="editarVehiculo">
				<input type="hidden" name="idVehiculo" id="hdnIdVehiculoAux">
				<legend>
			       	<span class="colored">///</span> Editar Bien Vehicular:
		       	</legend>
		       	<div class="control-group">
	          		<label class="control-label">Partida Registral: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="partidaRegistral" id="txtPartida" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Descripcion: </label>
	          		<div class="controls">
	          			<textarea class="input-xlarge" name="descripcion" id="txtDescripcion" rows="3" style="width: 400px" data-rule-required="true" data-msg-required="*"></textarea>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Propietario: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="txtPropietario" id="txtPropietario" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Caso Criminal: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="txtCasoCriminal" id="txtCasoCriminal" data-rule-required="false">
	          		</div>
	       		</div>
	       		<hr>
	       		
	       		<!-- Bien del tipo vehiculo -->
	       		<div class="control-group">
	          		<label class="control-label">Marca: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="marca" id="txtMarca" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Modelo: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="modelo" id="txtModelo" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Color: </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="color" id="txtColor" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		
	       		<div class="control-group">
	          		<label class="control-label">Placa: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="placa" id="txtPlaca" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Chasis: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="chasis" id="txtChasis" data-rule-required="false">
	          		</div>
	       		</div>
	       		
	       		<div class="control-group">
	          		<label class="control-label">Motor: </label>
	          		<div class="controls">
	          			<input class="span3" type="text" name="motor" id="txtMotor" data-rule-required="false">
	          		</div>
	       		</div>
	       		
	       		
	       		<div class="control-group">
	          		<label class="control-label">Altura(m): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="altura" id="txtAltura" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Longitud(m): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="longitud" id="txtLongitud" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Ancho(m): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="ancho" id="txtAncho" data-rule-required="true" data-msg-required="*">
	          		</div>
	       		</div>
	       		
	       		
	       		<div class="control-group">
	          		<label class="control-label">Peso Bruto(Kg): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name=pesoBruto id="txtPesoBruto" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Peso Neto(Kg): </label>
	          		<div class="controls">
	          			<input class="span2" type="text" name="pesoNeto" id="txtPesoNeto" data-rule-required="false">
	          		</div>
	       		</div>
	       		
	       		<div class="control-group">
	          		<label class="control-label">Ruedas: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="ruedas" id="txtRuedas" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Ejes: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="ejes" id="txtEjes" data-rule-required="false">
	          		</div>
	       		</div>
	       		
	       		<div class="control-group">
	          		<label class="control-label">Pasajeros: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="pasajeros" id="txtPasajeros" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Asientos: </label>
	          		<div class="controls">
	          			<input class="span1" type="text" name="asientos" id="txtAsientos" data-rule-required="false">
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Fecha de Fabricación: </label>
	          		<div class="controls">
	          			<input class="span2 datepicker" type="text" name="txtFecFabricacion" id="txtFecFabricacion" data-rule-required="true" data-msg-required="*">
	          			<input class="span2" type="hidden" name="fecFabricacion" id="hdnFecFab">
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
