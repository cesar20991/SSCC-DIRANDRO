package com.sscc.service;

import com.sscc.form.PerfilBean;
import com.sscc.model.Perfil;

public interface PerfilService {
	
	PerfilBean getPerfil(Integer idPerfil);
	
	PerfilBean crearUsuario(Perfil perfil, String correo);

}
