package com.sscc.controller;

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

import com.sscc.form.ComentarioBean;
import com.sscc.model.Comentario;
import com.sscc.service.ComentarioService;

@Controller
public class ComentarioController {

	@Autowired
	ComentarioService comentarioServ;
	
	@RequestMapping(value = "guardarComentario", method = RequestMethod.POST)
	@ResponseBody
	public List<ComentarioBean> guardarComentario(@ModelAttribute Comentario comentario, HttpServletRequest req, HttpSession session){
		
		String tipoEntidad = req.getParameter("tipoEntidadCommentario");
		Integer idEntidad = Integer.parseInt(req.getParameter("idEntidadCommentario"));
		String entidadPerteneciente = session.getAttribute("entidad").toString();
		
		if(comentarioServ.guardarComentario(comentario, session, idEntidad, tipoEntidad, false, null)){
			return comentarioServ.getComentariosByEntidad(tipoEntidad, idEntidad, entidadPerteneciente);
		}else{
			return null;
		}
		
	}
	
	@RequestMapping(value = "getComentarios", method = RequestMethod.POST)
	@ResponseBody
	public List<ComentarioBean> getComentarios(@ModelAttribute Comentario comentario, HttpServletRequest req, HttpSession session){
		
		String tipoEntidad = req.getParameter("tipoEntidadCommentario");
		Integer idEntidad = Integer.parseInt(req.getParameter("idEntidadCommentario"));
		String entidadPerteneciente = session.getAttribute("entidad").toString();
		String entidadPertene ="";
		if(entidadPerteneciente.equals("D")){
			entidadPertene = "DIRANDRO";
		}else if(entidadPerteneciente.equals("M")){
			entidadPertene = "Ministerio Público";
		}
			
		return comentarioServ.getComentariosByEntidad(tipoEntidad, idEntidad, entidadPertene);
		
	}
	
	@RequestMapping(value = "guardarRespuesta-{idComentarioPadre}", method = RequestMethod.POST)
	@ResponseBody
	public Boolean guardarRespuesta(@ModelAttribute Comentario comentario, HttpServletRequest req, HttpSession session, @PathVariable("idComentarioPadre") Integer idComentarioPadre){
		
		String tipoEntidad = req.getParameter("tipoEntidadCommentario");
		Integer idEntidad = Integer.parseInt(req.getParameter("idEntidadCommentario"));
		String entidadPerteneciente = session.getAttribute("entidad").toString();
		
		if(comentarioServ.guardarComentario(comentario, session, idEntidad, tipoEntidad, true, idComentarioPadre)){
			return true;
		}else{
			return false;
		}
		
	}
	
	@RequestMapping(value = "getRespuestas", method = RequestMethod.POST)
	@ResponseBody
	public List<ComentarioBean> getRespuestas(@ModelAttribute Comentario comentario, HttpServletRequest req, HttpSession session){
		
		String tipoEntidad = req.getParameter("tipoEntidadCommentario");
		Integer idEntidad = Integer.parseInt(req.getParameter("idEntidadCommentario"));
		String entidadPerteneciente = session.getAttribute("entidad").toString();
		String entidadPertene ="";
		if(entidadPerteneciente.equals("D")){
			entidadPertene = "DIRANDRO";
		}else if(entidadPerteneciente.equals("M")){
			entidadPertene = "Ministerio Público";
		}
		return comentarioServ.getRespuestasByEntidad(tipoEntidad, idEntidad, entidadPertene);
		
	}
}
