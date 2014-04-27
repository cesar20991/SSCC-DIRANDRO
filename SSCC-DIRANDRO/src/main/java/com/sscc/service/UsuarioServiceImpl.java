package com.sscc.service;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.model.Usuario;

@Service
public class UsuarioServiceImpl implements UsuarioService {

	@PersistenceContext
	EntityManager em;
	
	//Este Metodo valida al usuario que se logea y crea las sesiones
	@Transactional
	public Boolean login(Usuario usuario, HttpSession session) {
		boolean result;
		Query q = em.createQuery("SELECT u FROM Usuario u WHERE u.correoElectronico =:correoElectronico AND u.contrasena =:contrasena AND u.estado =:estado");
		q.setParameter("correoElectronico", usuario.getCorreoElectronico());
		q.setParameter("contrasena", usuario.getContrasena());
		q.setParameter("estado", "habilitado");
		
		try {
			Usuario us = (Usuario) q.getSingleResult();
			session.setAttribute("idUsuario", us.getIdUsuario());
			//despues de validar al usuario que se logeo saco todos sus datos
			Query qSesiones = em.createQuery("SELECT u FROM Usuario u JOIN u.perfil p WHERE u.idUsuario =:idUsuario AND u.estado =:estadoU AND p.estado =:estadoP ");
			qSesiones.setParameter("idUsuario", us.getIdUsuario());
			qSesiones.setParameter("estadoU", "habilitado");
			qSesiones.setParameter("estadoP", "habilitado");
			// aqui creo sessiones para el usuario que se usaran mientras este logeado
			Usuario usu = (Usuario) qSesiones.getSingleResult();
			session.setAttribute("idPerfil", usu.getPerfil().getIdPerfil());
			session.setAttribute("grado", usu.getPerfil().getGrado());
			session.setAttribute("nombreDeUuario", usu.getPerfil().getPrimerNombre()+" "+usu.getPerfil().getSegundoNombre()+" "+usu.getPerfil().getApePaterno()+" "+usu.getPerfil().getApeMaterno());
			
			result = true;

		} catch (NoResultException nre) {
			result = false;
		}

		return result;
	}
	
}
