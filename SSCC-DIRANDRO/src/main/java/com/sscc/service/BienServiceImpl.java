package com.sscc.service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.InmuebleBean;
import com.sscc.form.VehiculoBean;
import com.sscc.model.Bien;
import com.sscc.model.Inmueble;
import com.sscc.model.Perfil;
import com.sscc.model.Usuario;
import com.sscc.model.Vehiculo;

@Service
public class BienServiceImpl implements BienService {

	@PersistenceContext
	EntityManager em;

	@Transactional
	public Integer registrarBienVehicular(VehiculoBean vehiculoBean) {
		
		return null;
	}

	@Transactional
	public Integer registrarBienInmueble(InmuebleBean inmuebleBean, Integer idUsuario) {
		
		Inmueble inmueble = new Inmueble();
		Bien bien = new Bien();
		
		Usuario usuario = new Usuario();
		usuario.setIdUsuario(idUsuario);
		
		//Registro del bien
		bien.setDescripcion(texto(inmuebleBean.getDescripcion()));
		bien.setPartidaRegistral(texto(inmuebleBean.getPartidaRegistral()));
		bien.setUsuario(usuario);
		em.persist(bien);
		
		//Registro del inmueble
		inmueble.setBien(bien);
		inmueble.setAreaTotal(dec(inmuebleBean.getAreaTotal()));
		inmueble.setAreaConstruido(dec(inmuebleBean.getAreaConstruido()));
		inmueble.setAreaCercado(dec(inmuebleBean.getAreaCercado()));
		inmueble.setPisos(num(inmuebleBean.getPisos()));
		inmueble.setAmbientes(num(inmuebleBean.getAmbientes()));
		inmueble.setDireccion(texto(inmuebleBean.getDireccion()));
		inmueble.setLatitud(dec(inmuebleBean.getLatitud()));
		inmueble.setLongitud(dec(inmuebleBean.getLongitud()));
		inmueble.setAntiguedad(num(inmuebleBean.getAntiguedad()));
		inmueble.setCodigo("");
		em.persist(inmueble);
		inmueble.setCodigo("IMB-"+inmueble.getIdInmueble());
		
		return inmueble.getIdInmueble();
	}


	public String texto(String texto){
		if( texto == null){
			return "";
		}
		return texto;
	}
	public Integer num(Integer num){
		if(num==null){
			return 0;
		}
		return num;
	}
	
	public Double dec(Double dec){
		if(dec== null){
			return 0.0;
		}
		return dec;
	}

	public InmuebleBean getInmuebleBean(Integer idInmueble) {
		InmuebleBean ib = new InmuebleBean();
		Inmueble i = em.find(Inmueble.class, idInmueble);
		
		Bien b = i.getBien();
		Usuario u = b.getUsuario();
		Perfil p = u.getPerfil();
		
		ib.setIdBien(b.getIdBien());
		ib.setPartidaRegistral(b.getPartidaRegistral());
		ib.setDescripcion(b.getDescripcion());
		ib.setApeMaterno(p.getApeMaterno());
		ib.setApePaterno(p.getApePaterno());
		ib.setSegundoNombre(p.getSegundoNombre());
		ib.setPrimerNombre(p.getPrimerNombre());
		ib.setCorreoElectronico(u.getCorreoElectronico());
		ib.setTipoFiscal(p.getTipoFiscal());
		ib.setIdPerfil(p.getIdPerfil());
		
		ib.setIdInmueble(i.getIdInmueble());
		ib.setCodigo(i.getCodigo());
		ib.setAreaTotal(i.getAreaTotal());
		ib.setAreaConstruido(i.getAreaConstruido());
		ib.setAreaCercado(i.getAreaCercado());
		ib.setPisos(i.getPisos());
		ib.setAmbientes(i.getAmbientes());
		ib.setDireccion(i.getDireccion());
		ib.setLatitud(i.getLatitud());
		ib.setLongitud(i.getLongitud());
		ib.setAntiguedad(i.getAntiguedad());
		System.out.println("IdInmueble = "+ib.getIdInmueble() );
		return ib;
	}

	@Transactional
	public InmuebleBean editInmuebleBean(InmuebleBean ib) {
		System.out.print("IdInmueble = "+ib.getIdInmueble());
		Inmueble i = em.find(Inmueble.class, ib.getIdInmueble());
		
		Inmueble editado = em.merge(i);
		Bien b= editado.getBien();
		b.setPartidaRegistral(ib.getPartidaRegistral());
		b.setDescripcion(ib.getDescripcion());
		editado.setAreaTotal(ib.getAreaTotal());
		editado.setAreaCercado(ib.getAreaCercado());
		editado.setAreaConstruido(ib.getAreaConstruido());
		editado.setPisos(ib.getPisos());
		editado.setAmbientes(ib.getAmbientes());
		editado.setDireccion(ib.getDireccion());
		editado.setAntiguedad(ib.getAntiguedad());
		
		return getInmuebleBean(editado.getIdInmueble());
	}
}
