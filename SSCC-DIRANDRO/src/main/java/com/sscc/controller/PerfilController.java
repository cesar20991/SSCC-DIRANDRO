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
	
	@RequestMapping("toCambiarClave")
	public String toCambiarClave() {
		return "principal/cambiarClave";
	}
	
	@RequestMapping(value = "getPerfil-{idPerfil}", method = RequestMethod.POST)
	@ResponseBody
	public PerfilBean getPerfil(@PathVariable("idPerfil") Integer idperfil){
		PerfilBean perfilbean = new PerfilBean();
		perfilbean = perfilServ.getPerfil(idperfil);
		return perfilbean;
	}
	
	@RequestMapping(value = "crearUsuario", method = RequestMethod.POST)
	public String crearUsuario(@ModelAttribute Perfil perfil, HttpServletRequest req, HttpSession session, Model model){
		String correo = req.getParameter("correo");
		
		PerfilBean pf = perfilServ.crearUsuario(perfil, correo);
		

		return "redirect:toPerfil-"+pf.getIdPerfil();
	}
	
	@RequestMapping("toPerfil-{idPerfil}")
	public String toCrearUsuario(@PathVariable("idPerfil") Integer idPerfil, Model model) {
		List<PerfilBean> p = new ArrayList<PerfilBean>();
		PerfilBean pf = new PerfilBean();
		pf.setIdPerfil(idPerfil);
		p.add(pf);
		model.addAttribute("perfilList", p);
		return "principal/perfilPrincipal";
	}
	
	@RequestMapping(value = "getJefesDeUnidad", method = RequestMethod.POST)
	@ResponseBody
	public List<PerfilBean> getJefesDeUnidad(){
		List<PerfilBean> perfilbean = new ArrayList<PerfilBean>();
		perfilbean = perfilServ.getJefesDeUnidad();
		return perfilbean;
	}
	
	@RequestMapping(value = "getPersonalPolicial", method = RequestMethod.POST)
	@ResponseBody
	public List<PerfilBean> getPersonalPolicial(){
		List<PerfilBean> perfilbean = new ArrayList<PerfilBean>();
		perfilbean = perfilServ.getPersonalPolicial();
		return perfilbean;
	}
	@RequestMapping(value = "getJefeAsignado-{idCasoCriminal}", method = RequestMethod.POST)
	@ResponseBody
	public PerfilBean getJefesPorCaso(@PathVariable("idCasoCriminal") Integer idCasoCriminal){
		PerfilBean perfilbean = new PerfilBean();
		perfilbean = perfilServ.getJefesPorCaso(idCasoCriminal);
		return perfilbean;
	}
	//este se usa en el jsp asignar personal no muestra a los jefes de unidad
	@RequestMapping(value = "getPersonalPolicialPorCaso-{idCasoCriminal}", method = RequestMethod.POST)
	@ResponseBody
	public List<PerfilBean> getPersonalPolicialPorCaso(@PathVariable("idCasoCriminal") Integer idCasoCriminal){
		List<PerfilBean> perfilbean = new ArrayList<PerfilBean>();
		perfilbean = perfilServ.getPersonalPolicialPorCaso(idCasoCriminal);
		return perfilbean;
	}
	//este se usa la pagina del caso
	@RequestMapping(value = "getPersonalAsignado-{idCasoCriminal}", method = RequestMethod.POST)
	@ResponseBody
	public List<PerfilBean> getPersonalAsignado(@PathVariable("idCasoCriminal") Integer idCasoCriminal){
		List<PerfilBean> perfilbean = new ArrayList<PerfilBean>();
		perfilbean = perfilServ.getPersonalPolicial(idCasoCriminal);
		return perfilbean;
	}
	//Validaciones_Perfil:
	@RequestMapping(value = "getDni-{dni}", method = RequestMethod.POST)
	@ResponseBody
	public Boolean getDni(@PathVariable("dni") Integer dni){
		if(perfilServ.getDni(dni)){
			return true;
		}else{
			return false;
		}
	}
	@RequestMapping(value = "getNumeroCarnet-{numeroDeCarnet}", method = RequestMethod.POST)
	@ResponseBody
	public Boolean getNumeroCarnet(@PathVariable("numeroDeCarnet") Integer numeroDeCarnet){
		if(perfilServ.getNumeroCarnet(numeroDeCarnet)){
			return true;
		}else{
			return false;
		}
	}
}