package com.sscc.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.RutasBean;
import com.sscc.model.CasoCriminal;
import com.sscc.model.RutasMapas;
import com.sscc.model.Usuario;
import com.sscc.util.DateUtil;

@Service
public class RutasServiceImpl implements RutasService{

	@PersistenceContext
	EntityManager em;

	public RutasBean getRutaBean(Integer idRuta) {
		RutasMapas rp = em.find(RutasMapas.class, idRuta);
		RutasBean rb = new RutasBean();
		rb.setComentarios(rp.getComentario());
		rb.setFinLat(rp.getFinLat());
		rb.setFinLong(rp.getFinLong());
		rb.setIdRuta(rp.getIdRuta());
		rb.setInicioLat(rp.getInicioLat());
		rb.setInicioLong(rp.getInicioLong());
		rb.setNombre(rp.getNombre());
		rb.setWp(rp.getWp());
		
		return rb;
	}
	
	@SuppressWarnings("unchecked")
	public List<RutasBean> getRutasBean(Integer idCasoCriminal) {
		List<RutasBean> lrb = new ArrayList<RutasBean>();
		Query q = em.createQuery("SELECT r FROM RutasMapas r JOIN r.casoCriminal c WHERE r.estado='habilitado' AND c.idCasoCriminal="+idCasoCriminal+" ORDER BY r.fecCreacion DESC");
		//RutasMapas rp = em.find(RutasMapas.class, idRuta);
		List<RutasMapas> r = q.getResultList();
		//el query devuelve una lista de rutasMapas, pero debemos devolver RutasBean, y eso se hace con el for
		for(int i=0;i<r.size();i++){
			RutasMapas rp = r.get(i);
			RutasBean rb = new RutasBean();
			rb.setComentarios(rp.getComentario());
			rb.setFinLat(rp.getFinLat());
			rb.setFinLong(rp.getFinLong());
			rb.setIdRuta(rp.getIdRuta());
			rb.setInicioLat(rp.getInicioLat());
			rb.setInicioLong(rp.getInicioLong());
			rb.setNombre(rp.getNombre());
			rb.setWp(rp.getWp());
			lrb.add(rb);
		}
		return lrb;
	}

	@Transactional
	public Boolean guardarRuta(RutasMapas ruta, HttpSession session, Integer idCasoCriminal) {
		try{
			ruta.setEstado("habilitado");
			DateUtil d = new DateUtil();
			ruta.setFecCreacion(d.hoyTimestamp());
			CasoCriminal c = new CasoCriminal();
			c.setIdCasoCriminal(idCasoCriminal);
			ruta.setCasoCriminal(c);
			Usuario u = new Usuario();
			u.setIdUsuario((Integer) session.getAttribute("idUsuario"));
			ruta.setUsuario(u);
			em.persist(ruta);
			return true;
		}catch(Exception e){
			return false;
		}
		
	}
	
	
}
