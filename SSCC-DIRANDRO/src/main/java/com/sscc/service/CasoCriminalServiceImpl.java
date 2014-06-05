package com.sscc.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.CasoCriminalBean;
import com.sscc.model.CasoCriminal;
import com.sscc.model.Perfil;
import com.sscc.model.Usuario;
import com.sscc.model.CasoPorAgente;
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
		
		Integer mes = d.hoy().getMonth();
		mes++;
		Integer anho = d.hoy().getYear();
		Integer year = anho+1900;
		if(mes <= 9){
			caso.setCodigo("N°"+caso.getIdCasoCriminal()+"-0"+mes+"-"+year+"-DIRANDRO-PNP-UI");
		}else{
			caso.setCodigo("N°"+caso.getIdCasoCriminal()+"-"+mes+"-"+year+"-DIRANDRO-PNP-UI");
		}
		
		return caso.getIdCasoCriminal();
	}

	public CasoCriminalBean getCasoCriminalBean(Integer idCaso) {
		CasoCriminalBean cb = new CasoCriminalBean();
		CasoCriminal c = em.find(CasoCriminal.class, idCaso);
		Usuario u = c.getUsuario();
		Perfil p = u.getPerfil();
		
		cb.setApeMaterno(p.getApeMaterno());
		cb.setApePaterno(p.getApePaterno());
		cb.setAsunto(c.getAsunto());
		cb.setCodigo(c.getCodigo());
		cb.setCorreoElectronico(u.getContrasena());
		cb.setDescripcion(c.getDescripcion());
		cb.setEstado(c.getEstado());
		cb.setFecCreacion(c.getFecCreacion());
		cb.setIdCasoCriminal(c.getIdCasoCriminal());
		cb.setPrimerNombre(p.getPrimerNombre());
		cb.setReferencia(c.getReferencia());
		cb.setSegundoNombre(p.getSegundoNombre());
		cb.setTipoFiscal(p.getTipoFiscal());
		cb.setIdPerfil(p.getIdPerfil());
		
		return cb;
	}

	@SuppressWarnings("unchecked")
	public List<CasoCriminalBean> getCasosCriminalBean() {
		List<CasoCriminalBean> cbl = new ArrayList<CasoCriminalBean>();
		Query qCasos = em.createQuery("SELECT c.idCasoCriminal, c.codigo, c.referencia FROM CasoCriminal c");
		List<Object[]> c = qCasos.getResultList();

		for(int i = 0; i < c.size(); i++){
			CasoCriminalBean cb = new CasoCriminalBean();
			Object[] cc = c.get(i);
			cb.setIdCasoCriminal((Integer)cc[0]);
			cb.setCodigo((String)cc[1]);
			cb.setReferencia((String)cc[2]);
			cbl.add(cb);
		}
		
		return cbl;
	}
	
	@SuppressWarnings("unchecked")
	public List<CasoCriminalBean> getCasosCriminalBeanPersonal() {
		List<CasoCriminalBean> cbl = new ArrayList<CasoCriminalBean>();
		Query qCasos = em.createQuery("SELECT c.idCasoCriminal, c.codigo, c.referencia FROM CasoCriminal c ");
		List<Object[]> c = qCasos.getResultList();
		for(int i = 0; i < c.size(); i++){
			CasoCriminalBean cb = new CasoCriminalBean();
			Object[] cc = c.get(i);
			cb.setIdCasoCriminal((Integer)cc[0]);
			cb.setCodigo((String)cc[1]);
			cb.setReferencia((String)cc[2]);
			cbl.add(cb);
		}
		
		return cbl;
	}
	
	@Transactional
	public List<CasoCriminalBean> asignarCasoCriminalEditar(Integer idCaso, Integer idJefeDeUnidad) {
		Query qCasos = em.createQuery("SELECT cpa FROM CasoPorAgente cpa JOIN cpa.casoCriminal c JOIN cpa.usuario u JOIN u.perfil p WHERE c.idCasoCriminal = "+idCaso+" AND p.cargo = 'Jefe de Unidad' ");
		
		try{
			CasoPorAgente cpa = (CasoPorAgente) qCasos.getSingleResult();
			CasoPorAgente cpaEdit = em.merge(cpa);
			
			Usuario u = new Usuario();
			u.setIdUsuario(idJefeDeUnidad);
			cpaEdit.setUsuario(u);
		}catch (Exception e) {
			CasoPorAgente cpa = new CasoPorAgente();
			cpa.setEstado("habilitado");
			
			CasoCriminal c = new CasoCriminal();
			c.setIdCasoCriminal(idCaso);
			Usuario u = new Usuario();
			u.setIdUsuario(idJefeDeUnidad);
			
			cpa.setCasoCriminal(c);
			cpa.setUsuario(u);
			
			em.persist(cpa);
		}
		
		return getCasosCriminalBean();
	}

	public List<String> getStatusCasoCriminal() {
		List<String> CRs = new ArrayList<String>();		
		String [] states = {"Activo",
							"Diligencias Preliminares",
							"Calificacion Fiscal",
							"Fiscalia Superior",
							"Formalizacion de la Investigacion",
							"Diligencias de la Investigacion",
							"Conclusion de la Investigacion",
							"Pausa por Falta de Documentos",
							"Pausa por Nuevo Caso",
							"Plazo Ampleatorio Investigacion Preliminar",
							"Plazo Ampleatorio Investigacion Formal"};		
		
		for(int i = 0; i < states.length; i++){			
			Query q =em.createQuery("SELECT COUNT(cr.idCasoCriminal) FROM CasoCriminal cr WHERE cr.estado ='"+ states[i] +"'");			
			String number = q.getSingleResult().toString();
			if(number.equals("1")){
				Query qId =em.createQuery("SELECT cr.idCasoCriminal FROM CasoCriminal cr WHERE cr.estado ='"+ states[i] +"'");
				int abc = (Integer) qId.getSingleResult();
				number = Integer.toString(abc)+"-id";
			}
			CRs.add(number);
		}
		return CRs;
	}

	@SuppressWarnings("unchecked")
	public List<CasoCriminalBean> getLastCasosCriminales(HttpSession session) {
		List<CasoCriminalBean> listCR = new ArrayList<CasoCriminalBean>();
		Query q =em.createNativeQuery("SELECT cr.idcasocriminal,cr.codigo FROM casocriminal cr ORDER BY cr.fecCreacion DESC");
		//Query q =em.createNativeQuery("select  cr.idcasocriminal,cr.codigo from casocriminal cr where cr.feccreacion between (CURRENT_TIMESTAMP - interval '15 days') AND (CURRENT_TIMESTAMP)");
		q.setMaxResults(15);
		List<String[]> rowsCR = q.getResultList();
		for (int i = 0; i < rowsCR.size(); i++) {
			CasoCriminalBean crBean = new CasoCriminalBean();
			Object[] obj = rowsCR.get(i);
			crBean.setIdCasoCriminal((Integer)obj[0]);
			crBean.setCodigo((String)obj[1]);
			listCR.add(crBean);
		}
		return listCR;
	}

	@Transactional
	public CasoCriminalBean editarCasoCriminal(CasoCriminal caso) {
		CasoCriminal c = em.find(CasoCriminal.class, caso.getIdCasoCriminal());
		CasoCriminal editadoC = em.merge(c);
		
		editadoC.setAsunto(caso.getAsunto());
		editadoC.setReferencia(caso.getReferencia());
		editadoC.setDescripcion(caso.getDescripcion());
		
		return getCasoCriminalBean(caso.getIdCasoCriminal());
	}

	@Transactional
	public Boolean asignarPersonalPolicial(Integer idCaso, Integer idPolicia, String estado) {
		Query qCasos = em.createQuery("SELECT cpa FROM CasoPorAgente cpa JOIN cpa.casoCriminal c JOIN cpa.usuario u JOIN u.perfil p WHERE c.idCasoCriminal = "+idCaso+" AND u.idUsuario = "+idPolicia+" AND cpa.estado='habilitado' AND (p.cargo = 'Superior' OR p.cargo = 'Investigador')");
		
		try{
			CasoPorAgente cpa = (CasoPorAgente) qCasos.getSingleResult();			
			
			return false;
		}catch (Exception e) {
			
			Query qCasos1 = em.createQuery("SELECT cpa FROM CasoPorAgente cpa JOIN cpa.casoCriminal c JOIN cpa.usuario u JOIN u.perfil p WHERE c.idCasoCriminal = "+idCaso+" AND u.idUsuario = "+idPolicia+" AND cpa.estado='deshabilitado' AND (p.cargo = 'Superior' OR p.cargo = 'Investigador')");
			try{

				//System.err.println("actualiza habilitado");
				CasoPorAgente cpa1 = (CasoPorAgente) qCasos1.getSingleResult();
				CasoPorAgente cpaEdit = em.merge(cpa1);
				
				cpaEdit.setEstado("habilitado");
				return true;
			}catch(Exception e1){

				//System.err.println("crea");
				CasoPorAgente cpa = new CasoPorAgente();
				cpa.setEstado("habilitado");
				
				CasoCriminal c = new CasoCriminal();
				c.setIdCasoCriminal(idCaso);
				Usuario u = new Usuario();
				u.setIdUsuario(idPolicia);
				
				cpa.setCasoCriminal(c);
				cpa.setUsuario(u);
				
				em.persist(cpa);
			
				return true;
			}
		}
		
	}
	
	@Transactional
	public Boolean reAsignarPersonalPolicial(Integer idCaso, Integer idPolicia, String estado) {
		Query qCasos = em.createQuery("SELECT cpa FROM CasoPorAgente cpa JOIN cpa.casoCriminal c JOIN cpa.usuario u JOIN u.perfil p WHERE c.idCasoCriminal = "+idCaso+" AND u.idUsuario = "+idPolicia+" AND cpa.estado='habilitado' AND (p.cargo = 'Superior' OR p.cargo = 'Investigador')");
		
		try{
			//System.err.println("Actualizar");
			CasoPorAgente cpa = (CasoPorAgente) qCasos.getSingleResult();
			CasoPorAgente cpaEdit = em.merge(cpa);
			
			cpaEdit.setEstado(estado);
			return true;
		}catch (Exception e) {
			return false;
		}
		
	}

}
