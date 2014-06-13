package com.sscc.service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Service;

import com.sscc.form.RutasBean;

@Service
public class RutasServiceImpl implements RutasService{

	@PersistenceContext
	EntityManager em;

	public RutasBean getRutasBean(Integer idRuta) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
