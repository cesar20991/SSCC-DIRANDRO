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

import com.sscc.form.RutasBean;
import com.sscc.model.RutasMapas;
import com.sscc.service.RutasService;

@Controller
public class RutasController {
	
	@Autowired
	RutasService rutaServ;
	
	@RequestMapping(value="asignarRutasAcasos-{idCasoCriminal}", method= RequestMethod.POST)
	@ResponseBody
	public List<RutasBean> asignarRutasAcasos(@ModelAttribute RutasMapas ruta,@PathVariable("idCasoCriminal") Integer idCasoCriminal, HttpServletRequest request, HttpSession session){
		List<RutasBean> rutas = new ArrayList<RutasBean>();
				
		if(rutaServ.guardarRuta(ruta, session, idCasoCriminal)){
			rutas = rutaServ.getRutasBean(idCasoCriminal);
		}else{
			return null;
		}
		
		return rutas;
	}

}
