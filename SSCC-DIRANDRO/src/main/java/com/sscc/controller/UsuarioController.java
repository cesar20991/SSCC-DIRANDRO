package com.sscc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sscc.model.Usuario;
import com.sscc.service.PerfilService;
import com.sscc.service.UsuarioService;


@Controller
public class UsuarioController {
	
	@Autowired
	UsuarioService usuarioServ;
	
	@Autowired
	PerfilService perfilServ;
	
	@RequestMapping("toLogin")
	public String toLogin() {
		return "login";
	}
	
	@RequestMapping("toUpload")
	public String toUpload() {
		return "uploadFiles";
	}
	
	@RequestMapping("toMap")
	public String toMap() {
		return "mapasEjemplo";
	}
	@RequestMapping("toRutas")
	public String toRutas() {
		return "rutasMapas";
	}
	
	@RequestMapping("tologout")
	public String tologout(HttpServletRequest request, HttpSession session){
		session = request.getSession();
		session.invalidate();
		return "login";
	}

	@RequestMapping("toPantallaPrincipal")
	public String toPantallaPrincipal() {
		return "principal/pantallaPrincipal";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String welcome(@ModelAttribute Usuario usuario, HttpServletRequest req, HttpSession session, Model model){
		String path = "";
		
		if(usuarioServ.login(usuario, req.getSession())) {
			path = "principal/pantallaPrincipal";
		}else{
			model.addAttribute("msg", "Estos datos no son correctos");
			path = "login";
		}

		return path;
	}
	
	@RequestMapping(value = "cambiarClave", method = RequestMethod.POST)
	@ResponseBody
	public Boolean cambiarClave(HttpServletRequest req, HttpSession session){
		
		String claveA = req.getParameter("txtClaveActual");
		String claveN = req.getParameter("txtClaveNueva");
		Integer idUsuario = (Integer) session.getAttribute("idUsuario");

		Boolean resultado = usuarioServ.cambiarClave(claveA, claveN, idUsuario);
		
		return resultado;
	}
	//Validaciones_Usuario:
	@RequestMapping(value = "getCorreo-{correoElectronico}", method = RequestMethod.POST)
	@ResponseBody
	public Boolean getCorreo(@PathVariable("correoElectronico") String correoElectronico){
		if(usuarioServ.getCorreo(correoElectronico)){
			return true;
		}else{
			return false;
		}
	}
	
}
