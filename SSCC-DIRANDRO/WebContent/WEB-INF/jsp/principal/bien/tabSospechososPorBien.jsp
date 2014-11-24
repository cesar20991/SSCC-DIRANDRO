<script>

$(document).ready(function(){
	$.ajax({
  		url: 'getSospechososBuscar',
  		type: 'post',
  		dataType: 'json',
  		data: '',
  		success: function(sospechosos){
  			// var a = '';
			 var resultado = '';
	  			$.each(sospechosos, function(i, sospechoso){
	  				resultado += '<tr>'+
					  				'<td><a href="toSospechosoPrincipal-'+sospechoso.idSospechoso+'"><img src="'+sospechoso.urlSospechoso+'" style="width: 100%; height: 100%;"/></a></td>'+
					                '<td>'+sospechoso.codigo+'</td>'+
					                '<td>'+sospechoso.alias+'</td>'+
					                '<td>'+sospechoso.codigoUnicoDeIdentificacion+'</td>'+
					                '<td>'+sospechoso.preNombres+'</td>'+
					                '<td>'+sospechoso.primerApellido+'</td>'+
					                '<td>'+sospechoso.SegundoApellido+'</td>'+
					                '<td>'+sospechoso.sexo+'</td>'+
					                '<td><button class="btn btn-outline btn-primary btn-circle asignar1" id="guardarAsigna_'+sospechoso.idSospechoso+'" type="button" data-dismiss="modal"><i class="fa fa-check"></i></button></td>'+
				                '</tr>';		            	
	  			});
	  		$("#tblSospechosoAsignar").append(resultado);
	  		$('#tblSospechosoAsignar').dataTable();
  		}
  	});
});
</script>
<div id="divSospechososAsignados">
	<div id="alertasMostrarSospechoso" style="display: none;">
	</div>
	<div id="divMostrarSospechosoAsignado">
		<div class="panel panel-default">
			<div class="panel-heading">
			/// Investigados Asignados:
				<div class="pull-right">
					<div class="btn-group">
						<button class="btn btn-outline btn-primary btn-sm asignar1" type="button" id="btnAgregarSospechosoNuevo" data-toggle="modal" data-target="#modalSospechoso"><i class="fa fa-edit fa-fw"></i> Agregar Sospechoso Nuevo</button>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<div id="divMostrarSospechosos">
					<div class="table-responsive">
			       		<div id="divSospechososAsignadosTabla">
			       			
			       		</div>
			       	</div>
				</div>
			</div>
		</div>
	</div>
	<!-- MODAL -->
	<div class="modal fade" id="modalSospechoso" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
       <div class="modal-dialog">
           <div class="modal-content" style="width: 200%; margin-left: -50%;">
               <div class="modal-header">
                   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                   <h4 class="modal-title" id="myModalLabel">Sospechosos: </h4>
                   <input type="hidden" id="hdnIdCasoSeleccionado"/>
               </div>
               <div class="modal-body">
               <div id="alertasModalAsignar" style="display: none;">
				</div>
                   <div class="table-responsive">
			       		<div id="divResultadoSearch" class="dataTables_wrapper form-inline" role="grid">
			       			<table class="table table-striped table-bordered table-hover dataTable" id="tblSospechosoAsignar">
				  					<thead>
					  					<tr>
					  						<th>foto</th>
					  						<th>Código</th>
					  						<th>Alias</th>
					  						<th>DNI</th>
					  						<th>Nombres</th>
					  						<th>Apellido Paterno</th>
					  						<th>Apellido Materno</th>
					  						<th>Sexo</th>
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
</div>