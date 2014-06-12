package com.sscc.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sscc.form.adjuntoBean;
import com.sscc.model.Archivo;
import com.sscc.service.ArchivosService;

@Controller
public class ArchivosController {

	@Autowired
	ArchivosService archivoServ;

	//momentaneo para probar
	@RequestMapping(value="newArchivo", method= RequestMethod.POST)
	@ResponseBody
	public List<Archivo> uploadFiles(@ModelAttribute adjuntoBean files, HttpServletRequest request, HttpServletResponse res){
		List<Archivo> archivos = new ArrayList<Archivo>();
		
		String tipoEntidad = request.getParameter("tipoEntidad");
		Integer idEntidad = Integer.parseInt(request.getParameter("idEntidad"));
		
		archivos = archivoServ.guardarArchivos(files, request, res, tipoEntidad, idEntidad);
		return archivos;
	}
}
