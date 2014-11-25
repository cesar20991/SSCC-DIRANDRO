package com.sscc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sscc.form.ComisoBean;
import com.sscc.form.SospechosoBean;
import com.sscc.model.Comiso;
import com.sscc.service.ComisoService;

@Controller
public class ComisoController {
	
	@Autowired
	ComisoService comisoServ;

	@RequestMapping(value = "getComisosDelCaso-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public List<ComisoBean> getComisosDelCaso(@PathVariable("idCaso") Integer idCaso){
		return comisoServ.getComisosDelCaso(idCaso);
	}
	
	@RequestMapping(value = "crearComiso", method = RequestMethod.POST)
	@ResponseBody
	public List<ComisoBean> crearContacto(@ModelAttribute Comiso comiso, HttpServletRequest req){
		String caso = req.getParameter("hdnIdCasoAux");
		if(comisoServ.crearComiso(comiso,Integer.parseInt(caso))){
			return getComisosDelCaso(Integer.parseInt(caso));
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "quitarComiso-{idCaso}-{idComiso}", method = RequestMethod.POST)
	@ResponseBody
	public List<ComisoBean> quitarComiso(@PathVariable("idCaso") Integer idCaso,@PathVariable("idComiso") Integer idComiso){
		if(comisoServ.quitarComiso(idCaso, idComiso)){
			return getComisosDelCaso(idCaso);
		}else{
			return null;
		}
	}
	
}
