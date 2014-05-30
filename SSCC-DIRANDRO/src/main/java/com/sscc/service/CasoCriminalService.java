package com.sscc.service;

import java.util.List;

import com.sscc.form.CasoCriminalBean;
import com.sscc.model.CasoCriminal;

public interface CasoCriminalService {
	
	Integer crearCasoCriminal(CasoCriminal caso, Integer idUsuario);
	
	CasoCriminalBean getCasoCriminalBean(Integer idCaso);
	
	List<CasoCriminalBean> getCasosCriminalBean();
	
	List<CasoCriminalBean> asignarCasoCriminalEditar(Integer idCaso, Integer idJefeDeUnidad);

}
