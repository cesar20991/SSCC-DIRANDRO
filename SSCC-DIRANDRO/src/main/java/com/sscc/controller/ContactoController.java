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

import com.sscc.form.ContactoBean;
import com.sscc.model.Contactos;
import com.sscc.service.ContactoService;

@Controller
public class ContactoController {
	
	@Autowired
	ContactoService contactoServ;

	@RequestMapping(value = "getContactos-{idSospechoso}", method = RequestMethod.POST)
	@ResponseBody
	public List<ContactoBean> getContactos(@PathVariable("idSospechoso") Integer idSospechoso){
		return contactoServ.getContactoPorSospechoso(idSospechoso);
	}
	
	@RequestMapping(value = "crearContacto", method = RequestMethod.POST)
	@ResponseBody
	public List<ContactoBean> crearContacto(@ModelAttribute Contactos contacto, HttpServletRequest req){
		String sospechoso = req.getParameter("idSospechosoAux");
		if(contactoServ.crearContacto(contacto,Integer.parseInt(sospechoso))){
			return getContactos(Integer.parseInt(sospechoso));
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "editarContacto", method = RequestMethod.POST)
	@ResponseBody
	public List<ContactoBean> editarContacto(@ModelAttribute Contactos contacto, HttpServletRequest req){
		String sospechoso = req.getParameter("idSospechosoAux");
		if(contactoServ.editarContacto(contacto)){
			return getContactos(Integer.parseInt(sospechoso));
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "quitarContacto-{idSospechoso}-{idContacto}", method = RequestMethod.POST)
	@ResponseBody
	public List<ContactoBean> quitarContacto(@PathVariable("idSospechoso") Integer idSospechoso,@PathVariable("idContacto") Integer idContacto){
		
		if(contactoServ.quitarContacto(idSospechoso,idContacto)){
			return getContactos(idSospechoso);
		}else{
			return null;
		}
		
	}
}
