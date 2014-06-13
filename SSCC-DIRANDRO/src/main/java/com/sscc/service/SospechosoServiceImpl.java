package com.sscc.service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.SospechosoBean;
import com.sscc.model.RasgosParticulares;
import com.sscc.model.Sospechoso;
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
		return sb;
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
		if(sospechoso.getFechaDeInscripcion().toString().equals("1000-12-12")){
			sospechoso.setFechaDeInscripcion(null);
		}
		if(sospechoso.getNombrePadre()== null){
			sospechoso.setNombrePadre("");
		}
		if(sospechoso.getNombreMadre()== null){
			sospechoso.setNombreMadre("");
		}
		
		if(sospechoso.getFechaDeEmision().toString().equals("1000-12-12")){
			sospechoso.setFechaDeEmision(null);
		}
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
			sospechoso.setDepartamentoDeDomicilio("");
		}
		if(sospechoso.getDistritoDeDomicilio()==null){
			sospechoso.setDistritoDeDomicilio("");
		}
		if(sospechoso.getMultasElectorales()==null){
			sospechoso.setMultasElectorales(0);
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
		if(sospechoso.getFechaDeInscripcion().toString().equals("1000-12-12")){
			editado.setFechaDeInscripcion(null);
		}else{
			editado.setFechaDeInscripcion(sospechoso.getFechaDeInscripcion());
		}
		editado.setNombrePadre(sospechoso.getNombrePadre());
		editado.setNombreMadre(sospechoso.getNombreMadre());
		//editado.setFechaDeEmision(sospechoso.getFechaDeEmision());
		if(sospechoso.getFechaDeEmision().toString().equals("1000-12-12")){
			editado.setFechaDeEmision(null);
		}else{
			editado.setFechaDeEmision(sospechoso.getFechaDeEmision());
		}
		editado.setRestriccion(sospechoso.getRestriccion());
		editado.setDomicilio(sospechoso.getDomicilio());
		editado.setDepartamentoDeDomicilio(sospechoso.getDepartamentoDeDomicilio());
		editado.setProvinciaDeDomicilio(sospechoso.getProvinciaDeDomicilio());
		editado.setDistritoDeDomicilio(sospechoso.getDistritoDeDomicilio());
		editado.setMultasElectorales(sospechoso.getMultasElectorales());
		
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

	public Boolean getCUI(String cui) {
		Query queryCont = em.createQuery("SELECT COUNT(s) FROM Sospechoso s WHERE s.codigoUnicoDeIdentificacion =:codigoUnicoDeIdentificacion");
		queryCont.setParameter("codigoUnicoDeIdentificacion", cui);
		Integer cont = Integer.parseInt(queryCont.getSingleResult().toString());
		return cont > 0 ? true : false;
	}
}