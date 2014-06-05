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

	// Registro de bienes vehiculares
	@Transactional
	public Integer registrarBienVehicular(VehiculoBean vb, Integer idUsuario) {
		Vehiculo vehiculo = new Vehiculo();
		Bien bien = new Bien();
		
		Usuario usuario = new Usuario();
		usuario.setIdUsuario(idUsuario);
		
		// Registro del bien
		bien.setDescripcion(vb.getDescripcion());
		bien.setPartidaRegistral(vb.getPartidaRegistral());
		bien.setUsuario(usuario);
		em.persist(bien);
		
		// Registro del vehiculo
		vehiculo.setBien(bien);
		vehiculo.setAltura(dec(vb.getAltura()));
		vehiculo.setAncho(dec(vb.getAncho()));
		vehiculo.setLongitud(dec(vb.getLongitud()));
		vehiculo.setPesoBruto(dec(vb.getPesoBruto()));
		vehiculo.setPesoNeto(dec(vb.getPesoNeto()));
		vehiculo.setPlaca(texto(vb.getPlaca()));
		vehiculo.setMarca(texto(vb.getMarca()));
		vehiculo.setModelo(texto(vb.getModelo()));
		vehiculo.setChasis(texto(vb.getChasis()));
		vehiculo.setMotor(texto(vb.getMotor()));
		vehiculo.setRuedas(num(vb.getRuedas()));
		vehiculo.setEjes(num(vb.getEjes()));
		vehiculo.setPasajeros(num(vb.getPasajeros()));
		vehiculo.setAsientos(num(vb.getAsientos()));
		vehiculo.setColor(texto(vb.getColor()));
		if(vb.getFecFabricacion().toString().equals("1000-12-12")){
			vehiculo.setFecFabricacion(null);
		}else{
			vehiculo.setFecFabricacion(vb.getFecFabricacion());
		}
		em.persist(vehiculo);
		
		vehiculo.setCodigo("VHC-"+vehiculo.getIdVehiculo());
		return vehiculo.getIdVehiculo();
	}
	
	public VehiculoBean getVehiculoBean(Integer idVehiculo){
		VehiculoBean vb = new VehiculoBean();
		Vehiculo v = em.find(Vehiculo.class, idVehiculo);
		
		Bien b = v.getBien();
		Usuario u = b.getUsuario();
		Perfil p = u.getPerfil();
		
		vb.setIdBien(b.getIdBien());
		vb.setPartidaRegistral(b.getPartidaRegistral());
		vb.setDescripcion(b.getDescripcion());
		vb.setApeMaterno(p.getApeMaterno());
		vb.setApePaterno(p.getApePaterno());
		vb.setSegundoNombre(p.getSegundoNombre());
		vb.setPrimerNombre(p.getPrimerNombre());
		vb.setCorreoElectronico(u.getCorreoElectronico());
		vb.setTipoFiscal(p.getTipoFiscal());
		vb.setIdPerfil(p.getIdPerfil());
		
		vb.setIdVehiculo(v.getIdVehiculo());
		vb.setCodigo(v.getCodigo());
		vb.setAltura(v.getAltura());
		vb.setAncho(v.getAncho());
		vb.setAltura(v.getAltura());
		vb.setPesoBruto(v.getPesoBruto());
		vb.setPesoNeto(v.getPesoNeto());
		vb.setPlaca(v.getPlaca());
		vb.setMarca(v.getMarca());
		vb.setModelo(v.getModelo());
		vb.setChasis(v.getChasis());
		vb.setMotor(v.getMotor());
		vb.setRuedas(v.getRuedas());
		vb.setEjes(v.getEjes());
		vb.setPasajeros(v.getPasajeros());
		vb.setAsientos(v.getAsientos());
		vb.setColor(v.getColor());
		vb.setFecFabricacion(v.getFecFabricacion());
		
		return vb;
	}
	
	public VehiculoBean editVehiculoBean(VehiculoBean vb){
		Vehiculo v = em.find(Vehiculo.class, vb.getIdVehiculo());
		Vehiculo editado = em.merge(v);
		
		Bien b = editado.getBien();
		b.setPartidaRegistral(vb.getPartidaRegistral());
		b.setDescripcion(vb.getDescripcion());
		editado.setAltura(dec(vb.getAltura()));
		editado.setAncho(dec(vb.getAncho()));
		editado.setLongitud(dec(vb.getLongitud()));
		editado.setPesoBruto(dec(vb.getPesoBruto()));
		editado.setPesoNeto(dec(vb.getPesoNeto()));
		editado.setPlaca(texto(vb.getPlaca()));
		editado.setMarca(texto(vb.getMarca()));
		editado.setModelo(texto(vb.getModelo()));
		editado.setChasis(texto(vb.getChasis()));
		editado.setMotor(texto(vb.getMotor()));
		editado.setRuedas(num(vb.getRuedas()));
		editado.setEjes(num(vb.getEjes()));
		editado.setPasajeros(num(vb.getPasajeros()));
		editado.setAsientos(num(vb.getAsientos()));
		editado.setColor(texto(vb.getColor()));
		editado.setFecFabricacion(vb.getFecFabricacion());
		
		return getVehiculoBean(editado.getIdVehiculo());
	}
	
	// Registro de bienes inmuebles
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
	
	
	// Metodos reutilizables
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
}
