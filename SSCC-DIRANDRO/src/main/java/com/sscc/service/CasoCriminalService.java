package com.sscc.service;

import com.sscc.form.CasoCriminalBean;
import com.sscc.model.CasoCriminal;

public interface CasoCriminalService {
	
	Integer crearCasoCriminal(CasoCriminal caso, Integer idUsuario);
	
	CasoCriminalBean getCasoCriminalBean(Integer idCaso);

}
