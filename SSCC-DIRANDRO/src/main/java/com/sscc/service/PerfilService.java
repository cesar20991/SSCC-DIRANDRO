package com.sscc.service;

import java.util.List;

import com.sscc.form.PerfilBean;
import com.sscc.model.Perfil;

public interface PerfilService {
	
	PerfilBean getPerfil(Integer idPerfil);
	
	PerfilBean crearUsuario(Perfil perfil, String correo);
	
	PerfilBean editUsuario(Perfil perfil, String correo);
	
	List<PerfilBean> getJefesDeUnidad();
	
	List<PerfilBean> getPersonalPolicial();
	
	List<PerfilBean> getPersonalPolicialBuscar();
	
	PerfilBean getJefesPorCaso(Integer idCasoCriminal);
	
	List<PerfilBean> getPersonalPolicialPorCaso(Integer idCasoCriminal);
	
	List<PerfilBean> getPersonalPolicial(Integer idCasoCriminal);
	
	Boolean getDni (Integer dni);
	Boolean getNumeroCarnet (Integer numeroDeCarnet);
}