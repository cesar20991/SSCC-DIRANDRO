package com.sscc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sscc.form.PerfilBean;
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
	
}
