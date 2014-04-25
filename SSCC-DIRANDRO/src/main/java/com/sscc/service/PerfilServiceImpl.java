package com.sscc.service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.PerfilBean;
import com.sscc.model.Perfil;
import com.sscc.model.Usuario;

@Service
public class PerfilServiceImpl implements PerfilService {
	
	@PersistenceContext
	EntityManager em;

	@Transactional
	public PerfilBean getPerfil(Integer idPerfil) {
		PerfilBean pf = new PerfilBean();

		Query qPerfil = em.createQuery("SELECT u FROM Usuario u JOIN u.perfil p WHERE p.idPerfil =:idPerfil AND u.estado =:estadoU AND p.estado =:estadoP ");
		qPerfil.setParameter("idPerfil", idPerfil);
		qPerfil.setParameter("estadoU", "habilitado");
		qPerfil.setParameter("estadoP", "habilitado");

		Usuario u = (Usuario) qPerfil.getSingleResult();
		Perfil p = u.getPerfil();

		pf.setPrimerNombre(p.getPrimerNombre());
		pf.setSegundoNombre(p.getSegundoNombre());
		pf.setApePaterno(p.getApePaterno());
		pf.setApeMaterno(p.getApeMaterno());
		pf.setDni(p.getDni());
		pf.setSexo(p.getSexo());
		pf.setEntidadPerteneciente(p.getEntidadPerteneciente());
		pf.setCorreoElectronico(u.getCorreoElectronico());
		pf.setTelefono(p.getTelefono());
		pf.setNumeroDeCarnet(p.getNumeroDeCarnet());
		pf.setGrado(p.getGrado());
		pf.setCargo(p.getCargo());
		
		return pf;
	}

}
