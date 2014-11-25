<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(document).ready(function(){
	var idCaso = $("#hdnIdCaso").text();
	
	initComisos();
	
	$("#formRegistrarComiso").validate({
		submitHandler: function(form){
			//$("#hdnIdSospechosoDatos").val($("#hdnIdSospechoso").text());
			$.ajax({
				url: 'crearComiso',
		 		type: 'post',
		 		dataType: 'json',
		 		data: $("#formRegistrarComiso").serialize(),
		 		success: function(comisos){
		 			initComisos();
		 			limpiarComiso();
		 			$("#alertasComisos").show();
		 			$("#alertasComisos").empty();
		 			$("#alertasComisos").append('<div class="alert alert-success alert-dismissable">'+
					                            '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>'+
					                           '<a href="#" class="alert-link">Creado Correctamente.</a>.'+
					                        '</div>');
		 		}
			});
		}
	});
	
});

function limpiarComiso(){
	$("#txtValorMonetario").val("");
	$("#txtEtiqueta").val("");
	$("#txtPesoNeto").val("");
	$("#txtPesoBruto").val("");
	$("#slctTipoInsOdroga").val("");
}

function initComisos(){
	$("#divResultadoComiso").empty();
	$.ajax({
 		url: 'getComisosDelCaso-'+$("#hdnIdCaso").text(),
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(comisos){
 			 var resultado = '';
 			 resultado += '<table class="table table-striped table-bordered table-hover dataTable" id="dataTableComisoMostrar">'+
							'<thead>'+
								'<tr>'+
									'<td>Código</td>'+
									'<td>Tipo de Comiso</td>'+
									'<td>Tipo de droga o insumo</td>'+
									'<td>Peso Neto</td>'+
									'<td>Peso Bruto</td>'+
									'<td>Etiqueta o Embalaje</td>'+
									'<td>Valor Monetario</td>'+
									'<td>Quitar</td>'+
								'</tr>'+
							'</thead>'+
							'<tbody>';

			$.each(comisos, function(i, comiso){
				resultado += '<tr>'+
								'<td>'+comiso.codigo+'</td>'+
								'<td>'+comiso.tipoDeComiso+'</td>'+
								'<td>'+comiso.tipoDeInsumoOdorga+'</td>'+
								'<td>'+comiso.pesoNeto+' '+ comiso.unidadDeMedidaNeto+'</td>'+
								'<td>'+comiso.pesoBruto+' '+ comiso.unidadDeMedidaBruto+'</td>'+
								'<td>'+comiso.etiquetaOembalaje+'</td>'+
								'<td>'+comiso.valorMonetario+'</td>'+
								'<td><button class="btn btn-outline btn-danger btn-xs btn-circle asignarComiso" id="cancelarAsigna_'+comiso.idComiso+'" type="button"><i class="fa fa-minus"></i></button></td>'+
							'</tr>';
			});
			resultado += '</tbody></table>';
			$("#divResultadoComiso").append(resultado);
	  		$('#dataTableComisoMostrar').dataTable();
	  		
			
 		}
 	});
}

$(document).on('click','.asignarComiso', function(e){
	var id =  this.id;
	var id2 = id.split("_")[0];
	var id3 = id.split("_")[1];
	switch(id2){
		case "cancelarAsigna":
			var respuesta = confirm('¿Esta seguro que desea quitar a este Comiso?');
			if(respuesta){
				$.ajax({
					url: 'quitarComiso-'+$("#hdnIdCaso").text()+"-"+id3,
			 		type: 'post',
			 		dataType: 'json',
			 		data: '',
			 		success: function(comisos){
			 			initComisos();
			 		}
				});				
			}			
		break;
	}
});

$(document).on('click','#rdDroga', function(e){
	$("#lblTipo").empty();
	$("#lblTipo").append('Tipo de Droga: ');
	$("#slctTipoInsOdroga").empty();
	$("#slctTipoInsOdroga").append('<option value="">No Precisa</option>'+
									'<option>Heroína</option>'+
									'<option>Cocaína</option>'+
									'<option>Barbitúricos</option>'+
									'<option>Metadona</option>'+
									'<option>Ketamina</option>'+
									'<option>Benzodiazopines</option>'+
									'<option>Anfetaminas</option>'+
									'<option>Buprenorfina</option>'+
									'<option>Cannabis</option>'+
									'<option>Disolventes</option>'+
									'<option>4-MTA</option>'+
									'<option>LSD</option>'+
									'<option>Metilfenidato</option>'+
									'<option>Esteroides anabolizantes</option>'+
									'<option>GHB</option>'+
									'<option>Éxtasis</option>');
});
$(document).on('click','#rdInsumo', function(e){
	$("#lblTipo").empty();
	$("#lblTipo").append('Tipo de Insumo Fiscalizado: ');
	$("#slctTipoInsOdroga").empty();
	$("#slctTipoInsOdroga").append('<option value="">No Precisa</option>'+
									'<option>Acetona</option>'+
									'<option>Acetato de Etilo</option>'+
									'<option>Ácido Sulfúrico y Oleum</option>'+
									'<option>Ácido Clorhídrico y/o Muriático</option>'+
									'<option>Amoníaco</option>'+
									'<option>Anhídrido Acético</option>'+
									'<option>Benceno</option>'+
									'<option>Carbonato de Sodio</option>'+
									'<option>Carbonato de Potasio</option>'+
									'<option>Cloruro de amonio</option>'+
									'<option>Éter etílico</option>'+
									'<option>Hexano</option>'+
									'<option>Hipoclorito de Sodio (Lejía)</option>'+
									'<option>Kerosene</option>'+
									'<option>Metil Etil Cetona</option>'+
									'<option>Permanganato de Potasio</option>'+
									'<option>Sulfato de Sodio</option>'+
									'<option>Tolueno</option>'+
									'<option>Cloruro de Amonio</option>'+
									'<option>Metil isobutil cetona</option>'+
									'<option>Xileno</option>'+
									'<option>Óxido de Calcio</option>'+
									'<option>Piperonal</option>'+
									'<option>Safrol</option>'+
									'<option>Isosafrol</option>'+
									'<option>Ácido Antranílico</option>');
});

$(document).on('click','#btnAgregarComiso', function(e){
	$("#hdnIdCasoAux").val($("#hdnIdCaso").text());
});
</script>

<div id="divComisos">
	<div id="divMostrarPersonalAsignado">
		<div class="panel panel-default">
		    <div class="panel-heading">
		    	/// Comisos de Droga o Insumos químicos:
		    	<div class="pull-right">
					<div class="btn-group">
						<button class="btn btn-outline btn-primary btn-sm" type="button" id="btnAgregarComiso" data-toggle="modal" data-target="#modalComiso"><i class="fa fa-edit fa-fw"></i> Agregar Comiso</button>
					</div>
				</div>
		    </div>
		    <div class="panel-body">
		    	<div id="divMostrarPersonal">
					<div class="table-responsive">
			       		<div id="divResultadoComiso" class="dataTables_wrapper form-inline" role="grid">
			       			
	           				
	       				</div>
	       			</div> 
				</div>
		    </div>
	    </div>				
	</div>
	<!-- MODAL BIEN MUEBLE-->
	<div class="modal fade" id="modalComiso" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content" style="width: 100%;">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">Comiso nuevo</h4>
				</div>
				<div class="modal-body">
					<div class="panel-body">
					<div id="alertasComisos" style="display: none;"></div>
						<form:form class="form-horizontal" id="formRegistrarComiso" commandName="comiso">
						<input type="hidden" id="hdnIdCasoAux" name="hdnIdCasoAux"/>
							<div class="form-group">
				          		<label>Tipo de Comiso: </label>
				          		<label class="radio-inline">
				          			<input type="radio" checked="checked" name="tipoDeComiso" id="rdDroga" value="Droga">Droga
				          		</label>
				          		<label class="radio-inline">
				          			<input type="radio" name="tipoDeComiso" id="rdInsumo" value="Insumo químico">Insumo químico
				          		</label>
				       		</div>
							<div class="form-group">
								<label id="lblTipo">Tipo de Droga: </label> 
								<select name="tipoDeInsumoOdorga" id="slctTipoInsOdroga" class="form-control" data-rule-required="true" data-msg-required="*">
									<option value="">No Precisa</option>
									<option>Heroína</option>
									<option>Cocaína</option>
									<option>Barbitúricos</option>
									<option>Metadona</option>
									<option>Ketamina</option>
									<option>Benzodiazopines</option>
									<option>Anfetaminas</option>
									<option>Buprenorfina</option>
									<option>Cannabis</option>
									<option>Disolventes</option>
									<option>4-MTA</option>
									<option>LSD</option>
									<option>Metilfenidato</option>
									<option>Esteroides anabolizantes</option>
									<option>GHB</option>
									<option>Éxtasis</option>
								</select>	
							</div>	
				       		<div class="form-group">
				          		<label >Peso Neto: </label>
				          		<label class="radio-inline">
			          				<input class="form-control" type="text" name="pesoNeto" id="txtPesoNeto" data-msg-number="Solo números" data-rule-number="true">
			          			</label>
			          			<label class="radio-inline">
				          			<select name="unidadDeMedidaNeto" id="" class="form-control">
				          				<option>Kg</option>
										<option>L</option>
				          			</select>
				          		</label>
				       		</div>
				       		<div class="form-group">
				          		<label >Peso Bruto: </label>
			          			<label class="radio-inline">
			          				<input class="form-control" type="text" name="pesoBruto" id="txtPesoBruto" data-msg-number="Solo números" data-rule-number="true">
			          			</label>
			          			<label class="radio-inline">
				          			<select name="unidadDeMedidaBruto" id="" class="form-control">
				          				<option>Kg</option>
										<option>L</option>
				          			</select>
			          			</label>
				       		</div>
				       		<div class="form-group">
				          		<label >Etiqueta: </label>
			          			<input class="form-control" type="text" name="etiquetaOembalaje" id="txtEtiqueta">
				       		</div>	
							<div class="form-group">
				          		<label >Valor Monetario: </label>
				          		<div class="input-prepend input-group">
				          			<span class="input-group-addon">S/.</span>
			          				<input class="form-control" type="text" name="valorMonetario" id="txtValorMonetario" data-rule-required="true" data-msg-required="*" data-msg-number="Solo números" data-rule-number="true">
			          			</div>
				       		</div>	
							<hr class="">
							<div class="well">
								<button class="btn btn-outline btn-success asignarComiso" id="btnRegistrarComiso" type="submit">
									<i class="fa fa-check"></i> Registrar Comiso
								</button>
								<button class="btn btn-outline btn-danger" type="reset">
									<i class="fa fa-refresh fa-fw"></i> Reset
								</button>
							</div>
						</form:form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
<!-- / MODAL -->
</div>