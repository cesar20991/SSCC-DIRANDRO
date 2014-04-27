package com.sscc.controller;

import java.util.ArrayList;
import java.util.List;

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

import com.sscc.form.PerfilBean;
import com.sscc.model.Perfil;
import com.sscc.service.PerfilService;

@Controller
public class PerfilController {
	
	@Autowired
	PerfilService perfilServ;

	@RequestMapping("toPerfil")
	public String toPerfil() {
		return "principal/perfilPrincipal";
	}
	
	@RequestMapping("toCrearUsuario")
	public String toCrearUsuario() {
		return "principal/usuarioNuevo";
	}
	
	@RequestMapping(value = "getPerfil-{idPerfil}", method = RequestMethod.POST)
	@ResponseBody
	public PerfilBean getAllAssetsPropertyAjax(@PathVariable("idPerfil") Integer idperfil){
		//Changes by Ce
		PerfilBean perfilbean = new PerfilBean();
		perfilbean = perfilServ.getPerfil(idperfil);
		return perfilbean;
	}
	
	@RequestMapping(value = "crearUsuario", method = RequestMethod.POST)
	public String crearUsuario(@ModelAttribute Perfil perfil, HttpServletRequest req, HttpSession session, Model model){
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
