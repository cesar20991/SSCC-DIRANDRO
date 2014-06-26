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
public class PuntoAcopio {
	
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idAcopio;
	
	@Column(length = 100, nullable = false)	
	private String latitud;
	@Column(length = 100, nullable = true)	
	private String longitud;
	@Column(length = 60, nullable = true)	
	private String nombre;
	@Column(length = 180, nullable = true)
	private String comentario;
	@Column(length = 30, nullable = false)
	private String estado;
	@Column(nullable = false)
	private Timestamp fecCreacion;
	
	@ManyToOne
	@JoinColumn(name = "idCasoCriminal")
	private CasoCriminal casoCriminal;
	
	@ManyToOne
	@JoinColumn(name = "idUsuario")
	private Usuario usuario;
	
	
	 
	

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

	public String getComentario() {
		return comentario;
	}

	public void setComentario(String comentario) {
		this.comentario = comentario;
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

	public CasoCriminal getCasoCriminal() {
		return casoCriminal;
	}

	public void setCasoCriminal(CasoCriminal casoCriminal) {
		this.casoCriminal = casoCriminal;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}	
	
	
}
