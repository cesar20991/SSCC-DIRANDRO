<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SSCC - DIRANDRO</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<!-- styles -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
<link href="css/plugins/timeline.css" rel="stylesheet">
<link href="css/sb-admin-2.css" rel="stylesheet">
<link href="css/plugins/morris.css" rel="stylesheet">
<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- js -->
<script src="js/jquery-1.11.0.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/plugins/metisMenu/metisMenu.min.js"></script>
<script src="js/sb-admin-2.js"></script>

<!-- para que funcione el jquery
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> -->
<!-- para que funcione el jquery de la plantilla 
<script src="js/jquery.js"></script>-->
<!-- para el menu 
<script src="js/bootstrap-collapse.js"></script>-->
<!-- styles 
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />-->
<script>

var CRStates = "";
var listCRs="";

$(document).ready(function(e){
	
	
	/*GET INIT CASOS CRIMINALES*/
  	$.ajax({
 		url: 'getStatusList',
 		type: 'post',
 		dataType: 'json',
 		data: '',
 		success: function(CRs){ 			
 			
 			CRStates = ["Activo",
							"Diligencias Preliminares",
							"Calificacion Fiscald",
							"Fiscalia Superior",
							"Formalizacion de la Investigacion",
							"Diligencias de la Investigacion",
							"Conclusion de la Investigacion",
							"Pausa por Falta de Documentos",
							"Pausa por Nuevo Caso",
							"Plazo Ampleatorio Investigacion Preliminar",
							"Plazo Ampleatorio Investigacion Formal"];
 			listCRs = CRs;
 			for(var i = 0; i < CRStates.length; i++){
 				$('#CRNumber'+i).empty(); 				
 				if(CRs[i].split('-')[1] == 'id'){
 					$('#CRNumber'+i).text('1');
 					$('.CRLink'+i).attr('href', 'toCasoCriminal-'+CRs[i].split('-')[0]); //cambiar Link
 				}else{
 					$('#CRNumber'+i).text(CRs[i]);
 					$('.CRLink'+i).attr('href', 'toSearchCR-'+CRStates[i]); // Cambiar Link
 				}
 				
 			}
			
 		},
 	    error: function(textStatus){
 		    //alert("ERROR");
 		}
 	});
  	
  	/*GET INIT LAST CASOS CRIMINALES*/
  	$.ajax({
  		url: 'getLastCasosCriminales',
  		type: 'post',
  		dataType: 'json',
  		data: '',
  		success: function(messages){
  			$.each(messages, function(i, message){
				$("#notificationListBox").append(
						'<tr> '+						
						'<td><a href="toCasoCriminal-'+message.idCasoCriminal+'">'+message.codigo+'</a></td>'+
						'</tr>');
  			});
  		}
  	});
});


</script>
</head>
<body>
	
	<!--CENTRO-->
	<!--MENU
	<jsp:include page="../componentes/menu.jsp" />
	MENU-->
<div id="wrapper">
	<!--HEADER-->
		<jsp:include page="../componentes/newHeader.jsp" />
	<!--/HEADER-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
	    	<div class="col-lg-12" id="titulo">
	        	<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
	       	</div>
	       	<div class="col-lg-6">
		       	<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th colspan="4">Casos Criminales</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="1"><a class="CRLink0"><span id="CRNumber0">0</span></a></td>
							<td colspan="3"><a class="CRLink0">Activo</a></td>
						</tr>
						<tr>
							<td colspan="1"><a class="CRLink1"><span id="CRNumber1">0</span></a></td>
							<td colspan="3"><a class="CRLink1">Diligencias Preliminares</a></td>
						</tr>
						<tr>
							<td colspan="1"><a class="CRLink2"><span id="CRNumber2">0</span></a></td>
							<td colspan="3"><a class="CRLink2">Calificacion Fiscal</a></td>
						</tr>
						<tr>
							<td colspan="1"><a class="CRLink3"><span id="CRNumber3">0</span></a></td>
							<td colspan="3"><a class="CRLink3">Fiscalia Superior</a></td>
						</tr>
						<tr>
							<td colspan="1"><a class="SRLink4"><span id="SRNumber4">0</span></a></td>
							<td colspan="3"><a class="SRLink4">Formalizacion de la Investigacion</a></td>
						</tr>
						<tr>
							<td colspan="1"><a class="CRLink5"><span id="CRNumber5">0</span></a></td>
							<td colspan="3"><a class="CRLink5">Diligencias de la Investigacion</a></td>
						</tr>
						<tr>
							<td colspan="1"><a class="CRLink6"><span id="CRNumber6">0</span></a></td>
							<td colspan="3"><a class="CRLink6">Conclusion de la Investigacion</a></td>
						</tr>
						<tr>
							<td colspan="1"><a class="CRLink7"><span id="CRNumber7">0</span></a></td>
							<td colspan="3"><a class="CRLink7">Pausa por Falta de Documentos</a></td>
						</tr>
						<tr>
							<td colspan="1"><a class="CRLink8"><span id="CRNumber8">0</span></a></td>
							<td colspan="3"><a class="CRLink8">Pausa por Nuevo Caso</a></td>
						</tr>
						<tr>
							<td colspan="1"><a class="CRLink9"><span id="CRNumber9">0</span></a></td>
							<td colspan="3"><a class="CRLink9">Plazo Ampleatorio Investigacion Preliminar</a></td>
						</tr>
						<tr>
							<td colspan="1"><a class="CRLink10"><span id="CRNumber10">0</span></a></td>
							<td colspan="3"><a class="CRLink10">Plazo Ampleatorio Investigacion Formal</a></td>
						</tr>
					</tbody>
				</table>
	       	</div>
	       	<div class="col-lg-6">
	       		<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th colspan="4">Ultimos Casos Criminales</th>
						</tr>
					</thead>
					<tbody id="notificationListBox">
						
					</tbody>
				</table>
	       	</div>
	            <!-- /.col-lg-12 -->
	     </div>
	        <!-- /.row -->
	</div>
</div>
	
	
	<!-- <div class="container inner_content">
		<section class="span5" style="margin-left: 80px;">
			<table class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th colspan="4">Casos Criminales</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="1"><a class="CRLink0"><span id="CRNumber0">0</span></a></td>
						<td colspan="3"><a class="CRLink0">Activo</a></td>
					</tr>
					<tr>
						<td colspan="1"><a class="CRLink1"><span id="CRNumber1">0</span></a></td>
						<td colspan="3"><a class="CRLink1">Diligencias Preliminares</a></td>
					</tr>
					<tr>
						<td colspan="1"><a class="CRLink2"><span id="CRNumber2">0</span></a></td>
						<td colspan="3"><a class="CRLink2">Calificacion Fiscal</a></td>
					</tr>
					<tr>
						<td colspan="1"><a class="CRLink3"><span id="CRNumber3">0</span></a></td>
						<td colspan="3"><a class="CRLink3">Fiscalia Superior</a></td>
					</tr>
					<tr>
						<td colspan="1"><a class="SRLink4"><span id="SRNumber4">0</span></a></td>
						<td colspan="3"><a class="SRLink4">Formalizacion de la Investigacion</a></td>
					</tr>
					<tr>
						<td colspan="1"><a class="CRLink5"><span id="CRNumber5">0</span></a></td>
						<td colspan="3"><a class="CRLink5">Diligencias de la Investigacion</a></td>
					</tr>
					<tr>
						<td colspan="1"><a class="CRLink6"><span id="CRNumber6">0</span></a></td>
						<td colspan="3"><a class="CRLink6">Conclusion de la Investigacion</a></td>
					</tr>
					<tr>
						<td colspan="1"><a class="CRLink7"><span id="CRNumber7">0</span></a></td>
						<td colspan="3"><a class="CRLink7">Pausa por Falta de Documentos</a></td>
					</tr>
					<tr>
						<td colspan="1"><a class="CRLink8"><span id="CRNumber8">0</span></a></td>
						<td colspan="3"><a class="CRLink8">Pausa por Nuevo Caso</a></td>
					</tr>
					<tr>
						<td colspan="1"><a class="CRLink9"><span id="CRNumber9">0</span></a></td>
						<td colspan="3"><a class="CRLink9">Plazo Ampleatorio Investigacion Preliminar</a></td>
					</tr>
					<tr>
						<td colspan="1"><a class="CRLink10"><span id="CRNumber10">0</span></a></td>
						<td colspan="3"><a class="CRLink10">Plazo Ampleatorio Investigacion Formal</a></td>
					</tr>
				</tbody>
			</table>
		</section>
		<section class="span4" style="margin-left: 45px;">
			<table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th colspan="4">Ultimos Casos Criminales</th>
					</tr>
				</thead>
				<tbody id="notificationListBox">
					
				</tbody>
			</table>
		</section>
	</div> -->
	<!--/CENTRO-->
	<!-- sticky footer
	<jsp:include page="../componentes/footer.jsp" />
	sticky footer -->
</body>
</html>