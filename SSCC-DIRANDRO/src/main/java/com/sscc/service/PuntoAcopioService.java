package com.sscc.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.sscc.form.PuntoAcopioBean;
import com.sscc.model.PuntoAcopio;

@Service
public interface PuntoAcopioService {
	
	PuntoAcopioBean getPuntoAcopioBean(Integer idAcopio);
	
	List<PuntoAcopioBean> getPuntoAcopiosBean(Integer idCasoCriminal);
	
	Boolean guardarAcopio(PuntoAcopio acopio, HttpSession session, Integer idCasoCriminal);

} 
