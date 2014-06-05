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
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="js/jquery.js"></script>
<!-- menu -->
<script src="js/bootstrap-collapse.js"></script>
<!-- alertas de colores -->
<script src="js/bootstrap-alert.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
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
					<a href="index-2.html"><img src="img/logo.png" alt="logo"
						style="margin-bottom: 7px; margin-top: 7px;" /></a>
				</div>
			</div>
		</div>
	</header>
	<!--WELCOME AREA-->
	<div class="gray_bg">
		<div class="container">
			<div class="row welcome" style="margin-top: 0px;">
				<div class="span12">
					<h1>Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h1>
					<!--  <p><em>otro texto</em></p> -->
				</div>
			</div>
		</div>
	</div>
	<!--/WELCOME AREA-->
	<!--/HEADER-->
	<!--MAIN CONTENT AREA-->
	<div class="container inner_content">
		<!-- MENU 
	<jsp:include page="componentes/menu.jsp"/>
	/MENU -->
		<!-- FORMUALARIO -->
		<div class="span9 columns" style="margin-left: 0px;">
			<section class="content">
				<div class="container">
					<div class="well well-white span5" style="width: 350px;">
						<form:form id="frmLogin" action="login" method="post" commandName="user">
							<div class="row-fluid">
								<div class="span12">
									<h3>
										<span class="colored">///</span> Login
									</h3>
									<div class="block-side-note simple small">
										<p class="bold"></p>
									</div>
								</div>
							</div>
							<div class="row-fluid block-login">
								<div class="span12">
									<label class="control-label">Correo Electrónico:</label>
									<input class="error span3" name="correoElectronico" type="text" placeholder="ejemplo@correo.com" autofocus="autofocus"><label class="error" for="email"></label> 
									<label class="control-label">Contraseña:</label>
									<input class="error span3" name="contrasena" type="password" placeholder="contraseña"><label class="error" for="password"></label>
								</div>
							</div>
							<div class="row-fluid">
								<div class="span6">
									<input id="" name="btnLogin" value="Login" class="btn btn-success" type="submit">
								</div>
								<div class="span4 text-center-vertical">
									<p>
										<a href="#">Forgot Password?</a>
									</p>
								</div>
							</div>
							<div class="alert alert-error" style="display: none;" id="alertaError">
								<a class="close" data-dismiss="alert">×</a> 
								<strong><span id="spnMensaje"><c:out value="${msg}" /></span></strong>
							</div>
						</form:form>
					</div>
				</div>
			</section>
		</div>
		<!-- /FORMUALARIO -->
	</div>
	<!--/MAIN CONTENT AREA-->


	<!-- sticky footer -->
	<jsp:include page="componentes/footer.jsp" />
	<!-- /sticky footer -->
</body>
</html>
