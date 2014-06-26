package com.sscc.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.PuntoAcopioBean;
import com.sscc.model.CasoCriminal;
import com.sscc.model.PuntoAcopio;
import com.sscc.model.Usuario;
import com.sscc.util.DateUtil;

@Service
public class PuntoAcopioServiceImpl implements PuntoAcopioService{

	@PersistenceContext
	EntityManager em;
	
	public PuntoAcopioBean getPuntoAcopioBean(Integer idAcopio) {
		PuntoAcopio rp = em.find(PuntoAcopio.class, idAcopio);
		PuntoAcopioBean rb = new PuntoAcopioBean();
		rb.setComentarios(rp.getComentario());
		rb.setLatitud(rp.getLatitud());
		rb.setLongitud(rp.getLongitud());
		rb.setIdAcopio(rp.getIdAcopio());
		rb.setNombre(rp.getNombre());
		
		return rb;
	}
	
	@SuppressWarnings("unchecked")
	public List<PuntoAcopioBean> getPuntoAcopiosBean(Integer idCasoCriminal) {
		List<PuntoAcopioBean> lrb = new ArrayList<PuntoAcopioBean>();
		Query q = em.createQuery("SELECT r FROM PuntoAcopio r JOIN r.casoCriminal c WHERE r.estado='habilitado' AND c.idCasoCriminal="+idCasoCriminal+" ORDER BY r.fecCreacion DESC");
		//RutasMapas rp = em.find(RutasMapas.class, idRuta);
		List<PuntoAcopio> r = q.getResultList();
		//el query devuelve una lista de rutasMapas, pero debemos devolver RutasBean, y eso se hace con el for
		for(int i=0;i<r.size();i++){
			PuntoAcopio rp = r.get(i);
			PuntoAcopioBean rb = new PuntoAcopioBean();
			rb.setComentarios(rp.getComentario());
			rb.setLatitud(rp.getLatitud());
			rb.setLongitud(rp.getLongitud());
			rb.setIdAcopio(rp.getIdAcopio());
			rb.setNombre(rp.getNombre());
			lrb.add(rb);
		}
		return lrb;
	}
	
	@Transactional
	public Boolean guardarAcopio(PuntoAcopio acopio, HttpSession session, Integer idCasoCriminal) {
		try{
			acopio.setEstado("habilitado");
			DateUtil d = new DateUtil();
			acopio.setFecCreacion(d.hoyTimestamp());
			CasoCriminal c = new CasoCriminal();
			c.setIdCasoCriminal(idCasoCriminal);
			acopio.setCasoCriminal(c);
			Usuario u = new Usuario();
			u.setIdUsuario((Integer) session.getAttribute("idUsuario"));
			acopio.setUsuario(u);
			em.persist(acopio);
			return true;
		}catch(Exception e){
			return false;
		}
		
	}
}
