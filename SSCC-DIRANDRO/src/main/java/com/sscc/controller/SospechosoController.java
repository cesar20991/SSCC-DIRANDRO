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
import com.sscc.form.SospechosoBean;
import com.sscc.model.Sospechoso;
import com.sscc.service.SospechosoService;

@Controller
public class SospechosoController {
	
	@Autowired
	SospechosoService sospechosoServ;
	
	@RequestMapping("toCrearSospechoso")
	public String toCrearSospechoso() {
		return "principal/sospechosoNuevo";
	}
	////
	@RequestMapping(value = "crearSospechoso", method = RequestMethod.POST)
	public String crearSospechoso(@ModelAttribute Sospechoso sospechoso, HttpServletRequest req, HttpSession session, Model model){

		Integer sb = sospechosoServ.crearSospechoso(sospechoso);
		
		return "redirect:toSospechosoPrincipal-"+sb;
	}
	
	@RequestMapping("toSospechosoPrincipal-{idSospechoso}")
	public String toCrearUsuario(@PathVariable("idSospechoso") Integer idSospechoso, Model model) {
		List<SospechosoBean> s=new ArrayList<SospechosoBean>();
		SospechosoBean sb = new SospechosoBean();
		sb.setIdSospechoso(idSospechoso);
		s.add(sb);
		model.addAttribute("sospechosoList",s);
		return "principal/sospechosoPrincipal";
	}
	
	@RequestMapping(value = "getSopechoso-{idSospechoso}", method = RequestMethod.POST)
	@ResponseBody
	public SospechosoBean getSopechoso(@PathVariable("idSospechoso") Integer idSospechoso){
		SospechosoBean sospechosobean = new SospechosoBean();
		sospechosobean = sospechosoServ.getSospechosoBean(idSospechoso);
		return sospechosobean;
	}
	
	@RequestMapping(value = "editarSopechoso", method = RequestMethod.POST)
	@ResponseBody
	public SospechosoBean editarSopechoso(@ModelAttribute Sospechoso sospechoso, HttpServletRequest req, HttpSession session, Model model){
		SospechosoBean sospechosobean = new SospechosoBean();
		sospechosobean = sospechosoServ.EditSospechosoBean(sospechoso);
		return sospechosobean;
	}
}
