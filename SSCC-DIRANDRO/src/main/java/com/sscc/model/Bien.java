package com.sscc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

@Entity
public class Bien {
	
	@Id @GeneratedValue
	private Integer idBien;

	@Column(length =250, nullable = false)
	private String descripcion;
	
	@Column(length=256, nullable = false)
	private String partidaRegistral;
	
	
	//TODO si no tubiera propietario, como se declara que puede ser null?
	// Propietario del bien
	@ManyToOne
	@JoinColumn(name = "idUsuario")
	private Usuario usuario;
	
	@OneToOne
	@JoinColumn(name = "idSospechoso")
	private Sospechoso sospechoso;	
	
	@OneToOne(mappedBy="bien")
	private Vehiculo vehiculo;
	
	@OneToOne(mappedBy="bien")
	private Inmueble inmueble;

	public Integer getIdBien() {
		return idBien;
	}

	public void setIdBien(Integer idBien) {
		this.idBien = idBien;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getPartidaRegistral() {
		return partidaRegistral;
	}

	public void setPartidaRegistral(String partidaRegistral) {
		this.partidaRegistral = partidaRegistral;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public Sospechoso getSospechoso() {
		return sospechoso;
	}

	public void setSospechoso(Sospechoso sospechoso) {
		this.sospechoso = sospechoso;
	}

	public Vehiculo getVehiculo() {
		return vehiculo;
	}

	public void setVehiculo(Vehiculo vehiculo) {
		this.vehiculo = vehiculo;
	}

	public Inmueble getInmueble() {
		return inmueble;
	}

	public void setInmueble(Inmueble inmueble) {
		this.inmueble = inmueble;
	}
	
	
}
