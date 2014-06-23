package com.sscc.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.sscc.form.ComentarioBean;
import com.sscc.model.Comentario;

public interface ComentarioService {

	Boolean guardarComentario(Comentario comentario, HttpSession session, Integer idEntidad, String tipoEntidad, boolean respuesta, Integer idComentarioPadre);
	
	List<ComentarioBean> getComentariosByEntidad(String tipoEntidad, Integer idEntidad, String entidadPerteneciente);
	
	List<ComentarioBean> getRespuestasByEntidad(String tipoEntidad, Integer idEntidad, String entidadPerteneciente);
}
