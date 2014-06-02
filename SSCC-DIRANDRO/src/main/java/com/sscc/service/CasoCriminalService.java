package com.sscc.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.sscc.form.CasoCriminalBean;
import com.sscc.model.CasoCriminal;

public interface CasoCriminalService {
	
	Integer crearCasoCriminal(CasoCriminal caso, Integer idUsuario);
	
	CasoCriminalBean getCasoCriminalBean(Integer idCaso);
	
	List<CasoCriminalBean> getCasosCriminalBean();
	
	List<CasoCriminalBean> asignarCasoCriminalEditar(Integer idCaso, Integer idJefeDeUnidad);
	
	List<String> getStatusCasoCriminal();
	
	List<CasoCriminalBean> getLastCasosCriminales(HttpSession session);
	
}
