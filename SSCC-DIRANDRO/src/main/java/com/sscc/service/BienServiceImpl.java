package com.sscc.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sscc.form.BienBean;
import com.sscc.form.InmuebleBean;
import com.sscc.form.MuebleBean;
import com.sscc.form.VehiculoBean;
import com.sscc.model.Bien;
import com.sscc.model.BienPorSospechoso;
import com.sscc.model.CasoCriminal;
import com.sscc.model.CasoPorAgente;
import com.sscc.model.Inmueble;
import com.sscc.model.Mueble;
import com.sscc.model.Perfil;
import com.sscc.model.Sospechoso;
import com.sscc.model.Usuario;
import com.sscc.model.Vehiculo;
import com.sscc.util.DateUtil;

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
		bien.setDescripcion(texto(vb.getDescripcion()));
		bien.setValor(dec(vb.getValor()));
		bien.setPartidaRegistral(texto(vb.getPartidaRegistral()));
		bien.setUsuario(usuario);
		DateUtil d = new DateUtil();
		bien.setFecCreacion(d.hoyTimestamp());

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
		if (vb.getFecFabricacion().toString().equals("1000-12-12")) {
			vehiculo.setFecFabricacion(null);
		} else {
			vehiculo.setFecFabricacion(vb.getFecFabricacion());
		}
		vehiculo.setCodigo("");
		em.persist(vehiculo);

		vehiculo.setCodigo("VHC-" + vehiculo.getIdVehiculo());
		return vehiculo.getIdVehiculo();
	}

	public VehiculoBean getVehiculoBean(Integer idVehiculo) {
		VehiculoBean vb = new VehiculoBean();
		Vehiculo v = em.find(Vehiculo.class, idVehiculo);

		Bien b = v.getBien();
		Usuario u = b.getUsuario();
		Perfil p = u.getPerfil();

		vb.setIdBien(b.getIdBien());
		vb.setValor(b.getValor());
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
		vb.setLongitud(v.getLongitud());
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
		vb.setUrlVehiculo(v.getUrlVehiculo());

		return vb;
	}

	@Transactional
	public VehiculoBean editVehiculoBean(VehiculoBean vb) {
		Vehiculo v = em.find(Vehiculo.class, vb.getIdVehiculo());
		Vehiculo editado = em.merge(v);

		Bien b = editado.getBien();
		b.setValor(dec(vb.getValor()));
		b.setPartidaRegistral(texto(vb.getPartidaRegistral()));
		b.setDescripcion(texto(vb.getDescripcion()));
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
		if (vb.getFecFabricacion().toString().equals("1000-12-12")) {
			editado.setFecFabricacion(null);
		} else {
			editado.setFecFabricacion(vb.getFecFabricacion());
		}
		return getVehiculoBean(editado.getIdVehiculo());
	}

	// Registro de bienes inmuebles
	@Transactional
	public Integer registrarBienInmueble(InmuebleBean inmuebleBean,
			Integer idUsuario) {

		Inmueble inmueble = new Inmueble();
		Bien bien = new Bien();

		Usuario usuario = new Usuario();
		usuario.setIdUsuario(idUsuario);

		// Registro del bien
		bien.setValor(dec(inmuebleBean.getValor()));
		bien.setDescripcion(texto(inmuebleBean.getDescripcion()));
		bien.setPartidaRegistral(texto(inmuebleBean.getPartidaRegistral()));
		bien.setUsuario(usuario);
		DateUtil d = new DateUtil();
		bien.setFecCreacion(d.hoyTimestamp());
		em.persist(bien);

		// Registro del inmueble
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
		inmueble.setCodigo("IMB-" + inmueble.getIdInmueble());

		return inmueble.getIdInmueble();
	}

	public InmuebleBean getInmuebleBean(Integer idInmueble) {
		InmuebleBean ib = new InmuebleBean();
		Inmueble i = em.find(Inmueble.class, idInmueble);

		Bien b = i.getBien();
		Usuario u = b.getUsuario();
		Perfil p = u.getPerfil();

		ib.setIdBien(b.getIdBien());
		ib.setValor(b.getValor());
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
		ib.setUrlInmueble(i.getUrlInmueble());
		System.out.println("IdInmueble = " + ib.getIdInmueble());
		return ib;
	}

	@Transactional
	public InmuebleBean editInmuebleBean(InmuebleBean ib) {
		Inmueble i = em.find(Inmueble.class, ib.getIdInmueble());

		Inmueble editado = em.merge(i);

		Bien b = editado.getBien();
		b.setValor(ib.getValor());
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

	// obtener listado de bienes
	/*@SuppressWarnings("unchecked")
	public List<BienBean> getBienesBean() {
		List<BienBean> lBien = new ArrayList<BienBean>();
		Query qBienes = em.createQuery("SELECT b.idBien FROM Bien b");
		List<Integer> lista = qBienes.getResultList();
		System.out.println("Tamaño =" + lista.size());
		for (int i = 0; i < lista.size(); i++) {
			Integer b = lista.get(i);
			Bien bien = em.find(Bien.class, (b));
			BienBean bb = new BienBean();
			bb.setIdBien(bien.getIdBien());
			bb.setPartidaRegistral(bien.getPartidaRegistral());
			bb.setValor(bien.getValor());
			if (bien.getInmueble() != null) {
				bb.setTipoBien(1);
				bb.setCodigo(bien.getInmueble().getCodigo());
				bb.setTipo("Inmueble");
			} else if (bien.getVehiculo() != null) {
				bb.setTipoBien(2);
				bb.setCodigo(bien.getVehiculo().getCodigo());
				bb.setTipo("Vehiculo");
			}
			lBien.add(bb);
		}
		return lBien;
	}*/
	@SuppressWarnings("unchecked")
	public List<InmuebleBean> getBienesInmueble() {
		List<InmuebleBean> lBien = new ArrayList<InmuebleBean>();
		Query qBienes = em.createQuery("SELECT b FROM Bien b JOIN b.inmueble i");
		List<Bien> lista = qBienes.getResultList();

		for (int i = 0; i < lista.size(); i++) {
			InmuebleBean bb = new InmuebleBean();
			Bien b = lista.get(i);
			Inmueble in =  b.getInmueble();
			
			bb.setIdBien(b.getIdBien());
			bb.setUrlInmueble(in.getUrlInmueble());
			bb.setIdInmueble(in.getIdInmueble());
			bb.setPartidaRegistral(b.getPartidaRegistral());
			bb.setValor(b.getValor());
			bb.setDescripcion(in.getDireccion());
			bb.setCodigo(in.getCodigo());
			bb.setAreaTotal(in.getAreaTotal());
				
			lBien.add(bb);
		}
		return lBien;
	}
	@SuppressWarnings("unchecked")
	public List<VehiculoBean> getBienesVehiculos() {
		List<VehiculoBean> lBien = new ArrayList<VehiculoBean>();
		Query qBienes = em.createQuery("SELECT b FROM Bien b JOIN b.vehiculo v");
		List<Bien> lista = qBienes.getResultList();

		for (int i = 0; i < lista.size(); i++) {
			VehiculoBean bb = new VehiculoBean();
			Bien b = lista.get(i);
			Vehiculo v =  b.getVehiculo();
			
			bb.setIdBien(b.getIdBien());
			bb.setUrlVehiculo(v.getUrlVehiculo());
			bb.setCodigo(v.getCodigo());
			bb.setPartidaRegistral(b.getPartidaRegistral());
			bb.setIdVehiculo(v.getIdVehiculo());
			bb.setValor(b.getValor());
			bb.setDescripcion(b.getDescripcion());
			bb.setMarca(v.getMarca());
			bb.setModelo(v.getModelo());
				
			lBien.add(bb);
		}
		return lBien;
	}
	
	@SuppressWarnings("unchecked")
	public List<MuebleBean> getBienesMuebles(Integer idSospechoso) {
		List<MuebleBean> lBien = new ArrayList<MuebleBean>();
		Query qBienes = em.createQuery("SELECT m FROM Sospechoso s JOIN s.muebles m WHERE m.estado='habilitado' AND s.idSospechoso = "+idSospechoso);
		List<Mueble> lista = qBienes.getResultList();

		for (int i = 0; i < lista.size(); i++) {
			MuebleBean bb = new MuebleBean();
			Mueble b =  lista.get(i);
			
			bb.setIdMueble(b.getIdMueble());
			bb.setCodigo(b.getCodigo());
			bb.setDescripcion(b.getDescripcion());
			bb.setValor(b.getValor());
			bb.setTipo(b.getTipo());
			bb.setEspecificarTipo(b.getEspecificarTipo());
			bb.setEstadoDeConservasion(b.getEstadoDeConservasion());
				
			lBien.add(bb);
		}
		return lBien;
	}
/*else if (bien.getVehiculo() != null) {
				bb.setTipoBien(2);
				bb.setCodigo(bien.getVehiculo().getCodigo());
				bb.setTipo("Vehiculo");
			}*/
	// Metodos reutilizables
	public String texto(String texto) {
		if (texto == null) {
			return "";
		}
		return texto;
	}

	public Integer num(Integer num) {
		if (num == null) {
			return 0;
		}
		return num;
	}

	public Double dec(Double dec) {
		if (dec == null) {
			return 0.0;
		}
		return dec;
	}

	public Boolean getPartidaRegistral(String partidaRegistral) {
		Query queryCont = em
				.createQuery("SELECT COUNT(b) FROM Bien b WHERE b.partidaRegistral =:partidaRegistral");
		queryCont.setParameter("partidaRegistral", partidaRegistral);
		Integer cont = Integer.parseInt(queryCont.getSingleResult().toString());
		return cont > 0 ? true : false;
	}

	/*@Transactional
	public boolean asignarBienToSospechoso(Integer idBien, Integer idSospechoso) {
		
		try {
			Query q = em
					.createQuery("SELECT bps FROM BienPorSospechoso bps JOIN bps.bien b JOIN bps.sospechoso s WHERE bps.estado='deshabilitado' AND b.idBien="+ idBien + " AND s.idSospechoso=" + idSospechoso);
			BienPorSospechoso bps = (BienPorSospechoso) q.getSingleResult();
			BienPorSospechoso bpsEditado = em.merge(bps);
			bpsEditado.setEstado("habilitado");
		} catch (Exception e) {
			BienPorSospechoso bs = new BienPorSospechoso();
			Bien bien = em.find(Bien.class, idBien);
			System.out.print("ID = " + idSospechoso);
			Sospechoso sospechoso = em.find(Sospechoso.class, idSospechoso);
			bs.setBien(bien);
			bs.setSospechoso(sospechoso);
			bs.setEstado("habilitado");
			em.persist(bs);
		}
		return true;
	}*/
	
	@Transactional
	public Boolean asignarInmueble(Integer idSospechoso, Integer idBien) {
		Query q = em.createQuery("SELECT bps FROM BienPorSospechoso bps JOIN bps.bien b JOIN bps.sospechoso s WHERE bps.estado='habilitado' AND b.idBien="+ idBien + " AND s.idSospechoso=" + idSospechoso);
		try{
			BienPorSospechoso bps = (BienPorSospechoso) q.getSingleResult();			
			
			return false;
		}catch(Exception e){
			Query q1 = em.createQuery("SELECT bps FROM BienPorSospechoso bps JOIN bps.bien b JOIN bps.sospechoso s WHERE bps.estado='habilitado' AND b.idBien="+ idBien + " AND s.idSospechoso=" + idSospechoso);
			try{
				BienPorSospechoso cpa1 = (BienPorSospechoso) q1.getSingleResult();
				BienPorSospechoso cpaEdit = em.merge(cpa1);
				
				cpaEdit.setEstado("habilitado");
				return true;
			}catch(Exception e1){
				BienPorSospechoso cpa = new BienPorSospechoso();
				cpa.setEstado("habilitado");
				
				Sospechoso c = new Sospechoso();
				c.setIdSospechoso(idSospechoso);
				Bien u = new Bien();
				u.setIdBien(idBien);
				
				cpa.setSospechoso(c);
				cpa.setBien(u);
				
				em.persist(cpa);
			
				return true;
			}
		}
	}
	//deshabilitar
	@Transactional
	public Boolean reAsignarInmueble(Integer idSospechoso, Integer idBien, String estado) {
		Query qCasos = em.createQuery("SELECT bps FROM BienPorSospechoso bps JOIN bps.bien b JOIN bps.sospechoso s WHERE bps.estado='habilitado' AND b.idBien="+ idBien + " AND s.idSospechoso=" + idSospechoso);
		
		try{
			//System.err.println("Actualizar");
			BienPorSospechoso cpa = (BienPorSospechoso) qCasos.getSingleResult();
			BienPorSospechoso cpaEdit = em.merge(cpa);
			
			cpaEdit.setEstado(estado);
			return true;
		}catch (Exception e) {
			return false;
		}
		
	}
	
	
	//
	public Boolean getPlaca(String placa) {
		Query queryCont = em.createQuery("SELECT COUNT(v) FROM Vehiculo v WHERE v.placa LIKE:placa");
		queryCont.setParameter("placa", placa);
		Integer cont = Integer.parseInt(queryCont.getSingleResult().toString());
		return cont > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public List<BienBean> getBienesPorSopechoso(Integer idSospechoso) {
		List<BienBean> lBb = new ArrayList<BienBean>();
		System.out.println("Bienes");
		Query qBienes = em .createQuery("SELECT b FROM BienPorSospechoso bps JOIN bps.bien b JOIN bps.sospechoso s WHERE bps.estado='habilitado' AND s.idSospechoso=:idSospechoso ORDER BY  b.fecCreacion DESC");
		qBienes.setParameter("idSospechoso", idSospechoso);

		List<Bien> lB = qBienes.getResultList();
		System.out.println("Bienes = " + lB.size());
		for (Bien b : lB) {
			BienBean bb = new BienBean();
			bb.setIdBien(b.getIdBien());
			bb.setPartidaRegistral(b.getPartidaRegistral());
			bb.setDescripcion(b.getDescripcion());
			bb.setValor(b.getValor());
			if (b.getInmueble() != null) {
				bb.setTipoBien(1);
				bb.setCodigo(b.getInmueble().getCodigo());
				bb.setTipo("Inmueble");
			} else if (b.getVehiculo() != null) {
				bb.setTipoBien(2);
				bb.setCodigo(b.getVehiculo().getCodigo());
				bb.setTipo("Vehiculo");
			}
			lBb.add(bb);
		}

		return lBb;
	}

	@Transactional
	public Boolean desAsignarBienToSospechoso(Integer idSospechoso, Integer idBien) {
		try {
			Query q = em.createQuery("SELECT bps FROM BienPorSospechoso bps JOIN bps.bien b JOIN bps.sospechoso s WHERE bps.estado='habilitado' AND b.idBien="
							+ idBien + " AND s.idSospechoso=" + idSospechoso);
			BienPorSospechoso bps = (BienPorSospechoso) q.getSingleResult();
			BienPorSospechoso bpsEditado = em.merge(bps);
			bpsEditado.setEstado("deshabilitado");
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@SuppressWarnings("unchecked")
	public List<InmuebleBean> getInmueblesBuscar() {
		List<InmuebleBean> lib = new ArrayList<InmuebleBean>();
		Query qBienes = em.createQuery("SELECT b FROM Bien b JOIN b.inmueble i ORDER BY b.fecCreacion DESC");
		List<Bien> lB = qBienes.getResultList();
		
		for(int i=0;i<lB.size();i++){
			InmuebleBean ib = new InmuebleBean();
			Bien b =  lB.get(i);
			Inmueble in =  b.getInmueble();
			
			ib.setAmbientes(in.getAmbientes());
			ib.setAntiguedad(in.getAntiguedad());
			ib.setAreaCercado(in.getAreaCercado());
			ib.setAreaConstruido(in.getAreaConstruido());
			ib.setAreaTotal(in.getAreaTotal());
			ib.setCodigo(in.getCodigo());
			ib.setDescripcion(b.getDescripcion());
			ib.setDireccion(in.getDireccion());
			ib.setIdBien(b.getIdBien());
			ib.setIdInmueble(in.getIdInmueble());
			ib.setLatitud(in.getLatitud());
			ib.setLongitud(in.getLongitud());
			ib.setPartidaRegistral(b.getPartidaRegistral());
			ib.setPisos(in.getPisos());
			ib.setValor(b.getValor());
			if(in.getUrlInmueble() == null){
				ib.setUrlInmueble("img/casaVerde.jpg");
			}else{
				ib.setUrlInmueble(in.getUrlInmueble());
			}
			
			lib.add(ib);
		}		
		
		return lib;
	}
	
	@SuppressWarnings("unchecked")
	public List<InmuebleBean> getInmueblesBuscarPorSospechoso(Integer idSospechoso) {
		List<InmuebleBean> lib = new ArrayList<InmuebleBean>();
		Query qBienes = em.createQuery("SELECT b FROM BienPorSospechoso bps JOIN bps.bien b JOIN b.inmueble i JOIN bps.sospechoso s WHERE s.idSospechoso ="+idSospechoso+" AND bps.estado='habilitado' ORDER BY b.fecCreacion DESC");
		List<Bien> lB = qBienes.getResultList();
		System.err.println("tmañao lista"+lB.size());
		for(int i=0;i<lB.size();i++){
			InmuebleBean ib = new InmuebleBean();
			Bien b =  lB.get(i);
			System.err.println("id"+b.getIdBien());
			Inmueble in =  b.getInmueble();

			ib.setAmbientes(in.getAmbientes());
			ib.setAntiguedad(in.getAntiguedad());
			ib.setAreaCercado(in.getAreaCercado());
			ib.setAreaConstruido(in.getAreaConstruido());
			ib.setAreaTotal(in.getAreaTotal());
			ib.setCodigo(in.getCodigo());
			ib.setDescripcion(b.getDescripcion());
			ib.setDireccion(in.getDireccion());
			ib.setIdBien(b.getIdBien());
			ib.setIdInmueble(in.getIdInmueble());
			ib.setLatitud(in.getLatitud());
			ib.setLongitud(in.getLongitud());
			ib.setPartidaRegistral(b.getPartidaRegistral());
			ib.setPisos(in.getPisos());
			ib.setValor(b.getValor());
			if(in.getUrlInmueble()==null){
				ib.setUrlInmueble("img/casaVerde.jpg");
			}else{
				ib.setUrlInmueble(in.getUrlInmueble());
			}
			
			lib.add(ib);
		}		
		
		return lib;
	}
	
	@SuppressWarnings("unchecked")
	public List<VehiculoBean> getVehiculosBuscar() {
		List<VehiculoBean> lvb = new ArrayList<VehiculoBean>();
		Query qBienes = em.createQuery("SELECT b FROM Bien b JOIN b.vehiculo v ORDER BY b.fecCreacion DESC");
		List<Bien> lB = qBienes.getResultList();
		
		for(int i=0;i<lB.size();i++){
			VehiculoBean vb = new VehiculoBean();
			Bien b =  lB.get(i);
			Vehiculo v =  b.getVehiculo();
			
			vb.setAltura(v.getAltura());
			vb.setAncho(v.getAncho());
			vb.setAsientos(v.getAsientos());
			vb.setChasis(v.getChasis());
			vb.setCodigo(v.getCodigo());
			vb.setColor(v.getColor());
			vb.setDescripcion(b.getDescripcion());
			vb.setEjes(v.getEjes());
			vb.setFecFabricacion(v.getFecFabricacion());
			vb.setIdBien(b.getIdBien());
			vb.setIdVehiculo(v.getIdVehiculo());
			vb.setLongitud(v.getLongitud());
			vb.setMarca(v.getMarca());
			vb.setModelo(v.getModelo());
			vb.setMotor(v.getMotor());
			vb.setPartidaRegistral(b.getPartidaRegistral());
			vb.setPasajeros(v.getPasajeros());
			vb.setPesoBruto(v.getPesoBruto());
			vb.setPesoNeto(v.getPesoNeto());
			vb.setPlaca(v.getPlaca());
			vb.setRuedas(v.getRuedas());
			vb.setValor(b.getValor());
			if(v.getUrlVehiculo() == null){
				vb.setUrlVehiculo("img/timon.jpg");
			}else{
				vb.setUrlVehiculo(v.getUrlVehiculo());
			}			
			
			lvb.add(vb);
		}		
		
		return lvb;
	}
	
	@SuppressWarnings("unchecked")
	public List<VehiculoBean> getVehiculosBuscarPorSospechoso(Integer idSospechoso) {
		List<VehiculoBean> lvb = new ArrayList<VehiculoBean>();
		Query qBienes = em.createQuery("SELECT b FROM BienPorSospechoso bps JOIN bps.bien b JOIN b.vehiculo v JOIN bps.sospechoso s WHERE s.idSospechoso ="+idSospechoso+" AND bps.estado='habilitado' ORDER BY b.fecCreacion DESC");
		List<Bien> lB = qBienes.getResultList();
		
		for(int i=0;i<lB.size();i++){
			VehiculoBean vb = new VehiculoBean();
			Bien b =  lB.get(i);
			Vehiculo v =  b.getVehiculo();
			
			vb.setAltura(v.getAltura());
			vb.setAncho(v.getAncho());
			vb.setAsientos(v.getAsientos());
			vb.setChasis(v.getChasis());
			vb.setCodigo(v.getCodigo());
			vb.setColor(v.getColor());
			vb.setDescripcion(b.getDescripcion());
			vb.setEjes(v.getEjes());
			vb.setFecFabricacion(v.getFecFabricacion());
			vb.setIdBien(b.getIdBien());
			vb.setIdVehiculo(v.getIdVehiculo());
			vb.setLongitud(v.getLongitud());
			vb.setMarca(v.getMarca());
			vb.setModelo(v.getModelo());
			vb.setMotor(v.getMotor());
			vb.setPartidaRegistral(b.getPartidaRegistral());
			vb.setPasajeros(v.getPasajeros());
			vb.setPesoBruto(v.getPesoBruto());
			vb.setPesoNeto(v.getPesoNeto());
			vb.setPlaca(v.getPlaca());
			vb.setRuedas(v.getRuedas());
			vb.setValor(b.getValor());
			if(v.getUrlVehiculo()==null){
				vb.setUrlVehiculo("img/timon.jpg");
			}else{
				vb.setUrlVehiculo(v.getUrlVehiculo());
			}			
			
			lvb.add(vb);
		}		
		
		return lvb;
	}


	public List<MuebleBean> getMueblesBuscar() {
		List<MuebleBean> lBien = new ArrayList<MuebleBean>();
		Query qBienes = em.createQuery("SELECT m FROM Mueble m WHERE m.estado='habilitado' ");
		List<Mueble> lista = qBienes.getResultList();

		for (int i = 0; i < lista.size(); i++) {
			MuebleBean bb = new MuebleBean();
			Mueble b =  lista.get(i);
			
			bb.setIdMueble(b.getIdMueble());
			bb.setCodigo(b.getCodigo());
			bb.setDescripcion(b.getDescripcion());
			bb.setValor(b.getValor());
			bb.setTipo(b.getTipo());
			bb.setEspecificarTipo(b.getEspecificarTipo());
			bb.setEstadoDeConservasion(b.getEstadoDeConservasion());
				
			lBien.add(bb);
		}
		return lBien;
	}
}