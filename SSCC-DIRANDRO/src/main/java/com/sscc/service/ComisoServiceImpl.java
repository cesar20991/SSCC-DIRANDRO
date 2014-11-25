package com.sscc.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.ComisoBean;
import com.sscc.model.CasoCriminal;
import com.sscc.model.CasoPorSospechoso;
import com.sscc.model.Comiso;
import com.sscc.model.Contactos;
import com.sscc.model.Sospechoso;
import com.sscc.util.DateUtil;

@Service
public class ComisoServiceImpl implements ComisoService{

	@PersistenceContext
	EntityManager em;
	
	@SuppressWarnings("unchecked")
	public List<ComisoBean> getComisosDelCaso(Integer idCaso) {
		List<ComisoBean> comisob = new ArrayList<ComisoBean>();
		
		Query qComentarios = em.createQuery("SELECT c FROM Comiso c JOIN c.casoCriminal cs WHERE c.estado = 'habilitado' AND cs.idCasoCriminal = "+idCaso);

		List<Comiso> a = qComentarios.getResultList();
		
		for(int i = 0;i < a.size();i++){
			ComisoBean cb = new ComisoBean();
			Comiso comiso = a.get(i);
			
			cb.setCodigo(comiso.getCodigo());
			cb.setEtiquetaOembalaje(comiso.getEtiquetaOembalaje());
			cb.setIdComiso(comiso.getIdComiso());
			cb.setPesoBruto(comiso.getPesoBruto());
			cb.setPesoNeto(comiso.getPesoNeto());
			cb.setTipoDeComiso(comiso.getTipoDeComiso());
			cb.setTipoDeInsumoOdorga(comiso.getTipoDeInsumoOdorga());
			cb.setUnidadDeMedidaBruto(comiso.getUnidadDeMedidaBruto());
			cb.setUnidadDeMedidaNeto(comiso.getUnidadDeMedidaNeto());
			cb.setValorMonetario(comiso.getValorMonetario());
			
			comisob.add(cb);
		}
		
		return comisob;
	}
	
	@Transactional
	public Boolean crearComiso(Comiso comiso, Integer idCaso){
		//Contactos c = new Contactos();
		CasoCriminal s = new CasoCriminal();
		
		s.setIdCasoCriminal(idCaso);
		
		comiso.setCasoCriminal(s);
		DateUtil d = new DateUtil();
		comiso.setFecCreacion(d.hoyTimestamp());
		
		comiso.setEstado("habilitado");
		
		em.persist(comiso);
		
		comiso.setCodigo("COM-"+comiso.getIdComiso());
		return true;
	}
	
	@Transactional
	public Boolean quitarComiso(Integer idCaso, Integer idComiso) {
		try{
			Comiso c =  em.find(Comiso.class, idComiso);
			Comiso cpsEditado = em.merge(c);
			cpsEditado.setEstado("deshabilitado");
			return true;
		}catch(Exception e){
			return false;
		}
	}
}
