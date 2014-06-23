package com.sscc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sscc.form.ArchivoBean;
import com.sscc.form.adjuntoBean;
import com.sscc.model.Archivo;

public interface ArchivosService {

	Boolean guardarArchivos(adjuntoBean files, HttpServletRequest request, HttpServletResponse res, String tipoEntidad, Integer idEntidad);
	
	List<ArchivoBean> getArchivosByEntidad(String tipoEntidad, Integer idEntidad);
	
	Boolean editarArchivo(Archivo archivo, Integer idArchivo);
	
	Boolean separarArchivo(Archivo archivo, Integer idArchivo);
	
	Boolean asignarArchivo(String url, Integer idEntidad, HttpSession session);
	
	Boolean asignarArchivoSospechoso(String url, Integer idEntidad, HttpSession session);
}
