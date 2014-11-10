<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Buscar Vehiculo</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

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
  		url: 'getVehiculosBuscar',
  		type: 'post',
  		dataType: 'json',
  		data: '',
  		success: function(vehiculos){
			 var resultado = '';
	  			$.each(vehiculos, function(i, vehiculo){
	  				 resultado += '<tr>'+
				                    '<td><a href="toVehiculo-'+vehiculo.idVehiculo+'"><img src="'+vehiculo.urlVehiculo+'" alt="foto" style="width: 90px; height: 120px;"/></a></td>'+
				                    '<td>'+vehiculo.codigo+'</td>'+
				                    '<td>'+vehiculo.partidaRegistral+'</td>'+
				                    '<td>'+vehiculo.valor+'</td>'+
				                    '<td>'+vehiculo.descripcion+'</td>'+
				                    '<td>'+vehiculo.altura+'</td>'+
				                    '<td>'+vehiculo.ancho+'</td>'+
				                    '<td>'+vehiculo.longitud+'</td>'+
				                    '<td>'+vehiculo.pesoBruto+'</td>'+
				                    '<td>'+vehiculo.pesoNeto+'</td>'+
				                    '<td>'+vehiculo.placa+'</td>'+
				                    '<td>'+vehiculo.marca+'</td>'+
				                    '<td>'+vehiculo.modelo+'</td>'+
				                    '<td>'+vehiculo.chasis+'</td>'+
				                    '<td>'+vehiculo.motor+'</td>'+
				                    '<td>'+vehiculo.ruedas+'</td>'+
				                    '<td>'+vehiculo.ejes+'</td>'+
				                    '<td>'+vehiculo.pasajeros+'</td>'+
				                    '<td>'+vehiculo.asientos+'</td>'+
				                    '<td>'+vehiculo.color+'</td>'+
				                    '<td>'+vehiculo.fecFabricacion+'</td>'+
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
	<!--CENTRO-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
	    	<div class="col-lg-12" id="titulo">
	        	<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
	       	</div>
	       	<div id="divScroll" style="overflow-x: scroll; width: 98%;">
		       	<div class="table-responsive">
		       		<div id="divResultadoSearch" class="dataTables_wrapper form-inline" role="grid">
		       			<table class="table table-striped table-bordered table-hover dataTable" id="dataTablesPersonal">
			  					<thead>
				  					<tr>
				  						<th>Imagen</th>
				  						<th>Código</th>
				  						<th>partida Registral</th>
				  						<th>(S/.) Valor</th>
				  						<th>Descripcion</th>
				  						<th>Altura</th>
				  						<th>Ancho</th>
				  						<th>Longitud</th>
				  						<th>Peso Bruto</th>
				  						<th>Peso Neto</th>
				  						<th>Placa</th>
				  						<th>Marca</th>
				  						<th>Modelo</th>
				  						<th>Chasis</th>
				  						<th>Motor</th>
				  						<th># Ruedas</th>
				  						<th># Ejes</th>
				  						<th># Pasajeros</th>
				  						<th># Asientos</th>
				  						<th>Color</th>
				  						<th>Fecha de Fabricacion</th>
				  					</tr>
			  					</thead>
		           		</table>
		       		</div>
		       	</div>
	       	</div>
	    </div>
	</div>
	<!--/CENTRO-->
</div>
</body>
</html>