package com.sscc.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.PerfilBean;
import com.sscc.model.Perfil;
import com.sscc.model.Usuario;
import com.sscc.util.DateUtil;

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
		pf.setRango(p.getRango());
		pf.setTipoFiscal(p.getTipoFiscal());
		pf.setCodigoPerfil(p.getCodigo());
		pf.setUrlPerfil(p.getUrlPerfil());
		
		return pf;
	}

	@Transactional
	public PerfilBean crearUsuario(Perfil perfil, String correo) {
		PerfilBean pf = new PerfilBean();
		
		perfil.setEstado("habilitado");
		DateUtil d = new DateUtil();
		perfil.setFecCreacion(d.hoyTimestamp());

		if(perfil.getEntidadPerteneciente().equals("M")){
			perfil.setGrado("");
		}
		
		em.persist(perfil);		
		
		perfil.setCodigo("USU-"+perfil.getIdPerfil());
		
		Usuario us = new Usuario();
		us.setCorreoElectronico(correo);
		us.setContrasena("pass");
		us.setEstado("habilitado");
		us.setFecCreacion(d.hoyTimestamp());
		us.setPerfil(perfil);
		em.persist(us);
		
		pf.setPrimerNombre(perfil.getPrimerNombre());
		pf.setSegundoNombre(perfil.getSegundoNombre());
		pf.setApePaterno(perfil.getApePaterno());
		pf.setApeMaterno(perfil.getApeMaterno());
		pf.setDni(perfil.getDni());
		pf.setSexo(perfil.getSexo());
		pf.setEntidadPerteneciente(perfil.getEntidadPerteneciente());
		pf.setCorreoElectronico(us.getCorreoElectronico());
		pf.setTelefono(perfil.getTelefono());
		pf.setNumeroDeCarnet(perfil.getNumeroDeCarnet());
		pf.setGrado(perfil.getGrado());
		pf.setCargo(perfil.getCargo());
		pf.setIdPerfil(perfil.getIdPerfil());
		pf.setTipoFiscal(perfil.getTipoFiscal());
		pf.setRango(perfil.getRango());
		pf.setCodigoPerfil(perfil.getCodigo());
		
		return pf;
	}

	@SuppressWarnings("unchecked")
	public List<PerfilBean> getJefesDeUnidad() {
		List<PerfilBean> pbl = new ArrayList<PerfilBean>();
		List<Perfil> p = new ArrayList<Perfil>();
		Query qCasos = em.createQuery("SELECT p FROM Perfil p WHERE p.estado='habilitado' AND p.cargo='Jefe de Unidad'");
		p = qCasos.getResultList();
		
		for(int i = 0; i < p.size(); i++){
			PerfilBean pb = new PerfilBean();
			pb.setIdUsuario(p.get(i).getUsuario().getIdUsuario());
			pb.setIdPerfil(p.get(i).getIdPerfil());
			pb.setNombreCompleto(p.get(i).getPrimerNombre()+" "+p.get(i).getSegundoNombre()+" "+p.get(i).getApePaterno()+" "+p.get(i).getApeMaterno());
			pbl.add(pb);
		}
		
		return pbl;
	}

	@SuppressWarnings("unchecked")
	public List<PerfilBean> getPersonalPolicial() {
		List<PerfilBean> pbl = new ArrayList<PerfilBean>();
		List<Perfil> p = new ArrayList<Perfil>();
		Query qCasos = em.createQuery("SELECT p FROM Perfil p WHERE p.estado='habilitado' AND (p.cargo='Superior' OR p.cargo='Investigador')");
		p = qCasos.getResultList();
		
		for(int i = 0; i < p.size(); i++){
			PerfilBean pb = new PerfilBean();
			pb.setIdUsuario(p.get(i).getUsuario().getIdUsuario());
			pb.setIdPerfil(p.get(i).getIdPerfil());
			pb.setNombreCompleto(p.get(i).getPrimerNombre()+" "+p.get(i).getSegundoNombre()+" "+p.get(i).getApePaterno()+" "+p.get(i).getApeMaterno());
			pbl.add(pb);
		}
		
		return pbl;
	}
	
	@SuppressWarnings("unchecked")
	public PerfilBean getJefesPorCaso(Integer idCasoCriminal) {
		PerfilBean pb = new PerfilBean();
		Perfil p = new Perfil();
		
		try{
			Query qCasos = em.createQuery("SELECT p FROM Perfil p JOIN p.usuario u JOIN u.cpa cpa WHERE p.estado='habilitado' AND cpa.estado='habilitado' AND cpa.casoCriminal.idCasoCriminal="+idCasoCriminal+" AND p.cargo='Jefe de Unidad'");
			p = (Perfil) qCasos.getSingleResult();
			pb.setIdUsuario(p.getUsuario().getIdUsuario());
			pb.setIdPerfil(p.getIdPerfil());
			pb.setNombreCompleto(p.getPrimerNombre()+" "+p.getSegundoNombre()+" "+p.getApePaterno()+" "+p.getApeMaterno());
		}catch(Exception e){
			System.err.println("ERROR no encontre jefes");
		}
		
		return pb;
	}
	
	@SuppressWarnings("unchecked")
	public List<PerfilBean> getPersonalPolicialPorCaso(Integer idCasoCriminal) {
		List<PerfilBean> pbl = new ArrayList<PerfilBean>();
		List<Perfil> p = new ArrayList<Perfil>();
		Query qCasos = em.createQuery("SELECT p FROM Perfil p JOIN p.usuario u JOIN u.cpa cpa WHERE p.estado='habilitado' AND cpa.estado='habilitado' AND cpa.casoCriminal.idCasoCriminal="+idCasoCriminal+" AND (p.cargo='Superior' OR p.cargo='Investigador')");
		p = qCasos.getResultList();
		
		for(int i = 0; i < p.size(); i++){
			PerfilBean pb = new PerfilBean();
			pb.setIdUsuario(p.get(i).getUsuario().getIdUsuario());
			pb.setIdPerfil(p.get(i).getIdPerfil());
			pb.setNombreCompleto(p.get(i).getPrimerNombre()+" "+p.get(i).getSegundoNombre()+" "+p.get(i).getApePaterno()+" "+p.get(i).getApeMaterno());
			pbl.add(pb);
		}
		
		return pbl;
	}
	
	@SuppressWarnings("unchecked")
	public List<PerfilBean> getPersonalPolicial(Integer idCasoCriminal) {
		List<PerfilBean> pbl = new ArrayList<PerfilBean>();
		List<Perfil> p = new ArrayList<Perfil>();
		Query qCasos = em.createQuery("SELECT p FROM Perfil p JOIN p.usuario u JOIN u.cpa cpa WHERE p.estado='habilitado' AND cpa.estado='habilitado' AND cpa.casoCriminal.idCasoCriminal="+idCasoCriminal+ " ORDER BY p.apePaterno ASC");
		p = qCasos.getResultList();
		
		for(int i = 0; i < p.size(); i++){
			PerfilBean pb = new PerfilBean();
			pb.setIdUsuario(p.get(i).getUsuario().getIdUsuario());
			pb.setIdPerfil(p.get(i).getIdPerfil());
			pb.setNumeroDeCarnet(p.get(i).getNumeroDeCarnet());
			pb.setGrado(p.get(i).getGrado());
			pb.setRango(p.get(i).getRango());
			pb.setCargo(p.get(i).getCargo());
			pb.setCodigoPerfil(p.get(i).getCodigo());
			pb.setApeMaterno(p.get(i).getApeMaterno());
			pb.setApePaterno(p.get(i).getApePaterno());
			pb.setPrimerNombre(p.get(i).getPrimerNombre());
			pb.setSegundoNombre(p.get(i).getSegundoNombre());
			pb.setCorreoElectronico(p.get(i).getUsuario().getCorreoElectronico());
			//pb.setNombreCompleto(p.get(i).getPrimerNombre()+" "+p.get(i).getSegundoNombre()+" "+p.get(i).getApePaterno()+" "+p.get(i).getApeMaterno());
			pbl.add(pb);
		}
		
		return pbl;
	}

}
