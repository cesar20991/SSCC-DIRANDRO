<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SSCC - DIRANDRO - Buscar Personal</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">


<!-- js -->
<script src="js/jquery-1.11.0.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/plugins/metisMenu/metisMenu.min.js"></script>
<script src="js/plugins/dataTables/jquery.dataTables.js"></script>
<script src="js/plugins/dataTables/dataTables.bootstrap.js"></script>
<script src="js/sb-admin-2.js"></script>

<!-- styles -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
<link href="css/plugins/dataTables.bootstrap.css" rel="stylesheet">
<link href="css/plugins/timeline.css" rel="stylesheet">
<link href="css/sb-admin-2.css" rel="stylesheet">
<link href="css/plugins/morris.css" rel="stylesheet">
<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<script>

$(document).ready(function(e){
	
	$.ajax({
  		url: 'getPersonalPolicialBuscar',
  		type: 'post',
  		dataType: 'json',
  		data: '',
  		success: function(agentes){
  			// var a = '';
			 var resultado = '';
			 
	  			$.each(agentes, function(i, agente){
	  				resultado += '<tr>'+
					  				'<td><img src="'+agente.urlPerfil+'" style="width: 100%; height: 100%;"/></td>'+
					                '<td><a href="toPerfil-'+agente.idPerfil+'"><span id="spnNombre_'+agente.idUsuario+'">'+agente.nombreCompleto+'</span></a></td>'+
					                '<td>'+agente.dni+'</td>'+
					                '<td>'+agente.numeroDeCarnet+'</td>'+
					                '<td>'+agente.cargo+'</td>'+
					                '<td>'+agente.grado+'</td>'+
					                '<td>'+agente.rango+'</td>'+
					                '<td>'+agente.entidadPerteneciente+'</td>'+
					                '<td>'+agente.correoElectronico+'</td>'+
					                '<td>'+agente.telefono+'</td>'+
					                '<td>'+agente.sexo+'</td>'+
					                '<td>'+agente.casoAsignado+'</td>'+
				                '</tr>';		            	
	  			});
	  		$("#dataTablesPersonal").append(resultado);
	  		$('#dataTablesPersonal').dataTable();
  		}
  	});  	
	
	
});

</script>
</head>
<body>

<div id="wrapper">
	<!--HEADER-->
		<jsp:include page="../componentes/newHeader.jsp" />
	<!--/HEADER-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
	    	<div class="col-lg-12" id="titulo">
	        	<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
	       	</div>
	       	<div class="table-responsive">
	       		<div id="divResultadoSearch" class="dataTables_wrapper form-inline" role="grid">
	       			<table class="table table-striped table-bordered table-hover dataTable" id="dataTablesPersonal">
		  					<thead>
			  					<tr>
			  						<th>foto</th>
			  						<th>Nombre</th>
			  						<th>DNI</th>
			  						<th>N° CIP</th>
			  						<th>Cargo</th>
			  						<th>Grado</th>
			  						<th>Jerarquia</th>
			  						<th>Entidad Perteneciente</th>
			  						<th>Corre Electrónico</th>
			  						<th>Teléfono</th>
			  						<th>Sexo</th>
			  						<th>Caso Asignado</th>
			  					</tr>
		  					</thead>
	  					<!-- <tbody id="tbodyResultado">
	  					</tbody> -->
	           		</table>
	       		</div>
	       	</div>
	     </div>
	        <!-- /.row -->
	</div>
</div>
	
</body>
</html>