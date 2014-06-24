package com.sscc.service;

import java.util.List;

import com.sscc.form.MuebleBean;
import com.sscc.model.Mueble;

public interface MuebleService {

	
	Integer registrarMueble(MuebleBean mb, Integer IdUsuario);
	MuebleBean getMueble(Integer IdMueble);
	MuebleBean editMueble(MuebleBean mb);
	
	List<MuebleBean> getMueblesBean();
	
}
