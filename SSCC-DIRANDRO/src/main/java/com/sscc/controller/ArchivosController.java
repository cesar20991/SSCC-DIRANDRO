package com.sscc.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sscc.form.ArchivoBean;
import com.sscc.form.adjuntoBean;
import com.sscc.model.Archivo;
import com.sscc.service.ArchivosService;

@Controller
public class ArchivosController {

	@Autowired
	ArchivosService archivoServ;

	@RequestMapping(value="newArchivo", method= RequestMethod.POST)
	@ResponseBody
	public List<ArchivoBean> uploadFiles(@ModelAttribute adjuntoBean files, HttpServletRequest request, HttpServletResponse res){
		List<ArchivoBean> archivos = new ArrayList<ArchivoBean>();
		
		String tipoEntidad = request.getParameter("tipoEntidad");
		Integer idEntidad = Integer.parseInt(request.getParameter("idEntidad"));
		
		if(archivoServ.guardarArchivos(files, request, res, tipoEntidad, idEntidad)){
			archivos = archivoServ.getArchivosByEntidad(tipoEntidad, idEntidad);
		}
		
		return archivos;
	}
	
	@RequestMapping(value="getArchivos", method= RequestMethod.POST)
	@ResponseBody
	public List<ArchivoBean> getArchivos(HttpServletRequest request, HttpServletResponse res){
		List<ArchivoBean> archivos = new ArrayList<ArchivoBean>();
		
		String tipoEntidad = request.getParameter("tipoEntidad");
		Integer idEntidad = Integer.parseInt(request.getParameter("idEntidad"));
		
		archivos = archivoServ.getArchivosByEntidad(tipoEntidad, idEntidad);
		
		return archivos;
	}
	
	@RequestMapping(value="editarArchivo-{idArchivo}-{tipoEntidad}-{idEntidad}", method= RequestMethod.POST)
	@ResponseBody
	public List<ArchivoBean> editarArchivo(@ModelAttribute Archivo archivo,@PathVariable("idArchivo") Integer idArchivo,@PathVariable("tipoEntidad")String tipoEntidad,@PathVariable("idEntidad")Integer idEntidad,HttpServletRequest request, HttpServletResponse res){
		List<ArchivoBean> archivos = new ArrayList<ArchivoBean>();

		if(archivoServ.editarArchivo(archivo, idArchivo)){
			archivos = archivoServ.getArchivosByEntidad(tipoEntidad, idEntidad);
		}		
		
		return archivos;
	}
	
	@RequestMapping(value="separarArchivo-{idArchivo}-{tipoEntidad}-{idEntidad}", method= RequestMethod.POST)
	@ResponseBody
	public List<ArchivoBean> separarArchivo(@ModelAttribute Archivo archivo,@PathVariable("idArchivo") Integer idArchivo,@PathVariable("tipoEntidad")String tipoEntidad,@PathVariable("idEntidad")Integer idEntidad,HttpServletRequest request, HttpServletResponse res){
		List<ArchivoBean> archivos = new ArrayList<ArchivoBean>();

		if(archivoServ.separarArchivo(archivo, idArchivo)){
			archivos = archivoServ.getArchivosByEntidad(tipoEntidad, idEntidad);
		}		
		
		return archivos;
	}
}
