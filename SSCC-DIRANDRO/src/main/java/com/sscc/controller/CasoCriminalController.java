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

import com.sscc.form.CasoCriminalBean;
import com.sscc.model.CasoCriminal;
import com.sscc.service.CasoCriminalService;

@Controller
public class CasoCriminalController {
	
	@Autowired
	CasoCriminalService casoServ;
	
	@RequestMapping("toCrearCaso")
	public String toCrearCaso() {
		return "principal/crearCaso";
	}
	
	@RequestMapping(value = "crearCaso", method = RequestMethod.POST)
	public String crearSospechoso(@ModelAttribute CasoCriminal caso, HttpServletRequest req, HttpSession session, Model model){

		Integer idUsuario = (Integer) session.getAttribute("idUsuario");
		Integer id = casoServ.crearCasoCriminal(caso, idUsuario);
		
		return "redirect:toCasoCriminal-"+id;
	}
	
	@RequestMapping("toCasoCriminal-{idCaso}")
	public String toCrearUsuario(@PathVariable("idCaso") Integer idCaso, Model model) {
		List<CasoCriminalBean> c=new ArrayList<CasoCriminalBean>();
		CasoCriminalBean cb = new CasoCriminalBean();
		cb.setIdCasoCriminal(idCaso);
		c.add(cb);
		model.addAttribute("casoList",c);
		return "principal/casoCriminalPrincipal";
	}
	
	@RequestMapping(value = "getCaso-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public CasoCriminalBean getSopechoso(@PathVariable("idCaso") Integer idCaso){
		CasoCriminalBean casobean = new CasoCriminalBean();
		casobean = casoServ.getCasoCriminalBean(idCaso);
		return casobean;
	}

}
