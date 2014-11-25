<script>
$(document).ready(function(){
	var nombre = '${pageContext.session.getAttribute("nombreDeUuario")}';
	$("#aNombreUsuario").empty();
	$("#aNombreUsuario").text(nombre);
	
	var url = '${pageContext.session.getAttribute("url")}';
	if(url != ''){
		$("#imagenUsu").append('<img src="'+url+'" style="width: 20%; height: 20%;"/>');
	}else{
		$("#imagenUsu").append('<img src="img/skills.png" style="width: 20%; height: 20%;"/>');
	}
	
	switch($("#nombreJsp").val()){
		case 'perfilPrincipal':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Perfil</h1>');
		break;
		case 'usuarioNuevo':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Crear Usuario</h1>');
		break;
		case 'sospechosoNuevo':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Crear Perfil del Investigado</h1>');
		break;
		case 'sospechosoPrincipal':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Perfil Investigado</h1>');
		break;
		case 'cambiarClave':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Cambiar Contraseña</h1>');
		break;
		case 'crearCaso':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Crear Caso Criminal</h1>');
		break;
		case 'buscarCasoCriminal':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Buscar Caso Criminal</h1>');
		break;
		case 'asignarCasoCriminal':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Asignar Caso Criminal</h1>');
		break;
		case 'asignarPersonalPolicial':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Asignar Personal Policial</h1>');
		break;
		case 'registrarBienInmueble':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Registrar Bien Inmueble</h1>');
		break;
		case 'registrarBienVehicular':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Registrar Bien Vehicular</h1>');
		break;
		case 'buscarPersonalPolicial':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Buscar Personal Policial</h1>');
		break;
		case 'buscarSospechosos':
			$("#rowWelcome").removeClass('welcome');
			$("#rowWelcome").addClass('welcome_inner');
			$("#titulo").empty();
			$("#titulo").append('<h1 class="page-header"><span class="colored">///</span> Buscar Investigado</h1>');
		break;
	}
});
</script>
<input type="hidden" value="<%=request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().lastIndexOf(".") )%>" id="nombreJsp"/>
<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a href="toPantallaPrincipal"><img src="img/logo.png" alt="logo" style="width: 40%; height: 20%"/></a>
    </div>
    <!-- /.navbar-header -->

    <ul class="nav navbar-top-links navbar-right">
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <span id="imagenUsu"></span> 
                <i class="fa fa-caret-down"></i>
            </a>
            <ul class="dropdown-menu dropdown-user">
                <li><a id="aNombreUsuario" href="toPerfil">&nbsp;</a></li>
                <li><a href="toCambiarClave"><i class="fa fa-wrench fa-fw"></i> Cambiar Contraseña</a></li>
                <li><a href="toCrearUsuario"><i class="fa fa-user fa-fw"></i> Crear Usuarios</a></li>
                <li class="divider"></li>
                <li><a href="tologout"><i class="fa fa-sign-out fa-fw"></i>Cerrar Sesión</a>
                </li>
            </ul>
            <!-- /.dropdown-user -->
        </li>
        <!-- /.dropdown -->
    </ul>
    <!-- /.navbar-top-links -->
  
<!-- navbar-static-side -->
    <div class="navbar-default sidebar" role="navigation" id="menuBar">
        <div class="sidebar-nav navbar-collapse">
            <ul class="nav" id="side-menu">
                <li class="sidebar-search">
                    <!-- /input-group -->
                </li>
                <li>
                    <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Casos Criminales<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li>
                            <a href="toCrearCaso">Crear Caso Criminal</a>
                        </li>
                        <li>
                            <a href="toBuscarCaso">Buscar Caso Criminal</a>
                        </li>
                        <li>
                        	<a href="toAsignarCaso">Asignar Caso Criminal</a>
                        </li>
                    </ul>
                    <!-- /.nav-second-level -->
                </li>
                <li>
                    <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Personal Policial<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li>
                            <a href="toBuscarPersonal">Buscar Personal Policial</a>
                        </li>
                        <li>
                            <a href="toAsignarPersonal">Asignar Personal Policial</a>
                        </li>
                    </ul>
                    <!-- /.nav-second-level -->
                </li>
                <li>
                    <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Puntos de Acopio<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li>
                            <a href="#">Buscar Punto de Acopio</a>
                        </li>
                        <li>
                            <a href="#">Crear Punto de Acopio</a>
                        </li>
                    </ul>
                    <!-- /.nav-second-level -->
                </li>
                <li>
                    <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Rutas<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li>
                            <a href="#">Buscar Rutas</a>
                        </li>
                    </ul>
                    <!-- /.nav-second-level -->
                </li>
                <li>
                    <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Investigado<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li>
                            <a href="toCrearSospechoso">Crear Perfil de Investigado</a>
                        </li>
                        <li>
                            <a href="toBuscarSospechosos">Buscar Investigados</a>
                        </li>
                    </ul>
                    <!-- /.nav-second-level -->
                </li>
                <!-- <li>
                    <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Graficos Estadisticos<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li>
                            <a href="#">Consultar Graficos Estadisticos</a>
                        </li>
                    </ul>
                    /.nav-second-level
                </li> -->
                <li>
                    <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Bienes<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                    	<li>
                            <a href="#">Inmueble <span class="fa arrow"></span></a>
                            <ul class="nav nav-third-level collapse" style="">
                                <li>
                                    <a href="toRegistrarInmueble">Registrar Bien Inmueble</a>
                                </li>
                                <li>
                                    <a href="toBuscarInmueble">Buscar Bien Inmueble</a>
                                </li>
                            </ul>
                            <!-- /.nav-third-level -->
                        </li>
                        <li>
                            <a href="#">Vehiculo <span class="fa arrow"></span></a>
                            <ul class="nav nav-third-level collapse" style="">
                                <li>
                                    <a href="toRegistrarVehiculo">Registrar Bien Vehicular</a>
                                </li>
                                <li>
                                    <a href="toBuscarVehiculo">Buscar Bien Vehicular</a>
                                </li>
                            </ul>
                            <!-- /.nav-third-level -->
                        </li>
                        <li>
                       		 <a href="#">Mueble <span class="fa arrow"></span></a>
                            <ul class="nav nav-third-level collapse" style="">
                                <li>
                                    <a href="toBuscarMueble">Buscar Mueble</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <!-- /.nav-second-level -->
                </li>
            </ul>
        </div>
        <!-- /.sidebar-collapse -->
    </div>
    <!-- /.navbar-static-side -->
</nav>