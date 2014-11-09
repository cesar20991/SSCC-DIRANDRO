<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>SSCC - DIRANDRO - Principal</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

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
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<script src="js/formatDates.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>

</head>
<script type="text/javascript">
var tipoEntidad = "usuario";
var idEntidad = '';
	/*if($("#hdnIdPerfil").text() != ""){
		idEntidad = $("#hdnIdPerfil").text();
	}else{
		idEntidad = '${pageContext.session.getAttribute("idPerfil")}';
	}*/
</script>
<body>
<div id="wrapper">
	<!--HEADER-->
	<jsp:include page="../componentes/newHeader.jsp" />
	<!--/HEADER-->
	<!--CENTRO-->
	<div id="page-wrapper" style="min-height: 393px;">
		<div class="row">
			<c:forEach items="${perfilList}" var="perfil">
				<span id="hdnIdPerfil" style="display: none;"><c:out value="${perfil.idPerfil}" /></span>
				<span id="hdnEntidad" style="display: none;"><c:out value="${perfil.entidadPerteneciente}"/></span>
			</c:forEach>
			<div class="col-lg-12" id="titulo">
				<h2 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h2>
			</div>			
			<div class="col-lg-12">
				<table class="table table-striped table-bordered table-hover">
					<tbody>
						<tr>
							<td>Nombre Completo:</td>
							<td align="center"><span id="hdrPrimerNombe"></span>&nbsp;<span id="hdrSegundoNombe"></span>&nbsp;<span id="hdrApePaterno"></span>&nbsp;<span id="hdrApeMaterno"></span></td>
							<td>Codigo de Usuario:</td>
							<td><span id="hdrCodigo"></span></td>
							<td rowspan="4" align="center" style="width: 10%; height: 50%;" id="tdImagen"></td>
						</tr>
						<tr>
							<td id="tdCargo">Cargo:</td>
							<td><span id="hdrCargo">&nbsp;</span></td>
							<td id="tdGrado">Grado:</td>
							<td id="tdGradoResult"><span id="hdrGrado"></span></td>
						</tr>
						<tr>
							<td>Número de DNI:</td>
							<td><span id="hdrDni">&nbsp;</span></td>
							<td id="tdNCarnet">N° Carnet:</td>
							<td id="tdNCarnetResult"><span id="hdrNCarnet"></span></td>
						</tr>
						<tr>
							<td>Correo Electrónico:</td>
							<td><span id="hdrCorreo">&nbsp;</span></td>
							<td>Entidad:</td>
							<td><span id="hdrEntidad"></span></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-lg-12">
				<ul class="nav nav-tabs">
	                <li class="active"><a href="#liPrincipal" data-toggle="tab">Principal</a></li>
	                <li class=""><a href="#liArchivosAdjuntos" data-toggle="tab">Archivos Adjuntos</a></li>
	                <li class=""><a href="#liComentarios" data-toggle="tab">Comentarios</a></li>
	            </ul>
	            <div class="tab-content">
	            	<div class="tab-pane fade active in" id="liPrincipal">
                        <!-- <h4>Home Tab</h4> -->
                        <jsp:include page="perfil/tabPrincipalPerfil.jsp" />
                    </div>
                    <div class="tab-pane fade" id="liArchivosAdjuntos">
                        <!-- <h4>Home Tab</h4> -->
                        <jsp:include page="../componentes/archivos.jsp" />
                    </div>
                    <div class="tab-pane fade" id="liComentarios">
                        <!-- <h4>Home Tab</h4> -->
                        <jsp:include page="../componentes/tabComentarios.jsp" />
                    </div>
	            </div>
			</div>
		</div>
	</div>
	<!-- /CENTRO -->
</div>
	
	<!--CENTRO-->

	<%-- <div class="container inner_content">
		<c:forEach items="${perfilList}" var="perfil">
			<span id="hdnIdPerfil" style="display: none;"><c:out value="${perfil.idPerfil}" /></span>
			<span id="hdnEntidad" style="display: none;"><c:out value="${perfil.entidadPerteneciente}" /></span>
		</c:forEach>
		<section class="span9" style="margin-left: 80px;">
			
		</section>
		<section class="span9" style="margin-left: 80px;">
			<div class="tabbable" style="margin-bottom: 9px;">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#1" data-toggle="tab">Principal</a></li>
					<li class=""><a href="#2" data-toggle="tab">Archivos Adjuntos</a></li>
					<li class=""><a href="#3" data-toggle="tab">Comentarios</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="1">
						
					</div>
					<div class="tab-pane" id="2">
						<jsp:include page="../componentes/archivos.jsp" />
					</div>
					<div class="tab-pane" id="3">
						<jsp:include page="../componentes/tabComentarios.jsp" />
					</div>
				</div>
			</div>
		</section>
	</div> --%>
	<!--/CENTRO-->

</body>
</html>