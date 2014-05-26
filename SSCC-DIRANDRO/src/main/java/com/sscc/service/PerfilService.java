package com.sscc.service;

import java.util.List;

import com.sscc.form.PerfilBean;
import com.sscc.model.Perfil;

public interface PerfilService {
	
	PerfilBean getPerfil(Integer idPerfil);
	
	PerfilBean crearUsuario(Perfil perfil, String correo);
	
	List<PerfilBean> getJefesDeUnidad();
}
