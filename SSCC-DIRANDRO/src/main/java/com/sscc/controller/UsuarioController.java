package com.sscc.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sscc.form.PerfilBean;
import com.sscc.model.Perfil;
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
	
	@RequestMapping(value = "crearUsuario", method = RequestMethod.POST)
	//@ResponseBody
	public String welcome(@ModelAttribute Perfil perfil, HttpServletRequest req, HttpSession session, Model model){
		String path = "";
		
		String correo = req.getParameter("correo");
		
		PerfilBean pf = perfilServ.crearUsuario(perfil, correo);
		List<PerfilBean> p = new ArrayList<PerfilBean>();
		p.add(pf);
		model.addAttribute("perfilList", p);
		path = "principal/perfilPrincipal";

		return path;
	}

}
