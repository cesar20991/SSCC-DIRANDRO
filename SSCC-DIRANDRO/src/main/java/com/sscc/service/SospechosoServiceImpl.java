package com.sscc.service;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.CasoCriminalBean;
import com.sscc.form.PerfilBean;
import com.sscc.form.SospechosoBean;
import com.sscc.model.CasoCriminal;
import com.sscc.model.Perfil;
import com.sscc.model.RasgosParticulares;
import com.sscc.model.Sospechoso;
import com.sscc.model.Usuario;
import com.sscc.util.DateUtil;

@Service
public class SospechosoServiceImpl implements SospechosoService{
	
	@PersistenceContext
	EntityManager em;
	
	@Transactional
	public SospechosoBean getSospechosoBean(Integer idSospechoso) {
		SospechosoBean sb = new SospechosoBean();
		Query qSospechoso = em.createQuery("SELECT s FROM Sospechoso s WHERE s.estado='habilitado' AND s.idSospechoso=:idSospechoso");
		qSospechoso.setParameter("idSospechoso", idSospechoso);
		
		Sospechoso s = new Sospechoso();
		s = (Sospechoso) qSospechoso.getSingleResult();
		
		sb.setTipodocumento(s.getTipodocumento());
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
		sb.setPeligrosidad(s.getPeligrosidad());
		sb.setRol(s.getRol());
		//
		Query qSospechosohomonimo = em.createNativeQuery("SELECT count(s.*)-1 FROM sospechoso s WHERE (s.prenombres || ' ' || s.primerapellido LIKE '%"+s.getPreNombres()+ " " + s.getPrimerApellido() +"%' OR s.prenombres || ' ' || s.primerapellido || ' ' || s.segundoapellido = '%"+ s.getPreNombres()+ " " + s.getPrimerApellido()+ "" +s.getSegundoApellido() +"%' )");
		BigInteger homonimo = (BigInteger) qSospechosohomonimo.getSingleResult();
		sb.setHomonimo(homonimo.intValue());
		//
		return sb;
	}
	

	@SuppressWarnings("unchecked")
	public List<SospechosoBean> getSospechosos() {
		List<SospechosoBean> lsb = new ArrayList<SospechosoBean>(); 
		Query q = em.createQuery("SELECT s FROM Sospechoso s WHERE s.estado='habilitado'");
		List<Sospechoso> ls = q.getResultList();
		
		for(int i=0;i<ls.size();i++){
			Sospechoso s = new Sospechoso();
			SospechosoBean sb = new SospechosoBean();
			s = ls.get(i);
			
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
			
			lsb.add(sb);
		}
		
		return lsb;
	}

	@Transactional
	public Integer crearSospechoso(Sospechoso sospechoso) {
		
		sospechoso.setEstado("habilitado");
		DateUtil d = new DateUtil();
		sospechoso.setFecCreacionSospechoso(d.hoyTimestamp());
		
		if(sospechoso.getFechaDeNacimiento().toString().equals("1000-12-12")){
			sospechoso.setFechaDeNacimiento(null);
		}
		if(sospechoso.getDepartamentoDeNacimiento() == null){
			sospechoso.setDepartamentoDeNacimiento("");
		}
		if(sospechoso.getProvinciaDeNacimiento() == null){
			sospechoso.setProvinciaDeNacimiento("");
		}
		if(sospechoso.getDistritoDeNacimiento() == null){
			sospechoso.setDistritoDeNacimiento("");
		}
		if(sospechoso.getGradoDeInstruccion()== null){
			sospechoso.setGradoDeInstruccion("");
		}
		if(sospechoso.getEstatura()== null){
			sospechoso.setEstatura(0.0);
		}
		//if(sospechoso.getFechaDeInscripcion().toString().equals("1000-12-12")){
			sospechoso.setFechaDeInscripcion(null);
		//}
		if(sospechoso.getNombrePadre()== null){
			sospechoso.setNombrePadre("");
		}
		if(sospechoso.getNombreMadre()== null){
			sospechoso.setNombreMadre("");
		}
		
		//if(sospechoso.getFechaDeEmision().toString().equals("1000-12-12")){
			sospechoso.setFechaDeEmision(null);
		//}
		if(sospechoso.getRestriccion()== null){
			sospechoso.setRestriccion("");
		}
		if(sospechoso.getDomicilio()== null){
			sospechoso.setDomicilio("");
		}
		if(sospechoso.getDepartamentoDeDomicilio()== null){
			sospechoso.setDepartamentoDeDomicilio("");
		}
		if(sospechoso.getProvinciaDeDomicilio()==null){
			sospechoso.setProvinciaDeDomicilio("");
		}
		if(sospechoso.getDistritoDeDomicilio()==null){
			sospechoso.setDistritoDeDomicilio("");
		}
		if(sospechoso.getMultasElectorales()==null){
			sospechoso.setMultasElectorales(0);
		}
		if(sospechoso.getPeligrosidad()==null){
			sospechoso.setPeligrosidad("");
		}
		
		em.persist(sospechoso);
		sospechoso.setCodigo("SPO-"+sospechoso.getIdSospechoso());
		RasgosParticulares rp = new RasgosParticulares();
		em.persist(rp);
		sospechoso.setRasgosParticulares(rp);
		
		return sospechoso.getIdSospechoso();
	}

	@Transactional
	public SospechosoBean editSospechosoBean(Sospechoso sospechoso) {
		Sospechoso s = em.find(Sospechoso.class, sospechoso.getIdSospechoso());
		Sospechoso editado = em.merge(s);
		
		//no te olvides poner la validacion del 1000-12-12
		editado.setTipodocumento(sospechoso.getTipodocumento());
		editado.setCodigoUnicoDeIdentificacion(sospechoso.getCodigoUnicoDeIdentificacion());
		editado.setPrimerApellido(sospechoso.getPrimerApellido());
		editado.setSegundoApellido(sospechoso.getSegundoApellido());
		editado.setPreNombres(sospechoso.getPreNombres());
		editado.setAlias(sospechoso.getAlias());
		editado.setSexo(sospechoso.getSexo());
		if(sospechoso.getFechaDeNacimiento().toString().equals("1000-12-12")){
			editado.setFechaDeNacimiento(null);
		}else{
			editado.setFechaDeNacimiento(sospechoso.getFechaDeNacimiento());
		}
		editado.setDepartamentoDeNacimiento(sospechoso.getDepartamentoDeNacimiento());
		editado.setProvinciaDeNacimiento(sospechoso.getProvinciaDeNacimiento());
		editado.setDistritoDeNacimiento(sospechoso.getDistritoDeNacimiento());
		editado.setGradoDeInstruccion(sospechoso.getGradoDeInstruccion());
		editado.setEstadoCivil(sospechoso.getEstadoCivil());
		editado.setEstatura(sospechoso.getEstatura());
		//editado 22/05/14
//		if(sospechoso.getFechaDeInscripcion().toString().equals("1000-12-12")){
			editado.setFechaDeInscripcion(null);
//		}else{
//			editado.setFechaDeInscripcion(sospechoso.getFechaDeInscripcion());
//		}
		editado.setNombrePadre(sospechoso.getNombrePadre());
		editado.setNombreMadre(sospechoso.getNombreMadre());
		//editado.setFechaDeEmision(sospechoso.getFechaDeEmision());
//		if(sospechoso.getFechaDeEmision().toString().equals("1000-12-12")){
			editado.setFechaDeEmision(null);
//		}else{
//			editado.setFechaDeEmision(sospechoso.getFechaDeEmision());
//		}
		editado.setRestriccion(sospechoso.getRestriccion());
		editado.setDomicilio(sospechoso.getDomicilio());
		editado.setDepartamentoDeDomicilio(sospechoso.getDepartamentoDeDomicilio());
		editado.setProvinciaDeDomicilio(sospechoso.getProvinciaDeDomicilio());
		editado.setDistritoDeDomicilio(sospechoso.getDistritoDeDomicilio());
		editado.setMultasElectorales(sospechoso.getMultasElectorales());
		editado.setPeligrosidad(sospechoso.getPeligrosidad());
		
		return getSospechosoBean(editado.getIdSospechoso());
	}

	@Transactional
	public SospechosoBean editSospechosoDatosContacto(Sospechoso sospechoso, String[] correos, String[] telefonos, String[] celulares, String[] direcciones) {
		//concateno valores en strings
		String correo="", telefono="", celular="", direccion="";
		for(int i = 0; i < correos.length; i++){
			if(i==(correos.length-1)){
				correo += correos[i];
			}else{
				correo += correos[i] + ", ";
			}
		}
		for(int i = 0; i < telefonos.length; i++){
			if(i==(telefonos.length-1)){
				telefono += telefonos[i];
			}else{
				telefono += telefonos[i] + ", ";
			}
		}
		for(int i = 0; i < celulares.length; i++){
			if(i==(celulares.length-1)){
				celular += celulares[i];
			}else{
				celular += celulares[i] + ", ";
			}
		}
		for(int i = 0; i < direcciones.length; i++){
			if(i==(direcciones.length-1)){
				direccion += direcciones[i];
			}else{
				direccion += direcciones[i] + ", ";
			}
		}
		//edito al sospechoso
		Sospechoso s = em.find(Sospechoso.class, sospechoso.getIdSospechoso());
		Sospechoso editado = em.merge(s);
		editado.setCorreos(correo);
		editado.setCelulares(celular);
		editado.setDirecciones(direccion);
		editado.setTelefonos(telefono);		
		
		return getSospechosoBean(editado.getIdSospechoso());
	}

	public Boolean getAlias(String alias) {
		Query queryCont = em.createQuery("SELECT COUNT(s) FROM Sospechoso s WHERE s.alias LIKE:alias");
		queryCont.setParameter("alias",alias);
		Integer cont = Integer.parseInt(queryCont.getSingleResult().toString());
		//System.err.println("contador: "+cont);
		return cont > 0 ? true : false;
	}

	public Boolean getCUI(String codigoUnicoDeIdentificacion) {
		Query queryCont = em.createQuery("SELECT COUNT(s) FROM Sospechoso s WHERE s.codigoUnicoDeIdentificacion =:codigoUnicoDeIdentificacion");
		queryCont.setParameter("codigoUnicoDeIdentificacion", codigoUnicoDeIdentificacion);
		Integer cont = Integer.parseInt(queryCont.getSingleResult().toString());
		return cont > 0 ? true : false;
	}


	public List<CasoCriminalBean> getCasosDelSospechoso(Integer idSospechoso) {
		List<CasoCriminalBean> listCR = new ArrayList<CasoCriminalBean>();
		Query query = em.createQuery("SELECT c FROM CasoPorSospechoso cps JOIN cps.sospechoso s JOIN cps.casoCriminal c WHERE s.idSospechoso="+idSospechoso+" AND cps.estado='habilitado'");
		
		List<CasoCriminal> cc = query.getResultList();
		for(int i=0;i<cc.size();i++){
			CasoCriminalBean cb = new CasoCriminalBean();
			CasoCriminal c = cc.get(i);
			Perfil p = c.getUsuario().getPerfil();
			Usuario u = c.getUsuario();
			cb.setIdCasoCriminal(c.getIdCasoCriminal());
			cb.setAsunto(c.getAsunto());
			cb.setCodigo(c.getCodigo());
			cb.setCorreoElectronico(u.getContrasena());
			cb.setDescripcion(c.getDescripcion());
			cb.setImportancia(c.getImportancia());
			cb.setEstado(c.getEstado());
			cb.setFecCreacion(c.getFecCreacion());
			cb.setIdCasoCriminal(c.getIdCasoCriminal());
			cb.setNombreCompleto(p.getPrimerNombre()+" "+p.getSegundoNombre()+" "+p.getApePaterno()+" "+p.getApeMaterno());
			cb.setReferencia(c.getReferencia());
			cb.setTipoFiscal(p.getTipoFiscal());
			cb.setIdPerfil(p.getIdPerfil());
			listCR.add(cb);
		}
		
		return listCR;
	}


	public List<SospechosoBean> getSospechososBuscar() {
		List<SospechosoBean> sbl = new ArrayList<SospechosoBean>();
		Query query = em.createQuery("SELECT s FROM Sospechoso s WHERE s.estado='habilitado' ");
		
		List<Sospechoso> sl = query.getResultList();
		for(int i=0;i<sl.size();i++){
			SospechosoBean sb = new SospechosoBean();
			Sospechoso s = sl.get(i);
			RasgosParticulares rp = s.getRasgosParticulares();
			sb.setAlias(s.getAlias());
			sb.setCelulares(s.getCelulares());
			sb.setCicatrices(rp.getCicatrices());
			sb.setCodigo(s.getCodigo());
			sb.setCodigoUnicoDeIdentificacion(s.getCodigoUnicoDeIdentificacion());
			sb.setCorreos(s.getCorreos());
			sb.setDeficiencias(rp.getDeficiencias());
			sb.setDepartamentoDeDomicilio(s.getDepartamentoDeDomicilio());
			sb.setDepartamentoDeNacimiento(s.getDepartamentoDeNacimiento());
			sb.setDirecciones(s.getDirecciones());
			sb.setDistritoDeDomicilio(s.getDistritoDeDomicilio());
			sb.setDistritoDeNacimiento(s.getDistritoDeNacimiento());
			sb.setDomicilio(s.getDomicilio());
			sb.setEstadoCivil(s.getEstadoCivil());
			sb.setEstatura(s.getEstatura());
			sb.setFechaDeEmision(s.getFechaDeEmision());
			sb.setFechaDeInscripcion(s.getFechaDeInscripcion());
			sb.setFechaDeNacimiento(s.getFechaDeNacimiento());
			sb.setGradoDeInstruccion(s.getGradoDeInstruccion());
			sb.setIdSospechoso(s.getIdSospechoso());
			sb.setLunares(rp.getLunares());
			sb.setMultasElectorales(s.getMultasElectorales());
			sb.setNombreMadre(s.getNombreMadre());
			sb.setNombrePadre(s.getNombrePadre());
			sb.setOtros(rp.getOtros());
			//sb.setPreNombres(s.getPreNombres());
			//sb.setPrimerApellido(s.getPrimerApellido());
			sb.setProvinciaDeDomicilio(s.getProvinciaDeDomicilio());
			sb.setProvinciaDeNacimiento(s.getProvinciaDeNacimiento());
			sb.setRestriccion(s.getRestriccion());
			//sb.setSegundoApellido(s.getSegundoApellido());
			sb.setSexo(s.getSexo());
			sb.setTatuaje(rp.getTatuaje());
			sb.setTelefonos(s.getTelefonos());
			if(s.getUrlSospechoso() == null){
				sb.setUrlSospechoso("img/skills.png");				
			}else{
				sb.setUrlSospechoso(s.getUrlSospechoso());
			}
			sb.setNombreCompleto(s.getPreNombres()+" "+s.getPrimerApellido()+" "+s.getSegundoApellido());
			sb.setPreNombres(s.getPreNombres());
			sb.setPrimerApellido(s.getPrimerApellido());
			sb.setSegundoApellido(s.getSegundoApellido());
			sbl.add(sb);
		}
		return sbl;
	}
	
	public List<SospechosoBean> getSospechososBien(Integer idBien) {
		List<SospechosoBean> sbl = new ArrayList<SospechosoBean>();
		Query query = em.createQuery("SELECT s FROM BienPorSospechoso bps JOIN bps.sospechoso s JOIN bps.bien b "+
										" WHERE s.estado='habilitado' AND bps.estado = 'habilitado' AND b.idBien="+idBien);
		
		List<Sospechoso> sl = query.getResultList();
		for(int i=0;i<sl.size();i++){
			SospechosoBean sb = new SospechosoBean();
			Sospechoso s = sl.get(i);
			RasgosParticulares rp = s.getRasgosParticulares();
			sb.setAlias(s.getAlias());
			sb.setCelulares(s.getCelulares());
			sb.setCicatrices(rp.getCicatrices());
			sb.setCodigo(s.getCodigo());
			sb.setCodigoUnicoDeIdentificacion(s.getCodigoUnicoDeIdentificacion());
			sb.setCorreos(s.getCorreos());
			sb.setDeficiencias(rp.getDeficiencias());
			sb.setDepartamentoDeDomicilio(s.getDepartamentoDeDomicilio());
			sb.setDepartamentoDeNacimiento(s.getDepartamentoDeNacimiento());
			sb.setDirecciones(s.getDirecciones());
			sb.setDistritoDeDomicilio(s.getDistritoDeDomicilio());
			sb.setDistritoDeNacimiento(s.getDistritoDeNacimiento());
			sb.setDomicilio(s.getDomicilio());
			sb.setEstadoCivil(s.getEstadoCivil());
			sb.setEstatura(s.getEstatura());
			sb.setFechaDeEmision(s.getFechaDeEmision());
			sb.setFechaDeInscripcion(s.getFechaDeInscripcion());
			sb.setFechaDeNacimiento(s.getFechaDeNacimiento());
			sb.setGradoDeInstruccion(s.getGradoDeInstruccion());
			sb.setIdSospechoso(s.getIdSospechoso());
			sb.setLunares(rp.getLunares());
			sb.setMultasElectorales(s.getMultasElectorales());
			sb.setNombreMadre(s.getNombreMadre());
			sb.setNombrePadre(s.getNombrePadre());
			sb.setOtros(rp.getOtros());
			//sb.setPreNombres(s.getPreNombres());
			//sb.setPrimerApellido(s.getPrimerApellido());
			sb.setProvinciaDeDomicilio(s.getProvinciaDeDomicilio());
			sb.setProvinciaDeNacimiento(s.getProvinciaDeNacimiento());
			sb.setRestriccion(s.getRestriccion());
			//sb.setSegundoApellido(s.getSegundoApellido());
			sb.setSexo(s.getSexo());
			sb.setTatuaje(rp.getTatuaje());
			sb.setTelefonos(s.getTelefonos());
			if(s.getUrlSospechoso() == null){
				sb.setUrlSospechoso("img/skills.png");				
			}else{
				sb.setUrlSospechoso(s.getUrlSospechoso());
			}
			sb.setNombreCompleto(s.getPreNombres()+" "+s.getPrimerApellido()+" "+s.getSegundoApellido());
			sb.setPreNombres(s.getPreNombres());
			sb.setPrimerApellido(s.getPrimerApellido());
			sb.setSegundoApellido(s.getSegundoApellido());
			sbl.add(sb);
		}
		return sbl;
	}
}