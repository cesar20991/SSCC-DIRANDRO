<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - Login Page</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- jquery -->
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="js/jquery.js"></script> -->
<!-- menu -->
<!-- <script src="js/bootstrap-collapse.js"></script> -->
<!-- alertas de colores -->
<!-- <script src="js/bootstrap-alert.js"></script> -->
<!-- styles -->
<!-- <link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" / -->
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

<!-- validar -->
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>

<script>
$(document).ready(function(){
	if($("#spnMensaje").text() != ''){
		$("#alertaError").show();
	}else{
		$("#alertaError").hide();
	}
});
</script>
<style>
label.error {
	margin-left: 10px;
	width: auto;
	display: inline;
	color: rgb(255, 0, 0);
	font-weight: bold;
}
</style>
</head>

<body class="login">
	<!--HEADER-->
	<header>
		<div class="container">
			<div class="row">
				<div class="span4 logo">
					<a href="index-2.html"><img src="img/logo.png" alt="logo" style="width: 40%; height: 20%"/></a>
				</div>
			</div>
		</div>
	</header>
	<!--WELCOME AREA-->
	<div class="gray_bg">
		<div class="container">
			<div class="row welcome" style="margin-top: 0px;">
				<div class="span12">
					<h3 class="page-header">Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h3>
					<!--  <p><em>otro texto</em></p> -->
				</div>
			</div>
		</div>
	</div>
	<!--/WELCOME AREA-->
	<!--/HEADER-->
	<!--MAIN CONTENT AREA-->
		<!-- FORMUALARIO -->
		<div class="container">
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<div class="login-panel panel panel-default">
						
							<div class="panel-heading">
								<h3 class="panel-title">
									Login
								</h3>
								<!-- <div class="block-side-note simple small">
									<p class="bold"></p>
								</div> -->
							</div>
							<div class="panel-body">
								<form:form id="frmLogin" action="login" method="post" commandName="user">
									<fieldset>
										<div class="form-group">
											<label>Correo Electrónico:</label>
											<input class="form-control" name="correoElectronico" type="text" placeholder="ejemplo@correo.com" autofocus="autofocus"><label class="error" for="email"></label>
										</div>									 
										<div>
											<label class="control-label">Contraseña:</label>
											<input class="form-control" name="contrasena" type="password" placeholder="contraseña"><label class="error" for="password"></label>
										</div>
										<input name="btnLogin" value="Login" class="btn btn-success" type="submit">
										<a href="#">Forgot Password?</a>
									</fieldset>									
								</form:form>
							</div>
						
						<div class="alert alert-error" style="display: none;" id="alertaError">
							<a class="close" data-dismiss="alert">×</a> 
							<strong><span id="spnMensaje"><c:out value="${msg}" /></span></strong>
						</div>						
					</div>
				</div>
			</div>
		</div>
		<!-- /FORMUALARIO -->
	<!--/MAIN CONTENT AREA-->


	<!-- sticky footer -->
	<!-- /sticky footer -->
</body>
</html>
