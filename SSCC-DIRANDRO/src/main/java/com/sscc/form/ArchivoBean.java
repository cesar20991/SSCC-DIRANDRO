package com.sscc.form;

import java.sql.Timestamp;

public class ArchivoBean {
	
	private Integer idArchivo;
	
	private Integer idEntidad;
	
	private String tipoEntidad;	
	private String nombreArchivo;	
	private String tipo;
	private String tipoArchivo;	
	private String url;	
	private Long tamanio;	
	private Timestamp fecCreacion;
	private String estado;	
	private String descripcion;
	private String tituloArchivo;
	
	public Integer getIdArchivo() {
		return idArchivo;
	}
	public void setIdArchivo(Integer idArchivo) {
		this.idArchivo = idArchivo;
	}
	public Integer getIdEntidad() {
		return idEntidad;
	}
	public void setIdEntidad(Integer idEntidad) {
		this.idEntidad = idEntidad;
	}
	public String getTipoEntidad() {
		return tipoEntidad;
	}
	public void setTipoEntidad(String tipoEntidad) {
		this.tipoEntidad = tipoEntidad;
	}
	public String getNombreArchivo() {
		return nombreArchivo;
	}
	public void setNombreArchivo(String nombreArchivo) {
		this.nombreArchivo = nombreArchivo;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getTipoArchivo() {
		return tipoArchivo;
	}
	public void setTipoArchivo(String tipoArchivo) {
		this.tipoArchivo = tipoArchivo;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Long getTamanio() {
		return tamanio;
	}
	public void setTamanio(Long tamanio) {
		this.tamanio = tamanio;
	}
	public Timestamp getFecCreacion() {
		return fecCreacion;
	}
	public void setFecCreacion(Timestamp fecCreacion) {
		this.fecCreacion = fecCreacion;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getTituloArchivo() {
		return tituloArchivo;
	}
	public void setTituloArchivo(String tituloArchivo) {
		this.tituloArchivo = tituloArchivo;
	}
	
}
