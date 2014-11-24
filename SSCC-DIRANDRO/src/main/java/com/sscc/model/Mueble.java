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
	
	@Column(nullable=true, length=150)
	private String tipo;
	/*joyas
	 * electrodomesticos
	 * maquinarias y equipos industriales
	 * articulos del hogas
	 * equipos de computo
	 * equipos de comunicacion
	 * obras de arte
	 * piedras y metales preciosos
	 * articulos de coleccion
	 * otros (en otros aparece un campo de texto en donde se llena "private String especificarTipo")*/
	
	@Column(nullable=true, length=90)
	private String especificarTipo;
	
	@Column(nullable=true, length=180)
	private String estadoDeConservasion;//bueno, regular, inservible o inoperativo
	
	@Column(nullable=false)
	private Double valor;

	@Column(nullable=false)
	private String estado;

	@Column(nullable = false)
	private Timestamp fecCreacion;
	
	@ManyToOne
	@JoinColumn(name = "idSospechoso")
	private Sospechoso sospechoso;
	
	public Sospechoso getSospechoso() {
		return sospechoso;
	}

	public void setSospechoso(Sospechoso sospechoso) {
		this.sospechoso = sospechoso;
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

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getEspecificarTipo() {
		return especificarTipo;
	}

	public void setEspecificarTipo(String especificarTipo) {
		this.especificarTipo = especificarTipo;
	}
}
