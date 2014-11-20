<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">

	$(document).on('click','.asignar', function(e){
		var id1 = (this.id).split("_")[0];
		var id2 = (this.id).split("_")[1];
		var id3 = (this.id).split("_")[2];
		
		switch(id1){
			case 'cancelarAsignaBien':
				var respuesta = confirm('¿Esta seguro que desea quitar este bien?');
				if(respuesta){
					$.ajax({
				 		url: 'desAsignarBienToSospechoso-'+$("#hdnIdSospechoso").text()+"-"+id2,
				 		type: 'post',
				 		dataType: 'json',
				 		data: '',
				 		success: function(bienes){
				 			initBienesAsignado(bienes);
				 		}
				 	});
				}			
			break;
			case 'guardarAsigna':
				if(id2 == 'In'){
					$.ajax({
				 		url: 'asignarInmuebleToSospechoso-'+$("#hdnIdSospechoso").text()+"-"+id3,
				 		type: 'post',
				 		dataType: 'json',
				 		data: '',
				 		success: function(bienes){
				 			if(bienes == true){
				 				$("#divResultadoInmueble").empty();
					 			initInmuebles();				 				
				 			}
				 		}
				 	});
	 			}else if(id2 == 'Ve'){
	 				$.ajax({
				 		url: 'asignarVehiculoToSospechoso-'+$("#hdnIdSospechoso").text()+"-"+id3,
				 		type: 'post',
				 		dataType: 'json',
				 		data: '',
				 		success: function(bienes){
				 			if(bienes == true){
				 				$("#divResultadoVehiculo").empty();
					 			initVehiculos();
				 			}
				 		}
				 	});
	 			}
				
			break;
		}
		
	});
	$(document).on('click','.asignarMueble', function(e){
		$.ajax({
	 		url: 'registrarMueble-'+$("#hdnIdSospechoso").text(),
	 		type: 'post',
	 		dataType: 'json',
	 		data: $('#formRegistrarMueble').serialize(),
	 		success: function(bienes){
	 			$("#divResultadoMueble").empty();
	 			initMuebles();
	 			
	 		}
	 	});
	})
	
	
	$(document).on('click','.desasignar', function(e){
		var id2 = (this.id).split("_")[1];
		var id3 = (this.id).split("_")[2];
		if(id2 == 'Mue'){
			$.ajax({
		 		url: 'desasignarMuebleToSospechoso-'+$("#hdnIdSospechoso").text()+"-"+id3,
		 		type: 'post',
		 		dataType: 'json',
		 		data: '',
		 		success: function(bienes){
		 			if(bienes == true){
		 				$("#divResultadoMueble").empty();
		 				initMuebles();		
		 			}
		 		}
		 	});
		}else{
			$.ajax({
		 		url: 'desasignarInmuebleToSospechoso-'+$("#hdnIdSospechoso").text()+"-"+id3,
		 		type: 'post',
		 		dataType: 'json',
		 		data: '',
		 		success: function(bienes){
		 			if(bienes == true){
		 				if(id2 == 'In'){
		 					$("#divResultadoInmueble").empty();
		 					initInmuebles();
		 				}else if(id2 == 'Ve'){
		 					$("#divResultadoVehiculo").empty();
		 					initVehiculos();
		 				}
			 							 				
		 			}
		 		}
		 	});
		}
		
	})
	
	function initInmuebles(){
		$.ajax({
	 		url: 'getInmueblesPorSospechoso-'+$("#hdnIdSospechoso").text(),
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(bienes){
	 			var resultado = '';
	 				resultado +='<table class="table table-striped table-bordered table-hover dataTable" id="tblIniInmueble">'+
	 								'<thead>'+
		 								'<tr>'+
		 									'<th>foto</th>'+
		 									'<th>Código</th>'+
		 									'<th>Partida Registral</th>'+
		 									'<th>Descripción</th>'+
		 									'<th>Valor</th>'+
		 									'<th>AreaTotal</th>'+
		 									'<th>Acción</th>'+
		 								'</tr>'+
		 							'</thead>';
	 			$.each(bienes, function(i, bien){
	 				resultado +='<tr>'+
	 		  						'<td><a href="toInmueble-'+bien.idInmueble+'"><img src="'+bien.urlInmueble+'" style="width: 90px; height: 120px;" alt="foto Inmueble"/></a></td>'+
	 		  						'<td><a href="toInmueble-'+bien.idInmueble+'">'+bien.codigo+'</a></td>'+
	 		  						'<td>'+bien.partidaRegistral+'</td>'+
	 		  						'<td>'+bien.descripcion+'</td>'+
	 		  						'<td>'+bien.valor+'</td>'+
	 		  						'<td>'+bien.areaTotal+'</td>'+
	 		  						'<td><button type="button" class="btn btn-outline btn-danger btn-xs btn-circle desasignar" id="desasignar_In_'+bien.idBien+'"><i class="fa fa-minus"></i></button></td>'+
	 		  					'</tr>';
	 			});
	 			
	 			resultado +='</table>';
	 			$("#divResultadoInmueble").append(resultado);
	 			$('#tblIniInmueble').dataTable();  				
	 		}
	 	});
	}
	
	function initVehiculos(){
		$.ajax({
	 		url: 'getVehiculosPorSospechoso-'+$("#hdnIdSospechoso").text(),
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(bienes){
	 			var resultado = '';
	 			
	 				resultado +='<table class="table table-striped table-bordered table-hover dataTable" id="tblIniVehiculo">'+
	 					  					'<thead>'+
	 						  					'<tr>'+
	 						  						'<th>foto</th>'+
	 						  						'<th>Código</th>'+
	 						  						'<th>Partida Registral</th>'+
	 						  						'<th>Marca</th>'+
	 						  						'<th>Modelo</th>'+
	 						  						'<th>Descripción</th>'+
	 						  						'<th>Valor</th>'+
	 						  						'<th>Acción</th>'+
	 						  					'</tr>'+
	 					  					'</thead>';
	 			$.each(bienes, function(i, bien){
	 				resultado +='<tr>'+
	 		  						'<td><a href="toVehiculo-'+bien.idVehiculo+'"><img style="width: 90px; height: 120px;" src="'+bien.urlVehiculo+'" alt="foto Vehiculo"/></a></td>'+
	 		  						'<td><a href="toVehiculo-'+bien.idVehiculo+'">'+bien.codigo+'</a></td>'+
	 		  						'<td>'+bien.partidaRegistral+'</td>'+
	 		  						'<td>'+bien.marca+'</td>'+
	 		  						'<td>'+bien.modelo+'</td>'+
	 		  						'<td>'+bien.descripcion+'</td>'+
	 		  						'<td>'+bien.valor+'</td>'+
	 		  						'<td><button type="button" class="btn btn-outline btn-danger btn-xs btn-circle desasignar" id="desasignar_Ve_'+bien.idBien+'"><i class="fa fa-minus"></i></button></td>'+
	 		  					'</tr>';
	 			});
	 			resultado +='</table>';
	 			$("#divResultadoVehiculo").append(resultado);
	 			$('#tblIniVehiculo').dataTable(); 
	 		}
	 	});
	}
	
	$(document).ready(function(){
		
		initInmuebles();
		
		initVehiculos();
		
		$.ajax({
			url : 'getInmueblesBuscar',
			type : 'post',
			dataType : 'json',
			data : '',
			success : function(bienes) {
				initAsignaIBienes(bienes);
			}
		});
		
		$.ajax({
			url : 'getVehiculosBuscar',
			type : 'post',
			dataType : 'json',
			data : '',
			success : function(bienes) {
				initAsignaVBienes(bienes);
			}
		});
		
		initMuebles();
		
		$("#hdnIdSospechoso_").val($("#hdnIdSospechoso").text());
		
	});
	
	function initMuebles(){
		$.ajax({
			url : 'getBienesMuebles-'+$("#hdnIdSospechoso").text(),
			type : 'post',
			dataType : 'json',
			data : '',
			success : function(bienes) {
				var resultado = '';
				resultado +='<table class="table table-striped table-bordered table-hover dataTable" id="tblIniMueble">'+
								'<thead>'+
			  					'<tr>'+
			  						'<th>Código</th>'+
			  						'<th>Descripción</th>'+
			  						'<th>Valor</th>'+
			  						'<th>Tipo</th>'+
			  						'<th>Especificación Tipo</th>'+
			  						'<th>Estado Conservación</th>'+
			  						'<th>Acción</th>'+
			  					'</tr>'+
								'</thead><tbody>';
								$.each(bienes, function(i, bien){
									resultado +='<tr>'+
													'<th>'+bien.codigo+'</th>'+
							  						'<th>'+bien.descripcion+'</th>'+
							  						'<th>'+bien.valor+'</th>'+
							  						'<th>'+bien.tipo+'</th>'+
							  						'<th>'+bien.especificarTipo+'</th>'+
							  						'<th>'+bien.estadoDeConservasion+'</th>'+
							  						'<td><button type="button" class="btn btn-outline btn-danger btn-xs btn-circle desasignar" id="desasignar_Mue_'+bien.idMueble+'"><i class="fa fa-minus"></i></button></td>'+
						 		  				'</tr>';
								});
								resultado +='</tbody></table>';
								$("#divResultadoMueble").append(resultado);
								$("#tblIniMueble").dataTable();
			}
		});
	}
	

	function initAsignaIBienes(bienes,opcion){
		
		var resultado = '';
		$.each(bienes, function(i, bien){
			resultado +='<tr>'+
	  						'<td><a href="toInmueble-'+bien.idInmueble+'"><img src="'+bien.urlInmueble+'" style="width: 90px; height: 120px;" alt="foto Inmueble"/></a></td>'+
	  						'<td><a href="toInmueble-'+bien.idInmueble+'">'+bien.codigo+'</a></td>'+
	  						'<td>'+bien.partidaRegistral+'</td>'+
	  						'<td>'+bien.descripcion+'</td>'+
	  						'<td>'+bien.valor+'</td>'+
	  						'<td>'+bien.areaTotal+'</td>'+
	  						'<td><button type="button" class="btn btn-outline btn-primary btn-circle asignar" id="guardarAsigna_In_'+bien.idBien+'" data-dismiss="modal"><i class="fa fa-check"></i></button></td>'+
	  					'</tr>';
		});
		
		$("#tblInmueble").append(resultado);
		$('#tblInmueble').dataTable(); 
	}
	
	function initAsignaVBienes(bienes,opcion){
		var resultado = '';
		$.each(bienes, function(i, bien){
			resultado +='<tr>'+
	  						'<td><a href="toVehiculo-'+bien.idVehiculo+'"><img style="width: 90px; height: 120px;" src="'+bien.urlVehiculo+'" alt="foto Vehiculo"/></a></td>'+
	  						'<td><a href="toVehiculo-'+bien.idVehiculo+'">'+bien.codigo+'</a></td>'+
	  						'<td>'+bien.partidaRegistral+'</td>'+
	  						'<td>'+bien.marca+'</td>'+
	  						'<td>'+bien.modelo+'</td>'+
	  						'<td>'+bien.descripcion+'</td>'+
	  						'<td>'+bien.valor+'</td>'+
	  						'<td><button type="button" class="btn btn-outline btn-primary btn-circle asignar" id="guardarAsigna_Ve_'+bien.idBien+'" data-dismiss="modal"><i class="fa fa-check"></i></button></td>'+
	  					'</tr>';
		});
		$("#tblVehiculo").append(resultado);
		$('#tblVehiculo').dataTable(); 
	}
	
</script>
	<!-- Bienes Asignados -->
	<div id="divBienesAsignados">
		<div id="alertasMostrarBien" style="display: none;"></div>
		<div id="divMostrarBienesAsignados">
			<div class="panel panel-default">
				<div class="panel-heading">
		          /// Bienes asignados al sospechoso:
		          	<div class="pull-right">
						<div class="btn-group">
							<button class="btn btn-outline btn-primary btn-sm asignar" data-toggle="modal" data-target="#modalInmueble" type="button"><i class="fa fa-edit fa-fw"></i> Asignar Bien Inmueble</button>
							<button class="btn btn-outline btn-primary btn-sm asignar" data-toggle="modal" data-target="#modalVehiculo" type="button"><i class="fa fa-edit fa-fw"></i> Asignar Bien Vehicular</button>
							<!-- <button class="btn btn-outline btn-primary btn-sm asignar" data-toggle="modal" data-target="#modalBienes" type="button" id="btnAsignarBien"><i class="fa fa-edit fa-fw"></i> Asignar Bien Mueble</button> -->
							<button class="btn btn-outline btn-primary btn-sm asignar" data-toggle="modal" data-target="#modalCrearMueble" type="button"><i class="fa fa-edit fa-fw"></i> Crear Bien Mueble</button>
						</div>
					</div>
		      </div>
		      <div class="panel-body">
		      		<div id="divMostrarBienes">
						<div class="panel panel-default">
							<div class="panel-heading">
								/// Bienes Inmuebles
							</div>
							<div class="panel-body" id="mostrarInmuebles">
								<div class="table-responsive">
			       					<div id="divResultadoInmueble" class="dataTables_wrapper form-inline" role="grid">
			       					
			       					</div>
			       				</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								/// Bienes Vehiculares
							</div>
							<div class="panel-body" id="mostrarVehiculos">
								<div class="table-responsive">
			       					<div id="divResultadoVehiculo" class="dataTables_wrapper form-inline" role="grid">
			       					
			       					</div>
			       				</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								/// Bienes Muebles
							</div>
							<div class="panel-body" id="mostrarMuebles">
								<div class="table-responsive">
						       		<div id="divResultadoMueble" class="dataTables_wrapper form-inline" role="grid">
						       			
						       		</div>
						       	</div>
							</div>
						</div>
					</div>
		      </div>
			</div>
		</div>
	</div>
	
	<!-- MODAL -->
	<div class="modal fade" id="modalInmueble" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
       <div class="modal-dialog">
           <div class="modal-content" style="width: 200%; margin-left: -50%;">
               <div class="modal-header">
                   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                   <h4 class="modal-title" id="myModalLabel">Bienes</h4>
                   <input type="hidden" id="hdnIdCasoSeleccionado"/>
               </div>
               <div class="modal-body">
                   <div class="table-responsive">
			       		<div id="divResultadoInmueble" class="dataTables_wrapper form-inline" role="grid">
			       			<table class="table table-striped table-bordered table-hover dataTable" id="tblInmueble">
				  					<thead>
					  					<tr>
					  						<th>foto</th>
					  						<th>Código</th>
					  						<th>Partida Registral</th>
					  						<th>Descripción</th>
					  						<th>Valor</th>
					  						<th>AreaTotal</th>
					  						<th>Asignar</th>
					  					</tr>
				  					</thead>
			           		</table>
			       		</div>
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

<!-- MODAL Vehiculo -->
	<div class="modal fade" id="modalVehiculo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
       <div class="modal-dialog">
           <div class="modal-content" style="width: 200%; margin-left: -50%;">
               <div class="modal-header">
                   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                   <h4 class="modal-title" id="myModalLabel">Bienes</h4>
                   <input type="hidden" id="hdnIdCasoSeleccionado"/>
               </div>
               <div class="modal-body">
                   <div class="table-responsive">
			       		<div id="divResultadoInmueble" class="dataTables_wrapper form-inline" role="grid">
			       			<table class="table table-striped table-bordered table-hover dataTable" id="tblVehiculo">
				  					<thead>
					  					<tr>
					  						<th>foto</th>
					  						<th>Código</th>
					  						<th>Partida Registral</th>
					  						<th>Marca</th>
					  						<th>Modelo</th>
					  						<th>Descripción</th>
					  						<th>Valor</th>
					  						<th>Asignar</th>
					  					</tr>
				  					</thead>
			           		</table>
			       		</div>
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
	
	
		<!-- MODAL BIEN MUEBLE-->
	<div class="modal fade" id="modalCrearMueble" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content" style="width: 200%; margin-left: -50%;">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">Bien Mueble</h4>
					<input type="hidden" id="hdnIdCasoSeleccionado" />
				</div>
				<div class="modal-body">
					<div class="panel-body">
						<form:form class="form-horizontal" id="formRegistrarMueble" commandName="mueble">
							<div class="form-group">
								<label>Tipo: </label> <select name="tipo" id="txtTipo" class="form-control">
									<option value="">Seleccione</option>
									<option value="Joyas">Joyas</option>
									<option value="Electrodomesticos">Electrodomesticos</option>
									<option value="Máquinarias y Equipos Industriales">Máquinarias y Equipos Industriales</option>
									<option value="Árticulos de hogas">Árticulos de hogas</option>
									<option value="Equipos de Cómputo">Equipos de Cómputo</option>
									<option value="Equipos de Comunicación">Equipos de Comunicación</option>
									<option value="Obras de Arte">Obras de Arte</option>
									<option value="Piedras y metales preciosos">Piedras y metales preciosos</option>
								</select>	
							</div>	
							<div class="form-group">
				          		<label >Valor Monetario: </label>
			          			<div class="input-prepend input-group">
				          			<span class="input-group-addon">S/.</span>
			          				<input class="form-control" type="text" name="valor"  id="txtValor" >
			          			</div>
				       		</div>	       		
				       		<div class="form-group">
				          		<label >Descripcion: </label>
				          		<textarea class="form-control" rows="3" name="descripcion" id="txtDescripcion" maxlength="250" ></textarea>
				       		</div>
				       		<div class="form-group" id="divATotal">
				          		<label >Especificar Tipo: </label>
			          			<div class="input-append input-group">
			          				<input class="form-control" type="text" name="especificarTipo" id="txtEspecificarTipo" >
			          			</div>
				       		</div>
				       		<div class="form-group" id="divACercado">
				          		<label >Estado de conservación: </label>
			          			<select name="estadoDeConservasion" id="txtestadoDeConservasion" data-rule-required="true" >
									<option value="Bueno">Bueno</option>
									<option value="Regular">Regular</option>
									<option value="Inservible">Inservible</option>
									<option value="Inoperativo">Inoperativo</option>
								</select>
				       		</div>	
							<hr class="">
							<div class="well">
								<button class="btn btn-outline btn-success asignarMueble" id="btnRegistrarMueble" type="button">
									<i class="fa fa-check"></i> Registrar Mueble
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
