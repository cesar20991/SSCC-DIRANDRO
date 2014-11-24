package com.sscc.service;

import java.util.List;

import com.sscc.form.ContactoBean;
import com.sscc.model.Contactos;

public interface ContactoService {

	List<ContactoBean> getContactoPorSospechoso(Integer idSospechoso);
	
	Boolean crearContacto(Contactos contactos, Integer idSospechoso);
	
	Boolean editarContacto(Contactos contacto);
	
	Boolean quitarContacto(Integer idSospechoso, Integer idContacto);
}
