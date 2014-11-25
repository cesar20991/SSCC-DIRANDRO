package com.sscc.service;

import java.util.List;

import com.sscc.form.ComisoBean;
import com.sscc.model.Comiso;

public interface ComisoService {

	List<ComisoBean> getComisosDelCaso(Integer idCaso);
	
	Boolean crearComiso(Comiso comiso, Integer idCaso);
	
	Boolean quitarComiso(Integer idCaso, Integer idComiso);
	
}
