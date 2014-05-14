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
		String path="";
		
		SospechosoBean sb = sospechosoServ.crearSospechoso(sospechoso);
		List<SospechosoBean> s=new ArrayList<SospechosoBean>();
		s.add(sb);
		model.addAttribute("perfilList",sb);
		path="principal/sospechosoPrincipal";
		return path;
	}
}
