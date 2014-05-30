package com.sscc.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

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
		Query qCasos = em.createQuery("SELECT c.idCasoCriminal, c.codigo, c.referencia, u.idUsuario, p.primerNombre, p.segundoNombre, p.apePaterno, p.apeMaterno FROM CasoCriminal c LEFT JOIN c.casopa cpa LEFT JOIN cpa.usuario u LEFT JOIN u.perfil p");
		List<Object[]> c = qCasos.getResultList();
		String nom1 ="";
		String nom2 ="";
		String ape1 ="";
		String ape2 ="";
		for(int i = 0; i < c.size(); i++){
			CasoCriminalBean cb = new CasoCriminalBean();
			Object[] cc = c.get(i);
			cb.setIdCasoCriminal((Integer)cc[0]);
			cb.setCodigo((String)cc[1]);
			cb.setReferencia((String)cc[2]);
			cb.setIdUsuario((Integer)cc[3]);
			if((String)cc[4] == null){
				nom1 = "";
			}else{
				nom1 = (String)cc[4];
			}
			if((String)cc[5] == null){
				nom2 = "";
			}else{
				nom2 = (String)cc[5];
			}
			if((String)cc[6] == null){
				ape1 = "";
			}else{
				ape1 = (String)cc[6];
			}
			if((String)cc[7] == null){
				ape2 = "";
			}else{
				ape2 = (String)cc[7];
			}
			cb.setNombreCompleto(nom1+" "+nom2+" "+ape1+" "+ape2);
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

}
