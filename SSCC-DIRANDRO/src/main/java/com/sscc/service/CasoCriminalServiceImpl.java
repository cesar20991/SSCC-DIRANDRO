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
import com.sscc.form.SospechosoBean;
import com.sscc.model.CasoCriminal;
import com.sscc.model.CasoPorSospechoso;
import com.sscc.model.Perfil;
import com.sscc.model.Sospechoso;
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
		if(caso.getImportancia() == null){
			caso.setImportancia("");
		}else{
			caso.setImportancia(caso.getImportancia());
		}
		
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
		cb.setImportancia(c.getImportancia());
		cb.setSegundoNombre(p.getSegundoNombre());
		cb.setTipoFiscal(p.getTipoFiscal());
		cb.setIdPerfil(p.getIdPerfil());
		cb.setFecDiligenciasPre(c.getFecDiligenciasPre());
		cb.setDiasDiligenciasPreliminares(c.getDiasDiligenciasPreliminares());
		cb.setCometarioPausaDoc(c.getCometarioPausaDoc());
		cb.setCometarioPausaNCaso(c.getCometarioPausaNCaso());
		
		return cb;
	}

	@SuppressWarnings("unchecked")
	public List<CasoCriminalBean> getCasosCriminalBean() {
		List<CasoCriminalBean> cbl = new ArrayList<CasoCriminalBean>();
		Query qCasos = em.createQuery("SELECT c.idCasoCriminal, c.codigo, c.referencia, c.importancia FROM CasoCriminal c");
		List<Object[]> c = qCasos.getResultList();

		for(int i = 0; i < c.size(); i++){
			CasoCriminalBean cb = new CasoCriminalBean();
			Object[] cc = c.get(i);
			cb.setIdCasoCriminal((Integer)cc[0]);
			cb.setCodigo((String)cc[1]);
			cb.setReferencia((String)cc[2]);
			if((String)cc[3] != null){
				cb.setImportancia((String)cc[3]);
			}else{
				cb.setImportancia("");
			}			
			cbl.add(cb);
		}
		
		return cbl;
	}
	
	@SuppressWarnings("unchecked")
	public List<CasoCriminalBean> getCasosCriminalBeanPersonal() {
		List<CasoCriminalBean> cbl = new ArrayList<CasoCriminalBean>();
		Query qCasos = em.createQuery("SELECT c.idCasoCriminal, c.codigo, c.referencia, c.importancia FROM CasoCriminal c ");
		List<Object[]> c = qCasos.getResultList();
		for(int i = 0; i < c.size(); i++){
			CasoCriminalBean cb = new CasoCriminalBean();
			Object[] cc = c.get(i);
			cb.setIdCasoCriminal((Integer)cc[0]);
			cb.setCodigo((String)cc[1]);
			cb.setReferencia((String)cc[2]);
			if((String)cc[3] != null){
				cb.setImportancia((String)cc[3]);
			}else{
				cb.setImportancia("");
			}
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
		Query q =em.createNativeQuery("SELECT cr.idcasocriminal,cr.codigo, cr.importancia FROM casocriminal cr ORDER BY cr.fecCreacion DESC");
		//Query q =em.createNativeQuery("select  cr.idcasocriminal,cr.codigo from casocriminal cr where cr.feccreacion between (CURRENT_TIMESTAMP - interval '15 days') AND (CURRENT_TIMESTAMP)");
		q.setMaxResults(15);
		List<String[]> rowsCR = q.getResultList();
		for (int i = 0; i < rowsCR.size(); i++) {
			CasoCriminalBean crBean = new CasoCriminalBean();
			Object[] obj = rowsCR.get(i);
			crBean.setIdCasoCriminal((Integer)obj[0]);
			crBean.setCodigo((String)obj[1]);
			if((String)obj[2] != null){
				crBean.setImportancia((String)obj[2]);
			}else{
				crBean.setImportancia("");
			}
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
		editadoC.setImportancia(caso.getImportancia());
		
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

	@Transactional
	public Boolean crearSospechosoAlCaso(Integer idCaso, Integer idSospechoso) {
		CasoPorSospechoso cps = new CasoPorSospechoso();
		
		CasoCriminal c = new CasoCriminal();
		c.setIdCasoCriminal(idCaso);
		
		Sospechoso s = new Sospechoso();
		s.setIdSospechoso(idSospechoso);
		
		cps.setCasoCriminal(c);
		cps.setSospechoso(s);
		cps.setEstado("habilitado");
		
		em.persist(cps);
	
		return true;
	}
	
	@Transactional
	public Boolean crearSospechosoExistenteAlCaso(Integer idCaso, Integer idSospechoso) {
		boolean result = true;
		Query qSospechoso = em.createQuery("SELECT COUNT(cps.idCasoPorSospechoso) FROM CasoPorSospechoso cps JOIN cps.sospechoso s JOIN cps.casoCriminal c WHERE c.idCasoCriminal ="+idCaso+" AND s.idSospechoso="+idSospechoso+" AND cps.estado='habilitado'");
		Integer count = Integer.parseInt(qSospechoso.getSingleResult().toString());
		if(count == 0){
			CasoPorSospechoso cps = new CasoPorSospechoso();
			
			CasoCriminal c = new CasoCriminal();
			c.setIdCasoCriminal(idCaso);
			
			Sospechoso s = new Sospechoso();
			s.setIdSospechoso(idSospechoso);
			
			cps.setCasoCriminal(c);
			cps.setSospechoso(s);
			cps.setEstado("habilitado");
			System.err.println("CREO");
			em.persist(cps);
		
			result = true;
		}else if(count > 0){
			result = false;
		}
		return result;
	}
	
	@Transactional
	public List<SospechosoBean> getSospechosoPorCaso(Integer idCasoCriminal) {
		List<SospechosoBean> sbl = new ArrayList<SospechosoBean>();
		
		Query qSospechoso = em.createQuery("SELECT s FROM CasoPorSospechoso cps JOIN cps.sospechoso s JOIN cps.casoCriminal c WHERE cps.estado='habilitado' AND c.idCasoCriminal=:idCasoCriminal ORDER BY s.fecCreacionSospechoso DESC");
		qSospechoso.setParameter("idCasoCriminal", idCasoCriminal);
		
		List<Sospechoso> sl = qSospechoso.getResultList();
		
		for(int i=0;i<sl.size();i++){
			SospechosoBean sb = new SospechosoBean();
			Sospechoso s = new Sospechoso();
			s = sl.get(i);
			
			sb.setCodigoUnicoDeIdentificacion(s.getCodigoUnicoDeIdentificacion());
			sb.setPrimerApellido(s.getPrimerApellido());
			sb.setSegundoApellido(s.getSegundoApellido());
			sb.setPreNombres(s.getPreNombres());
			sb.setAlias(s.getAlias());
			sb.setCodigo(s.getCodigo());
			sb.setSexo(s.getSexo());
			sb.setFechaDeNacimiento(s.getFechaDeNacimiento());
			sb.setDepartamentoDeNacimiento(s.getDepartamentoDeNacimiento());
			sb.setProvinciaDeNacimiento(s.getProvinciaDeNacimiento());
			sb.setDistritoDeNacimiento(s.getDistritoDeNacimiento());
			sb.setGradoDeInstruccion(s.getGradoDeInstruccion());
			sb.setEstadoCivil(s.getEstadoCivil());
			sb.setEstatura(s.getEstatura());
			sb.setFechaDeInscripcion(s.getFechaDeInscripcion());
			sb.setNombrePadre(s.getNombrePadre());
			sb.setNombreMadre(s.getNombreMadre());
			sb.setFechaDeEmision(s.getFechaDeEmision());
			sb.setRestriccion(s.getRestriccion());
			sb.setDomicilio(s.getDomicilio());
			sb.setDepartamentoDeDomicilio(s.getDepartamentoDeDomicilio());
			sb.setProvinciaDeDomicilio(s.getProvinciaDeDomicilio());
			sb.setDistritoDeDomicilio(s.getDistritoDeDomicilio());
			sb.setMultasElectorales(s.getMultasElectorales());
			sb.setIdRasgosParticulares(s.getRasgosParticulares().getIdRasgosParticulares());
			sb.setCelulares(s.getCelulares());
			sb.setTelefonos(s.getTelefonos());
			sb.setCorreos(s.getCorreos());
			sb.setDirecciones(s.getDirecciones());
			sb.setUrlSospechoso(s.getUrlSospechoso());
			sb.setIdSospechoso(s.getIdSospechoso());
			sbl.add(sb);
		}
		
		return sbl;
	}

	@Transactional
	public Boolean deshasignarSospechosoDelCaso(Integer idCaso, Integer idSospechoso) {
		try{
			Query q = em.createQuery("SELECT cps FROM CasoPorSospechoso cps JOIN cps.sospechoso s JOIN cps.casoCriminal c WHERE cps.estado='habilitado' AND c.idCasoCriminal="+idCaso+" AND s.idSospechoso="+idSospechoso);
			CasoPorSospechoso cps = (CasoPorSospechoso) q.getSingleResult();
			CasoPorSospechoso cpsEditado = em.merge(cps);
			cpsEditado.setEstado("deshabilitado");
			return true;
		}catch(Exception e){
			return false;
		}
	}

	@Transactional
	public Boolean toDiligenciasPre(CasoCriminal casoCriminal, Integer idCaso) {
		try{
			CasoCriminal c = em.find(CasoCriminal.class, idCaso);
			CasoCriminal cEdit = em.merge(c);

			cEdit.setDiasDiligenciasPreliminares(casoCriminal.getDiasDiligenciasPreliminares());
			cEdit.setEstado("Diligencias Preliminares");
			DateUtil d = new DateUtil();
			cEdit.setFecDiligenciasPre(d.hoyTimestamp());
			return true;
		}catch(Exception e){
			return false;
		}
	}
	
	@Transactional
	public Boolean toPausaDocumentacion(Integer idCaso) {
		try{
			CasoCriminal c = em.find(CasoCriminal.class, idCaso);
			CasoCriminal cEdit = em.merge(c);
			cEdit.setEstadoAnterior(c.getEstado());
			cEdit.setEstado("Pausa por Falta de Documentos");

			return true;
		}catch(Exception e){
			return false;
		}
	}
	
	@Transactional
	public Boolean toPausaNuevoCaso(Integer idCaso) {
		try{
			CasoCriminal c = em.find(CasoCriminal.class, idCaso);
			CasoCriminal cEdit = em.merge(c);
			cEdit.setEstadoAnterior(c.getEstado());
			cEdit.setEstado("Pausa por Nuevo Caso");

			return true;
		}catch(Exception e){
			return false;
		}
	}
	
	@Transactional
	public Boolean removerPausa(Integer idCaso) {
		try{
			CasoCriminal c = em.find(CasoCriminal.class, idCaso);
			CasoCriminal cEdit = em.merge(c);
			cEdit.setEstado(c.getEstadoAnterior());
			cEdit.setEstadoAnterior("");
			cEdit.setCometarioPausaDoc(null);
			cEdit.setCometarioPausaNCaso(null);

			return true;
		}catch(Exception e){
			return false;
		}
	}
	
	@Transactional
	public Boolean comentarioPausaDoc(CasoCriminal casoCriminal, Integer idCaso) {
		try{
			CasoCriminal c = em.find(CasoCriminal.class, idCaso);
			CasoCriminal cEdit = em.merge(c);
			cEdit.setCometarioPausaDoc(casoCriminal.getCometarioPausaDoc());

			return true;
		}catch(Exception e){
			return false;
		}
	}
	
	@Transactional
	public Boolean comentarioPausaNCaso(CasoCriminal casoCriminal, Integer idCaso) {
		try{
			CasoCriminal c = em.find(CasoCriminal.class, idCaso);
			CasoCriminal cEdit = em.merge(c);
			cEdit.setCometarioPausaNCaso(casoCriminal.getCometarioPausaNCaso());

			return true;
		}catch(Exception e){
			return false;
		}
	}
}
