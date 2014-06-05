package com.sscc.service;

import com.sscc.form.InmuebleBean;
import com.sscc.form.VehiculoBean;
import com.sscc.model.Bien;
import com.sscc.model.Inmueble;
import com.sscc.model.Vehiculo;

public interface BienService {

	Integer registrarBienVehicular(VehiculoBean vehiculoBean);
	Integer registrarBienInmueble(InmuebleBean inmuebleBean, Integer idUsuario);
	InmuebleBean getInmuebleBean(Integer idInmueble);
	InmuebleBean editInmuebleBean(InmuebleBean inmuebleBean);
}
