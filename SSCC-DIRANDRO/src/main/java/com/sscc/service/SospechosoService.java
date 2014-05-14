package com.sscc.service;

import com.sscc.form.SospechosoBean;
import com.sscc.model.Sospechoso;

public interface SospechosoService {

	SospechosoBean getSospechosoBean(Integer idSospechoso);
	
	SospechosoBean crearSospechoso(Sospechoso sospechoso);
}
