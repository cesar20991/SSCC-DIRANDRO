<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SSCC - DIRANDRO</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<!-- para que funcione el jquery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<!-- para que funcione el jquery de la plantilla -->
<script src="js/jquery.js"></script>
<!-- para el menu -->
<script src="js/bootstrap-collapse.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
</head>
<body>
	<!--HEADER-->
	<jsp:include page="../componentes/header.jsp" />
	<!--/HEADER-->
	<!--CENTRO-->
	<!--MENU-->
	<jsp:include page="../componentes/menu.jsp" />
	<!--/MENU-->
	<div class="container inner_content">
		<section class="span5" style="margin-left: 80px;">
			<table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th colspan="4">Casos Criminales</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="1"><span class="colored">0</span></td>
						<td colspan="3">Activo</td>
					</tr>
					<tr>
						<td colspan="1"><span class="colored">0</span></td>
						<td colspan="3">Diligencias Preliminares</td>
					</tr>
					<tr>
						<td colspan="1"><span class="colored">0</span></td>
						<td colspan="3">Calificacion Fiscal</td>
					</tr>
					<tr>
						<td colspan="1"><span class="colored">0</span></td>
						<td colspan="3">Fiscalia Superior</td>
					</tr>
					<tr>
						<td colspan="1"><span class="colored">0</span></td>
						<td colspan="3">Formalizacion de la Investigacion</td>
					</tr>
					<tr>
						<td colspan="1"><span class="colored">0</span></td>
						<td colspan="3">Diligencias de la Investigacion</td>
					</tr>
					<tr>
						<td colspan="1"><span class="colored">0</span></td>
						<td colspan="3">Conclusion de la Investigacion</td>
					</tr>
					<tr>
						<td colspan="1"><span class="colored">0</span></td>
						<td colspan="3">Pausa por Falta de Documentos</td>
					</tr>
					<tr>
						<td colspan="1"><span class="colored">0</span></td>
						<td colspan="3">Pausa por Nuevo Caso</td>
					</tr>
					<tr>
						<td colspan="1"><span class="colored">0</span></td>
						<td colspan="3">Plazo Ampleatorio Investigacion Preliminar</td>
					</tr>
					<tr>
						<td colspan="1"><span class="colored">0</span></td>
						<td colspan="3">Plazo Ampleatorio Investigacion Formal</td>
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
				<tbody>
					<tr>
						<td>Caso CC0001-20/04/2014</td>
					</tr>
				</tbody>
			</table>
		</section>
	</div>
	<!--/CENTRO-->
	<!-- sticky footer -->
	<jsp:include page="../componentes/footer.jsp" />
	<!-- /sticky footer -->
</body>
</html>