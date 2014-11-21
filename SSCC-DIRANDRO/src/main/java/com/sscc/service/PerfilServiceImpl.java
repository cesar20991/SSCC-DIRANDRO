package com.sscc.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.PerfilBean;
import com.sscc.form.SospechosoBean;
import com.sscc.model.Perfil;
import com.sscc.model.Sospechoso;
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
	
	@Transactional
	public PerfilBean editUsuario(Perfil perfil, String correo) {
		Perfil p = em.find(Perfil.class, perfil.getIdPerfil());
		Perfil editado = em.merge(p);
		
		editado.setApeMaterno(perfil.getApeMaterno());
		editado.setApePaterno(perfil.getApePaterno());
		editado.setCargo(perfil.getCargo());
		editado.setDni(perfil.getDni());
		editado.setGrado(perfil.getGrado());
		editado.setNumeroDeCarnet(perfil.getNumeroDeCarnet());
		editado.setPrimerNombre(perfil.getPrimerNombre());
		editado.setRango(perfil.getRango());
		editado.setSegundoNombre(perfil.getSegundoNombre());
		editado.setSexo(perfil.getSexo());
		editado.setTelefono(perfil.getTelefono());
		editado.getUsuario().setCorreoElectronico(correo);
		editado.setTipoFiscal(perfil.getTipoFiscal());
		
		return getPerfil(editado.getIdPerfil());
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
			pb.setCargo(p.get(i).getCargo());
			pb.setCodigoPerfil(p.get(i).getCodigo());
			pb.setDni(p.get(i).getDni());
			pb.setCorreoElectronico(p.get(i).getUsuario().getCorreoElectronico());
			if(p.get(i).getEntidadPerteneciente().equals("D")){
				pb.setEntidadPerteneciente("DIRANDRO");
			}else{
				pb.setEntidadPerteneciente("Ministerio Público");
			}
			pb.setGrado(p.get(i).getGrado());
			pb.setNumeroDeCarnet(p.get(i).getNumeroDeCarnet());
			pb.setRango(p.get(i).getRango());
			pb.setSexo(p.get(i).getSexo());
			pb.setTelefono(p.get(i).getTelefono());
			if(p.get(i).getUrlPerfil() == null){
				pb.setUrlPerfil("img/skills.png");
			}else{
				pb.setUrlPerfil(p.get(i).getUrlPerfil());				
			}
			pbl.add(pb);
		}
		
		return pbl;
	}

	@SuppressWarnings("unchecked")
	public List<PerfilBean> getPersonalPolicial() {
		List<PerfilBean> pbl = new ArrayList<PerfilBean>();
		List<Perfil> p = new ArrayList<Perfil>();
		Query qCasos = em.createQuery("SELECT p FROM Perfil p JOIN p.usuario u WHERE p.estado='habilitado' AND (p.cargo='Superior' OR p.cargo='Investigador')");
		p = qCasos.getResultList();
		
		for(int i = 0; i < p.size(); i++){
			PerfilBean pb = new PerfilBean();
			pb.setIdUsuario(p.get(i).getUsuario().getIdUsuario());
			pb.setIdPerfil(p.get(i).getIdPerfil());
			pb.setNombreCompleto(p.get(i).getPrimerNombre()+" "+p.get(i).getSegundoNombre()+" "+p.get(i).getApePaterno()+" "+p.get(i).getApeMaterno());
			pb.setCorreoElectronico(p.get(i).getUsuario().getCorreoElectronico());
			pb.setCargo(p.get(i).getCargo());
			pb.setDni(p.get(i).getDni());
			pb.setNumeroDeCarnet(p.get(i).getNumeroDeCarnet());
			if(p.get(i).getEntidadPerteneciente().equals("D")){
				pb.setEntidadPerteneciente("DIRANDRO");
			}else{
				pb.setEntidadPerteneciente("Ministerio Público");
			}
			pb.setGrado(p.get(i).getGrado());
			pb.setRango(p.get(i).getRango());
			pb.setSexo(p.get(i).getSexo());
			pb.setTelefono(p.get(i).getTelefono());
			if(p.get(i).getUrlPerfil() == null){
				pb.setUrlPerfil("img/skills.png");
			}else{
				pb.setUrlPerfil(p.get(i).getUrlPerfil());				
			}
			pbl.add(pb);
		}
		
		return pbl;
	}
	
	@SuppressWarnings("unchecked")
	public List<PerfilBean> getPersonalPolicialBuscar() {
		List<PerfilBean> pbl = new ArrayList<PerfilBean>();
		List<Perfil> p = new ArrayList<Perfil>();
		Query qPersonal = em.createQuery("SELECT " +
										"u.idUsuario, p.idPerfil, p.primerNombre, p.segundoNombre, p.apePaterno, p.apeMaterno, " +
										"u.correoElectronico, p.cargo, p.dni, p.numeroDeCarnet, p.entidadPerteneciente, " +
										"p.grado, p.rango, p.sexo, p.telefono, p.urlPerfil, c.codigo, c.referencia " +
				" FROM Perfil p JOIN p.usuario u LEFT JOIN u.cpa cpa LEFT JOIN cpa.casoCriminal c WHERE p.estado='habilitado')");
		List<Object[]> rows = qPersonal.getResultList();
		//p = qCasos.getResultList();
		
		//for(int i = 0; i < p.size(); i++){
		for (int x = 0; x < rows.size(); x++) {
			Object[] obj = rows.get(x);
			PerfilBean pb = new PerfilBean();
			
			pb.setIdUsuario((Integer)obj[0]);			
			pb.setIdPerfil((Integer)obj[1]);
			
			pb.setNombreCompleto((String)obj[2]+" "+(String)obj[3]+" "+(String)obj[4]+" "+(String)obj[5]);
			pb.setCorreoElectronico((String)obj[6]);
			pb.setCargo((String)obj[7]);
			pb.setDni((Integer)obj[8]);
			pb.setNumeroDeCarnet((Integer)obj[9]);
			if(((String)obj[10]).equals("D")){
				pb.setEntidadPerteneciente("DIRANDRO");
			}else{
				pb.setEntidadPerteneciente("Ministerio Público");
			}
			pb.setGrado((String)obj[11]);
			pb.setRango((String)obj[12]);
			pb.setSexo((String)obj[13]);
			pb.setTelefono((String)obj[14]);
			if((String)obj[15] == null){
				pb.setUrlPerfil("img/skills.png");
			}else{
				pb.setUrlPerfil((String)obj[15]);				
			}
			pb.setCasoAsignado((String)obj[16]+"("+(String)obj[17]+")");
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
			pb.setGrado(p.get(i).getGrado());
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
			pb.setUrlPerfil(p.get(i).getUrlPerfil());
			//pb.setNombreCompleto(p.get(i).getPrimerNombre()+" "+p.get(i).getSegundoNombre()+" "+p.get(i).getApePaterno()+" "+p.get(i).getApeMaterno());
			pbl.add(pb);
		}
		
		return pbl;
	}

	public Boolean getDni(Integer dni) {
		Query queryCont = em.createQuery("SELECT COUNT(p) FROM Perfil p WHERE p.dni =:dni");
		queryCont.setParameter("dni", dni);
		Integer cont = Integer.parseInt(queryCont.getSingleResult().toString());
		return cont > 0 ? true : false;
	}

	public Boolean getNumeroCarnet(Integer numeroDeCarnet) {
		Query queryCont = em.createQuery("SELECT COUNT(p) FROM Perfil p WHERE p.numeroDeCarnet =:numeroDeCarnet");
		queryCont.setParameter("numeroDeCarnet", numeroDeCarnet);
		Integer cont = Integer.parseInt(queryCont.getSingleResult().toString());
		return cont > 0 ? true : false;
	}
	
	@SuppressWarnings("unchecked")
	public List<PerfilBean> getPersonalPolicialModal() {
		List<PerfilBean> pbl = new ArrayList<PerfilBean>();
		List<Perfil> p = new ArrayList<Perfil>();
		Query qPersonal = em.createQuery("SELECT " +
										"u.idUsuario, p.idPerfil, p.primerNombre, p.segundoNombre, p.apePaterno, p.apeMaterno, " +
										"u.correoElectronico, p.cargo, p.dni, p.numeroDeCarnet, p.entidadPerteneciente, " +
										"p.grado, p.rango, p.sexo, p.telefono, p.urlPerfil " +
				" FROM Perfil p JOIN p.usuario u WHERE p.estado='habilitado')");
		List<Object[]> rows = qPersonal.getResultList();
		//p = qCasos.getResultList();
		
		//for(int i = 0; i < p.size(); i++){
		for (int x = 0; x < rows.size(); x++) {
			Object[] obj = rows.get(x);
			PerfilBean pb = new PerfilBean();
			
			pb.setIdUsuario((Integer)obj[0]);			
			pb.setIdPerfil((Integer)obj[1]);
			
			pb.setNombreCompleto((String)obj[2]+" "+(String)obj[3]+" "+(String)obj[4]+" "+(String)obj[5]);
			pb.setCorreoElectronico((String)obj[6]);
			pb.setCargo((String)obj[7]);
			pb.setDni((Integer)obj[8]);
			pb.setNumeroDeCarnet((Integer)obj[9]);
			if(((String)obj[10]).equals("D")){
				pb.setEntidadPerteneciente("DIRANDRO");
			}else{
				pb.setEntidadPerteneciente("Ministerio Público");
			}
			pb.setGrado((String)obj[11]);
			pb.setRango((String)obj[12]);
			pb.setSexo((String)obj[13]);
			pb.setTelefono((String)obj[14]);
			if((String)obj[15] == null){
				pb.setUrlPerfil("img/skills.png");
			}else{
				pb.setUrlPerfil((String)obj[15]);				
			}
			pbl.add(pb);
		}
		
		return pbl;
	}
}