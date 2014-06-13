package com.sscc.model;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class RutasMapas {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idRuta;
	
	@Column(length = 100, nullable = false)	
	private String inicioLat;
	@Column(length = 100, nullable = true)	
	private String inicioLong;
	@Column(length = 100, nullable = true)	
	private String finLat;
	@Column(length = 100, nullable = true)	
	private String finLong;
	@Column(length = 1000, nullable = true)	
	private String wp;	
	@Column(length = 60, nullable = true)	
	private String nombre;
	@Column(length = 180, nullable = false)
	private String comentarios;
	
	@ManyToOne
	@JoinColumn(name = "idCasoCriminal")
	private CasoCriminal casoCriminal;
	
	
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
	public CasoCriminal getCasoCriminal() {
		return casoCriminal;
	}
	public void setCasoCriminal(CasoCriminal casoCriminal) {
		this.casoCriminal = casoCriminal;
	}
	
	
}
