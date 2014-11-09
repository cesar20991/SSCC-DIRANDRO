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
public class Mueble {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idMueble;

	@Column(nullable=true, length=30)
	private String codigo;
	
	@Column(nullable=true, length=250)
	private String descripcion;
	
	/*@Column(nullable=false)
	private Integer tipo;*/
	
	@Column(nullable=true, length=30)
	private String nombreTipo;
	
	@Column(nullable=true, length=180)
	private String estadoDeConservasion;//bueno, regular, inservible o inoperativo
	
	@Column(nullable=false)
	private Double valor;

	@Column(nullable=false)
	private String estado;
	
	@ManyToOne
	@JoinColumn(name = "idUsuario")
	private Usuario usuario;
	
	@Column(nullable = false)
	private Timestamp fecCreacion;
	
	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public Timestamp getFecCreacion() {
		return fecCreacion;
	}

	public void setFecCreacion(Timestamp fecCreacion) {
		this.fecCreacion = fecCreacion;
	}

	public Integer getIdMueble() {
		return idMueble;
	}

	public void setIdMueble(Integer idMueble) {
		this.idMueble = idMueble;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
/*
	public Integer getTipo() {
		return tipo;
	}

	public void setTipo(Integer tipo) {
		this.tipo = tipo;
	}
*/
	public String getNombreTipo() {
		return nombreTipo;
	}

	public void setNombreTipo(String nombreTipo) {
		this.nombreTipo = nombreTipo;
	}

	public Double getValor() {
		return valor;
	}

	public void setValor(Double valor) {
		this.valor = valor;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getEstadoDeConservasion() {
		return estadoDeConservasion;
	}

	public void setEstadoDeConservasion(String estadoDeConservasion) {
		this.estadoDeConservasion = estadoDeConservasion;
	}
	
	
	
	
}
