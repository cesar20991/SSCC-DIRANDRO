package com.sscc.form;

import java.sql.Timestamp;

public class RutasBean {
	
	private Integer idRuta;
	
	private String inicioLat;
	private String inicioLong;
	private String finLat;
	private String finLong;
	private String wp;
	private String nombre;
	private String comentarios;
	private String estado;
	private Timestamp fecCreacion;
	
	
	public Integer getIdRuta() {
		return idRuta;
	}
	public void setIdRuta(Integer idRuta) {
		this.idRuta = idRuta;
	}
	public String getInicioLat() {
		return inicioLat;
	}
	public void setInicioLat(String inicioLat) {
		this.inicioLat = inicioLat;
	}
	public String getInicioLong() {
		return inicioLong;
	}
	public void setInicioLong(String inicioLong) {
		this.inicioLong = inicioLong;
	}
	public String getFinLat() {
		return finLat;
	}
	public void setFinLat(String finLat) {
		this.finLat = finLat;
	}
	public String getFinLong() {
		return finLong;
	}
	public void setFinLong(String finLong) {
		this.finLong = finLong;
	}
	public String getWp() {
		return wp;
	}
	public void setWp(String wp) {
		this.wp = wp;
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
