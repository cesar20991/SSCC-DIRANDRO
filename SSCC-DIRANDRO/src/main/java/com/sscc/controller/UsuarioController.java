package com.sscc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sscc.model.Usuario;
import com.sscc.service.UsuarioService;


@Controller
public class UsuarioController {
	
	@Autowired
	UsuarioService usuarioServ;
	
	@RequestMapping("toLogin")
	public String toLogin() {
		return "login";
	}
	
	@RequestMapping("tologout")
	public String tologout(HttpServletRequest request, HttpSession session){
		session = request.getSession();
		session.invalidate();
		return "login";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.GET)
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
	
	@RequestMapping("toPantallaPrincipal")
	public String toPantallaPrincipal() {
		return "principal/pantallaPrincipal";
	}

}
