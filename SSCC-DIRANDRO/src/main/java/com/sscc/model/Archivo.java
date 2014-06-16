package com.sscc.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Archivo {
	
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idArchivo;
	
	@Column(nullable = false)
	private Integer idEntidad;//de prueba
	
	@Column(length = 60, nullable = false)	
	private String tipoEntidad;
	@Column(length = 180, nullable = true)	
	private String nombreArchivo;
	@Column(length = 60, nullable = true)	
	private String tipo;///por siaca
	@Column(length = 30, nullable = true)	
	private String tipoArchivo;
	@Column(nullable = true)	
	private String url;
	@Column(nullable = true)	
	private Long tamanio;
	@Column(length = 60, nullable = true)	
	private Timestamp fecCreacion;
	@Column(length = 90, nullable = false)
	private String estado;
	@Column(length = 300, nullable = true)	
	private String descripcion;
	@Column(length = 100, nullable = true)	
	private String tituloArchivo;
	
	@ManyToOne
	@JoinColumn(name = "idUsuario")
	private Usuario usuario;
	
	@ManyToOne
	@JoinColumn(name = "idSospechoso")
	private Sospechoso sospechoso;
	
	@ManyToOne
	@JoinColumn(name = "idCasoCriminal")
	private CasoCriminal casoCriminal;
	
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
	public Usuario getUsuario() {
		return usuario;
	}
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	public String getTituloArchivo() {
		return tituloArchivo;
	}
	public void setTituloArchivo(String tituloArchivo) {
		this.tituloArchivo = tituloArchivo;
	}
	public Sospechoso getSospechoso() {
		return sospechoso;
	}
	public void setSospechoso(Sospechoso sospechoso) {
		this.sospechoso = sospechoso;
	}
	public CasoCriminal getCasoCriminal() {
		return casoCriminal;
	}
	public void setCasoCriminal(CasoCriminal casoCriminal) {
		this.casoCriminal = casoCriminal;
	}
	
}
