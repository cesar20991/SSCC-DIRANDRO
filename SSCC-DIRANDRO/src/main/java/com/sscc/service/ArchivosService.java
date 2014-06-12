package com.sscc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sscc.form.CasoCriminalBean;
import com.sscc.form.adjuntoBean;
import com.sscc.model.Archivo;

public interface ArchivosService {

	List<Archivo> guardarArchivos(adjuntoBean files, HttpServletRequest request, HttpServletResponse res, String tipoEntidad, Integer idEntidad);
	
	List<Archivo> getArchivosByEntidad(String tipoEntidad, Integer idEntidad);
	
}
