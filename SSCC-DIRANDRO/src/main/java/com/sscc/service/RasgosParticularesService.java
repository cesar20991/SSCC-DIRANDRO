package com.sscc.service;

import com.sscc.form.SospechosoBean;
import com.sscc.model.RasgosParticulares;
public interface RasgosParticularesService {
	SospechosoBean getSospechosoBean(Integer idSospechoso);
	SospechosoBean editRasgosParticularesBean(RasgosParticulares rasgosParticulares);
}
