package com.sscc.service;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.sscc.form.RutasBean;
import com.sscc.model.RutasMapas;

@Service
public interface RutasService {

	RutasBean getRutaBean(Integer idRuta);
	
	List<RutasBean> getRutasBean(Integer idCasoCriminal);
	
	Boolean guardarRuta(RutasMapas ruta, HttpSession session, Integer idCasoCriminal);
	
}