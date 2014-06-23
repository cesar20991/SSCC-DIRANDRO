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
public class Comentario {
	
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idComentario;

	@Column(nullable = false)
	private Integer idEntidad;//de prueba
	@Column(length = 60, nullable = false)	
	private String tipoEntidad;
	@Column(length = 1000, nullable = false)	
	private String comentario;
	@Column(length = 60, nullable = false)	
	private String visibilidad;
	@Column(length = 60, nullable = true)	
	private Timestamp fecCreacion;
	@Column(length = 60, nullable = false)
	private String estado;
	@Column(nullable = false)	
	private Boolean respuesta;
	@Column(nullable = true)
	private Integer idComentarioPadre;
		
	//Referencias
	@ManyToOne
	@JoinColumn(name = "idUsuario")
	private Usuario usuario;

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

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public Boolean getRespuesta() {
		return respuesta;
	}

	public void setRespuesta(Boolean respuesta) {
		this.respuesta = respuesta;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public Integer getIdComentarioPadre() {
		return idComentarioPadre;
	}

	public void setIdComentarioPadre(Integer idComentarioPadre) {
		this.idComentarioPadre = idComentarioPadre;
	}
}
