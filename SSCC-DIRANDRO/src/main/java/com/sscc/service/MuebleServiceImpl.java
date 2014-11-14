package com.sscc.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.MuebleBean;
import com.sscc.model.Mueble;
import com.sscc.model.Perfil;
import com.sscc.model.Usuario;
import com.sscc.util.DateUtil;

@Service
public class MuebleServiceImpl implements MuebleService{

	@PersistenceContext
	EntityManager em;

	@Transactional
	public Integer registrarMueble(MuebleBean mb, Integer IdUsuario) {
		Usuario usuario = new Usuario();
		usuario.setIdUsuario(IdUsuario);
		
		Mueble m = new Mueble();
		//m.setUsuario(usuario);
		m.setDescripcion(get(mb.getDescripcion()));
		//m.setTipo(get(mb.getTipo()));
		//m.setNombreTipo(get(mb.getNombreTipo()));
		m.setValor(get(mb.getValor()));
		m.setEstado("habilitado");
		
		
		DateUtil d = new DateUtil();
		m.setFecCreacion(d.hoyTimestamp());
		
		em.persist(m);
		m.setCodigo("MBL-"+m.getIdMueble());
		
		return m.getIdMueble();
	}

	public MuebleBean getMueble(Integer IdMueble) {
		Mueble m = em.find(Mueble.class, IdMueble);
		MuebleBean mb = new MuebleBean();
		mb.setIdMueble(m.getIdMueble());
		mb.setDescripcion(m.getDescripcion());
		mb.setCodigo(m.getCodigo());
		mb.setValor(m.getValor());
		//mb.setNombreTipo(m.getNombreTipo());
		//mb.setTipo(m.getTipo());
		
		/*//Usuario u = m.getUsuario();
		//Perfil p = u.getPerfil();
		mb.setApeMaterno(p.getApeMaterno());
		mb.setApePaterno(p.getApePaterno());
		mb.setSegundoNombre(p.getSegundoNombre());
		mb.setPrimerNombre(p.getPrimerNombre());
		//mb.setCorreoElectronico(u.getCorreoElectronico());
		mb.setTipoFiscal(p.getTipoFiscal());
		mb.setIdPerfil(p.getIdPerfil());*/
		return mb;
	}

	@Transactional
	public MuebleBean editMueble(MuebleBean mb) {
		Mueble m = em.find(Mueble.class, mb.getIdMueble());
		m = em.merge(m);
		
		m.setDescripcion(get(mb.getDescripcion()));
		//m.setTipo(get(mb.getTipo()));
		//m.setNombreTipo(get(mb.getNombreTipo()));
		m.setValor(get(mb.getValor()));
		m.setEstado(get(mb.getEstado()));
		
		return mb;
	}

	public List<MuebleBean> getMueblesBean() {
		List<MuebleBean> lista = new ArrayList<MuebleBean>();
		Query qMuebles = em.createQuery("SELECT m.idMueble FROM Mueble m WHERE m.estado='habilitado'");
		List<Integer> ids = qMuebles.getResultList();
		for(Integer id : ids){
			Mueble m =  em.find(Mueble.class, id);
			MuebleBean mb = new MuebleBean();
			mb.setIdMueble(m.getIdMueble());
			mb.setDescripcion(m.getDescripcion());
			mb.setCodigo(m.getCodigo());
			mb.setValor(m.getValor());
			//mb.setNombreTipo(m.getNombreTipo());
			//mb.setTipo(m.getTipo());
			
			/*Usuario u = m.getUsuario();
			Perfil p = u.getPerfil();
			mb.setApeMaterno(p.getApeMaterno());
			mb.setApePaterno(p.getApePaterno());
			mb.setSegundoNombre(p.getSegundoNombre());
			mb.setPrimerNombre(p.getPrimerNombre());
			mb.setCorreoElectronico(u.getCorreoElectronico());
			mb.setTipoFiscal(p.getTipoFiscal());
			mb.setIdPerfil(p.getIdPerfil());*/
			
			lista.add(mb);
		}
		return lista;
	}
	
	public Integer get(Integer valor){
		if(valor==null){
			return 0;
		}
		return valor;
	}
	

	public Double get(Double valor){
		if(valor==null){
			return 0.0;
		}
		return valor;
	}
	

	public String get(String valor){
		if(valor==null){
			return "";
		}
		return valor;
	}
	
}
