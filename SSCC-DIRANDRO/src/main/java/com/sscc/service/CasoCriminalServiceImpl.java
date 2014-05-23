package com.sscc.service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.model.CasoCriminal;
import com.sscc.model.Usuario;
import com.sscc.util.DateUtil;

@Service
public class CasoCriminalServiceImpl implements CasoCriminalService{
	
	@PersistenceContext
	EntityManager em;

	@SuppressWarnings("deprecation")
	@Transactional
	public Integer crearCasoCriminal(CasoCriminal caso, Integer idUsuario) {
		//seteo el primer estado del caso
		caso.setEstado("Activo");
		//seteo la fecha de creacion
		DateUtil d = new DateUtil();
		caso.setFecCreacion(d.hoyTimestamp());
		//seteo el idUsuario como clave foranea
		Usuario u = new Usuario();
		u.setIdUsuario(idUsuario);
		caso.setUsuario(u);
		
		//grabar en la BD
		em.persist(caso);
		
		caso.setCodigo("N°"+caso.getIdCasoCriminal()+"-"+d.hoyTimestamp().getMonth()+"-"+d.hoyTimestamp().getYear()+"-DIRANDRO-PNP-UI");
		
		return caso.getIdCasoCriminal();
	}

}
