package com.sscc.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.ComentarioBean;
import com.sscc.model.Comentario;
import com.sscc.model.Usuario;
import com.sscc.util.DateUtil;

@Service
public class ComentarioServiceImpl implements ComentarioService{
	
	@PersistenceContext
	EntityManager em;

	@Transactional
	public Boolean guardarComentario(Comentario comentario, HttpSession session, Integer idEntidad, String tipoEntidad, boolean respuesta, Integer idComentarioPadre) {
		boolean result = true;

		DateUtil d = new DateUtil();
		Usuario u = new Usuario();
		u.setIdUsuario((Integer) (session.getAttribute("idUsuario")));
		
		if(idComentarioPadre != null){
			comentario.setIdComentarioPadre(idComentarioPadre);
		}else{
			comentario.setIdComentarioPadre(null);
		}
		
		comentario.setEstado("habilitado");
		comentario.setIdEntidad(idEntidad);
		comentario.setTipoEntidad(tipoEntidad);
		comentario.setFecCreacion(d.hoyTimestamp());
		comentario.setUsuario(u);
		comentario.setRespuesta(respuesta);
		
		try{
			
			em.persist(comentario);
			
			result = true;
		}catch(Exception e){
			System.err.println("ERROR guardar comentario");
			result = false;
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<ComentarioBean> getComentariosByEntidad(String tipoEntidad, Integer idEntidad, String entidadPerteneciente) {
		List<ComentarioBean> comentariosb = new ArrayList<ComentarioBean>();
		
		Query qComentarios = null;
		//if(tipoEntidad.equals("usuario")){
			qComentarios = em.createQuery("SELECT c FROM Comentario c WHERE c.tipoEntidad = '"+tipoEntidad+"' AND c.idEntidad="+idEntidad+" AND c.estado = 'habilitado' AND (c.visibilidad='Solo Yo' OR c.visibilidad='Público' OR c.visibilidad='"+entidadPerteneciente+"') AND c.respuesta=false ORDER BY c.fecCreacion DESC ");
		/*}else if(tipoEntidad.equals("sospechoso")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.sospechoso s WHERE a.tipoEntidad = 'sospechoso' AND s.idSospechoso="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
		}else if(tipoEntidad.equals("casoCriminal")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.casoCriminal c WHERE a.tipoEntidad = 'casoCriminal' AND c.idCasoCriminal="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
		}else if(tipoEntidad.equals("inmueble")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.inmueble i WHERE a.tipoEntidad = 'inmueble' AND i.idInmueble="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
		}else if(tipoEntidad.equals("vehiculo")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.vehiculo v WHERE a.tipoEntidad = 'vehiculo' AND v.idVehiculo="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
		}*/
		
		List<Comentario> a = qComentarios.getResultList();
		
		for(int i = 0;i < a.size();i++){
			ComentarioBean comentariobean = new ComentarioBean();
			Comentario comentario = a.get(i);
			Usuario u = comentario.getUsuario();
			comentariobean.setIdComentario(comentario.getIdComentario());
			comentariobean.setComentario(comentario.getComentario());
			comentariobean.setFecCreacion(comentario.getFecCreacion());
			comentariobean.setNombreCompleto(u.getPerfil().getPrimerNombre()+" "+u.getPerfil().getSegundoNombre()+" "+u.getPerfil().getApePaterno()+" "+u.getPerfil().getApeMaterno());
			comentariobean.setRespuesta(comentario.getRespuesta());
			comentariobean.setIdUsuario(u.getIdUsuario());
			comentariobean.setVisibilidad(comentario.getVisibilidad());
			comentariobean.setUrlUsuario(u.getPerfil().getUrlPerfil());
			comentariobean.setIdPerfil(u.getPerfil().getIdPerfil());
			comentariosb.add(comentariobean);
		}
		
		return comentariosb;
	}
	
	@SuppressWarnings("unchecked")
	public List<ComentarioBean> getRespuestasByEntidad(String tipoEntidad, Integer idEntidad, String entidadPerteneciente) {
		List<ComentarioBean> comentariosb = new ArrayList<ComentarioBean>();
		
		Query qComentarios = null;
		//if(tipoEntidad.equals("usuario")){
			qComentarios = em.createQuery("SELECT c FROM Comentario c WHERE c.tipoEntidad = '"+tipoEntidad+"' AND c.idEntidad="+idEntidad+" AND c.estado = 'habilitado' AND (c.visibilidad='Solo Yo' OR c.visibilidad='Público' OR c.visibilidad='"+entidadPerteneciente+"') AND c.respuesta=true ORDER BY c.fecCreacion ASC ");
		/*}else if(tipoEntidad.equals("sospechoso")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.sospechoso s WHERE a.tipoEntidad = 'sospechoso' AND s.idSospechoso="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
		}else if(tipoEntidad.equals("casoCriminal")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.casoCriminal c WHERE a.tipoEntidad = 'casoCriminal' AND c.idCasoCriminal="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
		}else if(tipoEntidad.equals("inmueble")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.inmueble i WHERE a.tipoEntidad = 'inmueble' AND i.idInmueble="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
		}else if(tipoEntidad.equals("vehiculo")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.vehiculo v WHERE a.tipoEntidad = 'vehiculo' AND v.idVehiculo="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
		}*/
		
		List<Comentario> a = qComentarios.getResultList();
		
		for(int i = 0;i < a.size();i++){
			ComentarioBean comentariobean = new ComentarioBean();
			Comentario comentario = a.get(i);
			Usuario u = comentario.getUsuario();
			comentariobean.setIdComentario(comentario.getIdComentario());
			comentariobean.setComentario(comentario.getComentario());
			comentariobean.setFecCreacion(comentario.getFecCreacion());
			comentariobean.setNombreCompleto(u.getPerfil().getPrimerNombre()+" "+u.getPerfil().getSegundoNombre()+" "+u.getPerfil().getApePaterno()+" "+u.getPerfil().getApeMaterno());
			comentariobean.setRespuesta(comentario.getRespuesta());
			comentariobean.setIdUsuario(u.getIdUsuario());
			comentariobean.setVisibilidad(comentario.getVisibilidad());
			comentariobean.setUrlUsuario(u.getPerfil().getUrlPerfil());
			comentariobean.setIdPerfil(u.getPerfil().getIdPerfil());
			comentariobean.setIdComentarioPadre(comentario.getIdComentarioPadre());
			comentariosb.add(comentariobean);
		}
		
		return comentariosb;
	}

}
