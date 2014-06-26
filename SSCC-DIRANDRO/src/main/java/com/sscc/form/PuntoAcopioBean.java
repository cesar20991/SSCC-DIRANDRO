package com.sscc.form;

import java.sql.Timestamp;

public class PuntoAcopioBean {
	private Integer idAcopio;
	
	private String latitud;
	private String longitud;
	private String nombre;
	private String comentarios;
	private String estado;
	private Timestamp fecCreacion;
	
	
	
	public Integer getIdAcopio() {
		return idAcopio;
	}
	public void setIdAcopio(Integer idAcopio) {
		this.idAcopio = idAcopio;
	}
	public String getLatitud() {
		return latitud;
	}
	public void setLatitud(String latitud) {
		this.latitud = latitud;
	}
	public String getLongitud() {
		return longitud;
	}
	public void setLongitud(String longitud) {
		this.longitud = longitud;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getComentarios() {
		return comentarios;
	}
	public void setComentarios(String comentarios) {
		this.comentarios = comentarios;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public Timestamp getFecCreacion() {
		return fecCreacion;
	}
	public void setFecCreacion(Timestamp fecCreacion) {
		this.fecCreacion = fecCreacion;
	}
}
