<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
.controls{
	margin-top: 3px;
}
</style>
<script type="text/javascript">
function initRasgosParticulares(rasgosParticulares){
	//TAB RASGOS PARTICULARES
	$("#spnTatuajes").empty();
	$("#spnLunares").empty();
	$("#spnCicatrices").empty();
	$("#spnDeficiencias").empty();
	$("#spnOtros").empty();
	
	$("#spntextoTatuajes").empty();
	$("#spntextoLunares").empty();
	$("#spntextoCicatrices").empty();
	$("#spntextoDeficiencias").empty();
	$("#spntextoOtros").empty();
	
	
	$("#spnTatuajes").append(rasgosParticulares.tatuaje);
	$("#spnLunares").append(rasgosParticulares.lunares);
	$("#spnCicatrices").append(rasgosParticulares.cicatrices);
	$("#spnDeficiencias").append(rasgosParticulares.deficiencias);
	$("#spnOtros").append(rasgosParticulares.otros);
	
	$("#spntextoTatuajes").append(rasgosParticulares.textoTatuaje);
	$("#spntextoLunares").append(rasgosParticulares.textoLunares);
	$("#spntextoCicatrices").append(rasgosParticulares.textoCicatrices);
	$("#spntextoDeficiencias").append(rasgosParticulares.textoDeficiencias);
	$("#spntextoOtros").append(rasgosParticulares.textoOtros);
}
	$(document).ready(function(){
		var idSospechoso = $("#hdnIdSospechoso").text();
		$.ajax({
	 		url: 'getRasgosParticulares-'+idSospechoso,
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(rasgos){
	 			initRasgosParticulares(rasgos);
	 		}
	 	});
		//VALIDACIONES
		$("#formEditarRasgos").validate({
			rules:
			{
				txtTatuajes:{maxlength: 1500},
				txtLunares:{maxlength: 1500},
				txtCicatrices:{maxlength: 1500},
				txtDeficiencias:{maxlength: 1500},
				txtOtros:{maxlength: 1500}
			},
			messages:
			{
				txtTatuajes:"Supero el límite (1500).",
				txtLunares:"Supero el límite (1500).",
				txtCicatrices:"Supero el límite (1500).",
				txtDeficiencias:"Supero el límite (1500).",
				txtOtros:"Supero el límite (1500)."
			},
			submitHandler: function(form){
				$("#hdnIdSospechosoRasgos").val($("#hdnIdSospechoso").text());
				$.ajax({
					url: 'editarRasgos',
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarRasgos").serialize(),
			 		success: function(rasgosParticulares){
			 			initRasgosParticulares(rasgosParticulares);
			 			$("#divMostrarRasgos").show();
			 			$("#divEditarRasgos").hide();
			 		}
				});
			}
		});
	});
	$(document).on('click','#btnEditarRasgos', function(e){
		$("#txtTatuajes").hide();
		$("#txtLunares").hide();
		$("#txtCicatrices").hide();
		$("#txtDeficiencias").hide();
		$("#txtOtros").hide();
		//COMPONENTES DEL EDITAR
		if($("#spnTatuajes").text() =='SI'){
			$("#radioTSi").prop("checked",true);
			$("#txtTatuajes").show();
			$("#txtTatuajes").val($("#spntextoTatuajes").text());
		}else if($("#spnTatuajes").text() =='NO'){
			$("#radioTNo").prop("checked",true);
		}
		
		if($("#spnLunares").text() =='SI'){
			$("#radioLSi").prop("checked",true);
			$("#txtLunares").show();
			$("#txtLunares").val($("#spntextoLunares").text());
		}else if($("#spnLunares").text() =='NO'){
			$("#radioLNo").prop("checked",true);
		}
		
		if($("#spnCicatrices").text() =='SI'){
			$("#radioCSi").prop("checked",true);
			$("#txtCicatrices").show();
			$("#txtCicatrices").val($("#spntextoCicatrices").text());
		}else if($("#spnCicatrices").text()=='NO'){
			$("#radioCNo").prop("checked",true);
		}
		
		if($("#spnDeficiencias").text() =='SI'){
			$("#radioDSi").prop("checked",true);
			$("#txtDeficiencias").show();
			$("#txtDeficiencias").val($("#spntextoDeficiencias").text());
		}else if($("#spnDeficiencias").text()=='NO'){
			$("#radioDNo").prop("checked",true);
		}
		
		if($("#spnOtros").text() =='SI'){
			$("#radioOSi").prop("checked",true);
			$("#txtOtros").show();
			$("#txtOtros").val($("#spntextoOtros").text());
		}else if($("#spnOtros").text()=='NO'){
			$("#radioONo").prop("checked",true);
		}
		
		//TABS A OCULTAR Y MOSTRAR
		$("#divMostrarRasgos").hide();
		$("#divEditarRasgos").show();
	});
	//Limpieza de los textArea al dar NO
	$(document).on('click','#radioTNo', function(e){
		$("#txtTatuajes").val("");
	});
	$(document).on('click','#radioLNo', function(e){
		$("#txtLunares").val("");
	});
	$(document).on('click','#radioCNo', function(e){
		$("#txtCicatrices").val("");
	});
	$(document).on('click','#radioDNo', function(e){
		$("#txtDeficiencias").val("");
	});
	$(document).on('click','#radioONo', function(e){
		$("#txtOtros").val("");
	});
	$(document).on('click','#btnCancelEditar', function(e){
		//TABS A MOSTRAR Y OCULTAR
		$("#divMostrarRasgos").show();
		$("#divEditarRasgos").hide();
	});
	//RADIO BUTTONS PARA LA APARICION DE LOS TEXT AREA
	$(document).on('click','#radioTSi', function(e){
		$("#txtTatuajes").show();
		$("#lblTatuajes").css("margin-top","87px");
	});
	$(document).on('click','#radioTNo', function(e){
		$("#txtTatuajes").hide();
		$("#txtTatuajes").val("");
		$("#lblTatuajes").css("margin-top","0px");
	});
	
	$(document).on('click','#radioLSi', function(e){
		$("#txtLunares").show();
		$("#lblLunares").css("margin-top","87px");
	});
	$(document).on('click','#radioLNo', function(e){
		$("#txtLunares").hide();
		$("#lblLunares").css("margin-top","0px");
	});
	
	$(document).on('click','#radioCSi', function(e){
		$("#txtCicatrices").show();
		$("#lblCicatrices").css("margin-top","87px");
	});
	$(document).on('click','#radioCNo', function(e){
		$("#txtCicatrices").hide();
		$("#lblCicatrices").css("margin-top","0px");
	});
	
	$(document).on('click','#radioDSi', function(e){
		$("#txtDeficiencias").show();
		$("#lblDeficiencias").css("margin-top","87px");
	});
	$(document).on('click','#radioDNo', function(e){
		$("#txtDeficiencias").hide();
		$("#lblDeficiencias").css("margin-top","0px");
	});
	
	$(document).on('click','#radioOSi', function(e){
		$("#txtOtros").show();
		$("#lblOtros").css("margin-top","87px");
	});
	$(document).on('click','#radioONo', function(e){
		$("#txtOtros").hide();
		$("#lblOtros").css("margin-top","0px");
	});
</script>
<body>
<!-- MOSTRAR RASGOS PARTICULARES -->
	<div id="divMostrarRasgosParticulares">
		<div id="divMostrarRasgos">
			<form:form class="form-horizontal">
				<legend>
		       		<span class=""><span class="colored">///</span> Rasgos Particulares del Sospechoso:</span>
		       		<span class="offset3"><button class="btn btn-primary" type="button" id="btnEditarRasgos"><i class="icon-edit"></i> Editar</button></span>
	       		</legend>
	       		<div class="control-group">
	          		<label class="control-label">Tatuajes: </label>
	          		<div class="controls">
	          			<span id="spnTatuajes">&nbsp;</span>
	          		</div>
	          		<br/>
	          		<div class="controls">
	          			<span id="spntextoTatuajes"></span>
	          		</div>
	       		</div>
	       		<hr/>
	       		<div class="control-group">
	          		<label class="control-label">Lunares: </label>
	          		<div class="controls">
	          			<span id="spnLunares">&nbsp;</span>
	          		</div>
	          		<br/>
	          		<div class="controls">
	          			<span id="spntextoLunares"></span>
	          		</div>
	       		</div>
	       		<hr/>
	       		<div class="control-group">
	          		<label class="control-label">Cicatrices: </label>
	          		<div class="controls">
	          			<span id="spnCicatrices">&nbsp;</span>
	          		</div>
	          		<br/>
	          		<div class="controls">
	          			<span id="spntextoCicatrices"></span>
	          		</div>
	       		</div>
	       		<hr/>
	       		<div class="control-group">
	          		<label class="control-label">Deficiencias: </label>
	          		<div class="controls">
	          			<span id="spnDeficiencias">&nbsp;</span>
	          		</div>
	          		<br/>
	          		<div class="controls">
	          			<span id="spntextoDeficiencias"></span>
	          		</div>
	       		</div>
	       		<hr/>
	       		<div class="control-group">
	          		<label class="control-label">Otros: </label>
	          		<div class="controls">
	          			<span id="spnOtros">&nbsp;</span>
	          		</div>
	          		<div class="controls">
	          			<span id="spntextoOtros"></span>
	          		</div>
	       		</div>
			</form:form>
		</div>
		<!-- EDITAR RASGOS PARTICULARES -->
		<fieldset class="well" style="display: none;" id="divEditarRasgos">
			<form:form class="form-horizontal" id="formEditarRasgos" action="editarRasgos" commandName="rasgosParticulares">
				<input type="hidden" name="idSospechosoAux" id="hdnIdSospechosoRasgos">
				<legend>
			       	<span class="colored">///</span> Editar Rasgos Particulares del Sospechoso:
		       	</legend>
		       	<div class="control-group">
					<label class="control-label" id="lblTatuajes">Tatuajes: </label> 
					<label class="checkbox inline"> 
						<input type="radio" name="tatuaje" id="radioTSi" value="SI">SÍ
					</label> 
					<label class="checkbox inline"> 
						<input type="radio" name="tatuaje" id="radioTNo" value="NO" checked>NO
					</label>
					<label class="checkbox inline">
						<textarea rows="10" cols="40" name="textoTatuaje" id="txtTatuajes"></textarea>
					</label>
				</div>
				<hr/>
				<div class="control-group">
					<label class="control-label" id="lblLunares">Lunares: </label> 
					<label class="checkbox inline"> 
						<input type="radio" name="lunares" id="radioLSi" value="SI">SÍ
					</label> 
					<label class="checkbox inline"> 
						<input type="radio" name="lunares" id="radioLNo" value="NO" checked>NO
					</label>
					<label class="checkbox inline"> 
						<textarea rows="10" cols="40" name="textoLunares" id="txtLunares"></textarea>
					</label>
				</div>
				<hr/>
				<div class="control-group">
					<label class="control-label" id="lblCicatrices">Cicatrices: </label> 
					<label class="checkbox inline"> 
						<input type="radio" name="cicatrices" id="radioCSi" value="SI">SÍ
					</label> 
					<label class="checkbox inline"> 
						<input type="radio" name="cicatrices" id="radioCNo" value="NO" checked>NO
					</label>
					<label class="checkbox inline">
						<textarea rows="10" cols="40" name="textoCicatrices" id="txtCicatrices"></textarea>
					</label>
				</div>
				<hr/>
				<div class="control-group">
					<label class="control-label" id="lblDeficiencias">Deficiencias: </label> 
					<label class="checkbox inline"> 
						<input type="radio" name="deficiencias" id="radioDSi" value="SI">SÍ
					</label> 
					<label class="checkbox inline"> 
						<input type="radio" name="deficiencias" id="radioDNo" value="NO" checked>NO
					</label>
					<label class="checkbox inline">
						<textarea rows="10" cols="40" name="textoDeficiencias" id="txtDeficiencias"></textarea>
					</label>
				</div>
				<hr/>
				<div class="control-group">
					<label class="control-label" id="lblOtros">Otros: </label> 
					<label class="checkbox inline"> 
						<input type="radio" name="otros" id="radioOSi" value="SI">SÍ
					</label> 
					<label class="checkbox inline"> 
						<input type="radio" name="otros" id="radioONo" value="NO" checked>NO
					</label>
					<label class="checkbox inline">
						<textarea rows="10" cols="40" name="textoOtros" id="txtOtros"></textarea>
					</label>
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
</body>
</html>