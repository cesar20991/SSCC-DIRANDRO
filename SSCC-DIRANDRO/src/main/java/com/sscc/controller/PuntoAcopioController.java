package com.sscc.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sscc.form.PuntoAcopioBean;
import com.sscc.model.PuntoAcopio;
import com.sscc.service.PuntoAcopioService;

@Controller
public class PuntoAcopioController {
	
	@Autowired
	PuntoAcopioService puntoAcopioServ;
	
	@RequestMapping(value="asignarAcopiosAcasos-{idCasoCriminal}", method= RequestMethod.POST)
	@ResponseBody
	public List<PuntoAcopioBean> asignarAcopiosAcasos(@ModelAttribute PuntoAcopio acopio,@PathVariable("idCasoCriminal") Integer idCasoCriminal, HttpServletRequest request, HttpSession session){
		List<PuntoAcopioBean> acopios = new ArrayList<PuntoAcopioBean>();
				
		if(puntoAcopioServ.guardarAcopio(acopio, session, idCasoCriminal)){
			acopios = puntoAcopioServ.getPuntoAcopiosBean(idCasoCriminal);
		}else{
			return null;
		}
		
		return acopios; 
	}

}
