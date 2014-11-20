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

import com.sscc.form.MuebleBean;
import com.sscc.service.MuebleService;

@Controller
public class MuebleController {
	
	@Autowired
	MuebleService muebleServ;

//	@RequestMapping(value = "registrarMueble-{idSospechoso}", method = RequestMethod.POST)
//	@ResponseBody
//	public Boolean registrarMueble(@ModelAttribute MuebleBean muebleBean,@PathVariable("idSospechoso")Integer idSospechoso, HttpServletRequest req, HttpSession session, Model model){
//		
//		Integer idMueble = muebleServ.registrarMueble(muebleBean, idSospechoso);		
//		if(idMueble != 0){
//			return true;
//		}else{
//			return false;
//		}
//	}
	
	
	
}
