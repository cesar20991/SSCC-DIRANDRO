package com.sscc.service;

import com.sscc.form.SospechosoBean;
import com.sscc.model.RasgosParticulares;
public interface RasgosParticularesService {
	SospechosoBean getRasgosParticulares(Integer idSospechoso);
	SospechosoBean editRasgosParticularesBean(RasgosParticulares rasgosParticulares, Integer idSospechoso);
}
