package com.sscc.form;

import java.sql.Timestamp;

public class ComentarioBean {

	private Integer idComentario;

	private Integer idEntidad;
	private String tipoEntidad;	
	private String comentario;
	private String visibilidad;
	private Timestamp fecCreacion;
	private Boolean respuesta;
	private Integer idComentarioPadre;
	
	private Integer idUsuario;
	private Integer idPerfil;
	private String nombreCompleto;
	private String urlUsuario;
	
	public Integer getIdComentario() {
		return idComentario;
	}
	public void setIdComentario(Integer idComentario) {
		this.idComentario = idComentario;
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
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public String getVisibilidad() {
		return visibilidad;
	}
	public void setVisibilidad(String visibilidad) {
		this.visibilidad = visibilidad;
	}
	public Timestamp getFecCreacion() {
		return fecCreacion;
	}
	public void setFecCreacion(Timestamp fecCreacion) {
		this.fecCreacion = fecCreacion;
	}
	public Boolean getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(Boolean respuesta) {
		this.respuesta = respuesta;
	}
	public Integer getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(Integer idUsuario) {
		this.idUsuario = idUsuario;
	}
	public String getNombreCompleto() {
		return nombreCompleto;
	}
	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}
	public String getUrlUsuario() {
		return urlUsuario;
	}
	public void setUrlUsuario(String urlUsuario) {
		this.urlUsuario = urlUsuario;
	}
	public Integer getIdPerfil() {
		return idPerfil;
	}
	public void setIdPerfil(Integer idPerfil) {
		this.idPerfil = idPerfil;
	}
	public Integer getIdComentarioPadre() {
		return idComentarioPadre;
	}
	public void setIdComentarioPadre(Integer idComentarioPadre) {
		this.idComentarioPadre = idComentarioPadre;
	}
	
}
