package com.sscc.service;

import java.util.List;

import com.sscc.form.SospechosoBean;
import com.sscc.model.Sospechoso;

public interface SospechosoService {

	SospechosoBean getSospechosoBean(Integer idSospechoso);
	
	List<SospechosoBean> getSospechosos();
	
	Integer crearSospechoso(Sospechoso sospechoso);
	
	SospechosoBean editSospechosoBean(Sospechoso sospechoso);
	
	SospechosoBean editSospechosoDatosContacto(Sospechoso sospechoso, String[] correos, String[] telefonos, String[] celulares, String[] direcciones);
	
	Boolean getAlias(String alias);
	
	Boolean getCUI(String cui);
}