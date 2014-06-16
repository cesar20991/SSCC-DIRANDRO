<script>
$(document).ready(function(){
	var nombre = '${pageContext.session.getAttribute("nombreDeUuario")}';
	$("#aNombreUsuario").empty();
	$("#aNombreUsuario").text(nombre);
	
	var url = '${pageContext.session.getAttribute("url")}';
	if(url != ''){
		$("#imagenUsu").append('<img src="'+url+'" style="float: right; width: 90px; height: 80px;" />');
	}else{
		$("#imagenUsu").append('<img src="img/skills.png" style="float: right; width: 90px; height: 80px;" />');
	}
	
	switch($("#nombreJsp").val()){
		case 'perfilPrincipal':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1><span class="colored">///</span> Perfil</h1>');
		break;
		case 'usuarioNuevo':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1><span class="colored">///</span> Crear Usuario</h1>');
		break;
		case 'sospechosoNuevo':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1><span class="colored">///</span> Crear Perfil del Sospechoso</h1>');
		break;
		case 'sospechosoPrincipal':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1><span class="colored">///</span> Perfil Sospechoso</h1>');
		break;
		case 'cambiarClave':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1><span class="colored">///</span> Cambiar Contraseña</h1>');
		break;
		case 'crearCaso':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1><span class="colored">///</span> Crear Caso Criminal</h1>');
		break;
		case 'buscarCasoCriminal':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1><span class="colored">///</span> Buscar Caso Criminal</h1>');
		break;
		case 'asignarCasoCriminal':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1><span class="colored">///</span> Asignar Caso Criminal</h1>');
		break;
		case 'asignarPersonalPolicial':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1><span class="colored">///</span> Asignar Personal Policial</h1>');
		break;
		case 'registrarBienInmueble':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1><span class="colored">///</span> Registrar Bien Inmueble</h1>');
		break;
		case 'registrarBienVehicular':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1><span class="colored">///</span> Registrar Bien Vehicular</h1>');
		break;

	}
});
</script>
<header>
	&nbsp;
	<div class="container">
		<div class="row">
			<div class="span4 logo">
				<a href="toPantallaPrincipal"><img src="img/logo.png" alt="logo"
					style="margin-bottom: 7px; margin-top: 7px;" /></a>
			</div>
			<div class="span8">
				<span id="imagenUsu"></span> 
				<span class="header_social"><span class="badge"><a href="toCambiarClave">Cambiar Contraseña</a></span>
				&nbsp;&nbsp;<span class="badge"><a href="toCrearUsuario">Crear Usuarios</a></span></br> 
				<span class="badge"><a id="aNombreUsuario" href="toPerfil">&nbsp;</a></span>&nbsp;&nbsp;
				<span class="badge"><a href="tologout">Cerrar Sesión</a></span></span>
			</div>
		</div>
	</div>
</header>
<!--WELCOME AREA-->
<input type="hidden"
	value="<%=request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().lastIndexOf(".") )%>"
	id="nombreJsp" />
<div class="gray_bg">
	<div class="container">
		<div class="row welcome" style="margin-top: 0px;" id="rowWelcome">
			<div class="span12" id="titulo">
				<h1>Sistema de Seguimiento de Casos Criminales para la DIRANDRO</h1>
				<!--  <p><em>otro texto</em></p> -->
			</div>
		</div>
	</div>
</div>
<!--/WELCOME AREA-->