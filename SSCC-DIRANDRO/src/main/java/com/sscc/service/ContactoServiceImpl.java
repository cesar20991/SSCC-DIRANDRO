package com.sscc.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.CasoCriminalBean;
import com.sscc.form.ContactoBean;
import com.sscc.model.CasoCriminal;
import com.sscc.model.Contactos;
import com.sscc.model.Sospechoso;
import com.sscc.util.DateUtil;

@Service
public class ContactoServiceImpl implements ContactoService{
	
	@PersistenceContext
	EntityManager em;
	
	@SuppressWarnings("unchecked")
	public List<ContactoBean> getContactoPorSospechoso(Integer idSospechoso) {
		List<ContactoBean> comentariosb = new ArrayList<ContactoBean>();
		
		Query qComentarios = em.createQuery("SELECT c FROM Sospechoso s JOIN s.contactos c WHERE c.estado = 'habilitado' AND s.idSospechoso="+idSospechoso);

		List<Contactos> a = qComentarios.getResultList();
		
		for(int i = 0;i < a.size();i++){
			ContactoBean cb = new ContactoBean();
			Contactos contacto = a.get(i);
			cb.setIdContacto(contacto.getIdContacto());
			if(contacto.getApellidoMaterno() == null){
				cb.setApellidoMaterno("");
			}else{
				cb.setApellidoMaterno(contacto.getApellidoMaterno());
			}
			if(contacto.getApellidoPaterno() == null){
				cb.setApellidoPaterno("");
			}else{
				cb.setApellidoPaterno(contacto.getApellidoPaterno());
			}			
			if(contacto.getCelular() == null){
				cb.setCelular("");
			}else{
				cb.setCelular(contacto.getCelular());
			}					
			cb.setCodigo(contacto.getCodigo());
			if(contacto.getCorreoElectronico() == null){
				cb.setCorreoElectronico("");
			}else{
				cb.setCorreoElectronico(contacto.getCorreoElectronico());
			}				
			cb.setDepartamento(contacto.getDepartamento());
			if(contacto.getDireccion() == null){
				cb.setDireccion("");
			}else{
				cb.setDireccion(contacto.getDireccion());
			}			
			cb.setDistrito(contacto.getDistrito());
			if(contacto.getNombres() == null){
				cb.setNombres("");
			}else{
				cb.setNombres(contacto.getNombres());
			}					
			cb.setProvincia(contacto.getProvincia());
			if(contacto.getTelefono() == null){
				cb.setTelefono("");
			}else{
				cb.setTelefono(contacto.getTelefono());
			}				
			
			comentariosb.add(cb);
		}
		
		return comentariosb;
	}
	
	@Transactional
	public Boolean crearContacto(Contactos contactos, Integer idSospechoso){
		//Contactos c = new Contactos();
		Sospechoso s = new Sospechoso();
		
		s.setIdSospechoso(idSospechoso);
		
		contactos.setSospechoso(s);
		DateUtil d = new DateUtil();
		contactos.setFecCreacion(d.hoyTimestamp());
		
		contactos.setEstado("habilitado");
		
		em.persist(contactos);
		
		contactos.setCodigo("CON-"+contactos.getIdContacto());
		return true;
	}
	
	@Transactional
	public Boolean editarContacto(Contactos contacto) {
		Contactos c = em.find(Contactos.class, contacto.getIdContacto());
		Contactos editadoC = em.merge(c);
		
		editadoC.setApellidoMaterno(contacto.getApellidoMaterno());
		editadoC.setApellidoPaterno(contacto.getApellidoPaterno());
		editadoC.setCelular(contacto.getCelular());
		editadoC.setCorreoElectronico(contacto.getCorreoElectronico());
		editadoC.setDepartamento(contacto.getDepartamento());
		editadoC.setDireccion(contacto.getDireccion());
		editadoC.setDistrito(contacto.getDistrito());
		editadoC.setNombres(contacto.getNombres());
		editadoC.setProvincia(contacto.getProvincia());
		editadoC.setTelefono(contacto.getTelefono());
		
		return true;
	}
	
	@Transactional
	public Boolean quitarContacto(Integer idSospechoso, Integer idContacto) {
		Contactos c = em.find(Contactos.class, idContacto);
		Contactos editadoC = em.merge(c);
		
		editadoC.setEstado("deshabilitado");
		
		
		return true;
	}
}
