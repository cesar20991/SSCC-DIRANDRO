package com.sscc.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.MuebleBean;
import com.sscc.model.Mueble;
import com.sscc.model.Usuario;

@Service
public class MuebleServiceImpl implements MuebleService{

	@PersistenceContext
	EntityManager em;

	@Transactional
	public Integer registrarMueble(MuebleBean mb, Integer IdUsuario) {
		Usuario Usuario = new Usuario();
		Mueble m = new Mueble();
		m.setDescripcion(mb.getDescripcion());
		return m.getIdMueble();
	}

	public MuebleBean getMueble(Integer IdMueble) {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional
	public MuebleBean editMueble(MuebleBean mb) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<MuebleBean> getMueblesBean() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
}
