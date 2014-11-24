package com.sscc.service;

import java.util.List;

import com.sscc.form.BienBean;
import com.sscc.form.MuebleBean;
import com.sscc.model.Mueble;

public interface MuebleService {

	
	Integer registrarMueble(MuebleBean mb, Integer idSospechoso);
	MuebleBean getMueble(Integer IdMueble);
	MuebleBean editMueble(MuebleBean mb);
	
	List<MuebleBean> getMueblesBean();
	
	Boolean reAsignarMuebleTOSospechoso(Integer idSospechoso, Integer idMueble, String estado);

	Boolean reAsignarCasoTOSospechoso(Integer idSospechoso, Integer idCaso, String estado);
	List<MuebleBean> getMueblePorSopechoso(Integer idSospechoso);
	
}
