package com.sscc.service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.SospechosoBean;
import com.sscc.model.RasgosParticulares;

@Service
public class RasgosParticularesServiceImpl implements RasgosParticularesService{
	
	@PersistenceContext
	EntityManager em;

	@Transactional
	public SospechosoBean getSospechosoBean(Integer idRasgosParticulares) {
		SospechosoBean sb = new SospechosoBean();
		Query qRasgosParticulares = em.createQuery("SELECT s FROM Sospechoso s JOIN s.idRasgosParticulares r WHERE r.idRasgosParticulares=:idRasgosParticulares AND s.estado='habilitado' ");
		qRasgosParticulares.setParameter("idRasgosParticulares", idRasgosParticulares);
		
		RasgosParticulares rp = new RasgosParticulares();
		rp = (RasgosParticulares) qRasgosParticulares.getSingleResult();
		
		sb.setTatuaje(rp.getTatuaje());
		sb.setLunares(rp.getLunares());
		sb.setCicatrices(rp.getCicatrices());
		sb.setDeficiencias(rp.getDeficiencias());
		sb.setOtros(rp.getOtros());
		sb.setTextoTatuaje(rp.getTextoTatuaje());
		sb.setTextoLunares(rp.getTextoLunares());
		sb.setTextoCicatrices(rp.getTextoCicatrices());
		sb.setTextoDeficiencias(rp.getTextoDeficiencias());
		sb.setTextoOtros(rp.getTextoOtros());
		return sb;
	}
	
	@Transactional
	public SospechosoBean editRasgosParticularesBean(RasgosParticulares rasgosParticulares) {
		RasgosParticulares rp = em.find(RasgosParticulares.class, rasgosParticulares.getIdRasgosParticulares());
		RasgosParticulares editadoRP = em.merge(rp);
		
		editadoRP.setTatuaje(rasgosParticulares.getTatuaje());
		editadoRP.setLunares(rasgosParticulares.getLunares());
		editadoRP.setCicatrices(rasgosParticulares.getCicatrices());
		editadoRP.setDeficiencias(rasgosParticulares.getDeficiencias());
		editadoRP.setOtros(rasgosParticulares.getOtros());
		editadoRP.setTextoTatuaje(rasgosParticulares.getTextoTatuaje());
		editadoRP.setTextoLunares(rasgosParticulares.getTextoLunares());
		editadoRP.setTextoCicatrices(rasgosParticulares.getTextoCicatrices());
		editadoRP.setTextoDeficiencias(rasgosParticulares.getDeficiencias());
		editadoRP.setTextoOtros(rasgosParticulares.getOtros());
		return getSospechosoBean(editadoRP.getIdRasgosParticulares());
	}

}
