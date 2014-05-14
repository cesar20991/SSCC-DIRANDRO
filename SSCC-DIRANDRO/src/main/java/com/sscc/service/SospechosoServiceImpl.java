package com.sscc.service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.SospechosoBean;
import com.sscc.model.Sospechoso;
import com.sscc.util.DateUtil;

@Service
public class SospechosoServiceImpl implements SospechosoService{

	@PersistenceContext
	EntityManager em;
	
	@Transactional
	public SospechosoBean getSospechosoBean(Integer idSospechoso) {
		Query qSospechoso = em.createQuery("");
		return null;
	}

	@Transactional
	public SospechosoBean crearSospechoso(Sospechoso sospechoso) {
		SospechosoBean sb=new SospechosoBean();
		
		sospechoso.setEstado("habilitado");
		DateUtil d = new DateUtil();
		sospechoso.setFecCreacionSospechoso(d.hoyTimestamp());
		
		if(sospechoso.getFechaDeNacimiento().equals("1000-12-12")){
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
		if(sospechoso.getEstadoCivil() == " "){
			sospechoso.setEstadoCivil("No precisa");
		}
		if(sospechoso.getEstatura()== null){
			sospechoso.setEstatura(0.0);
		}
		if(sospechoso.getFechaDeInscripcion().equals("100-12-12")){
			sospechoso.setFechaDeInscripcion(null);
		}
		if(sospechoso.getNombrePadre()== null){
			sospechoso.setNombrePadre("");
		}
		if(sospechoso.getNombreMadre()== null){
			sospechoso.setNombreMadre("");
		}
		
		if(sospechoso.getFechaDeEmision().equals("100-12-12")){
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
		
		sb.setCodigoUnicoDeIdentificacion(sospechoso.getCodigoUnicoDeIdentificacion());
		sb.setPrimerApellido(sospechoso.getPrimerApellido());
		sb.setSegundoApellido(sospechoso.getSegundoApellido());
		sb.setPreNombres(sospechoso.getPreNombres());
		sb.setFechaDeNacimiento(sospechoso.getFechaDeNacimiento());
		sb.setDepartamentoDeNacimiento(sospechoso.getDepartamentoDeNacimiento());
		sb.setProvinciaDeNacimiento(sospechoso.getProvinciaDeNacimiento());
		sb.setDistritoDeNacimiento(sospechoso.getDistritoDeNacimiento());
		sb.setGradoDeInstruccion(sospechoso.getGradoDeInstruccion());
		sb.setEstadoCivil(sospechoso.getEstadoCivil());
		sb.setEstatura(sospechoso.getEstatura());
		sb.setFechaDeInscripcion(sospechoso.getFechaDeInscripcion());
		sb.setNombrePadre(sospechoso.getNombrePadre());
		sb.setNombreMadre(sospechoso.getNombreMadre());
		sb.setFechaDeEmision(sospechoso.getFechaDeEmision());
		sb.setRestriccion(sospechoso.getRestriccion());
		sb.setDomicilio(sospechoso.getDomicilio());
		sb.setDepartamentoDeDomicilio(sospechoso.getDepartamentoDeDomicilio());
		sb.setProvinciaDeDomicilio(sospechoso.getProvinciaDeDomicilio());
		sb.setDistritoDeDomicilio(sospechoso.getDistritoDeDomicilio());
		sb.setMultasElectorales(sospechoso.getMultasElectorales());
		
		return sb;
	}

}
