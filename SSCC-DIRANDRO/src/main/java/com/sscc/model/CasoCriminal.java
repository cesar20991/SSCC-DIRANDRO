package com.sscc.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class CasoCriminal {

	@Id @GeneratedValue	
	private Integer idCasoCriminal;
	
	@Column(length = 100, nullable = true)
	private String codigo;
	@Column(length = 300, nullable = false)
	private String asunto;
	@Column(length = 80, nullable = false)
	private String referencia;
	@Column(length = 1000, nullable = false)
	private String descripcion;
	@Column(length = 30, nullable = false)
	private String estado;
	@Column(nullable = false)
	private Timestamp fecCreacion;
	
	@ManyToOne
	@JoinColumn(name = "idUsuario")
	private Usuario usuario;	
	
	public Integer getIdCasoCriminal() {
		return idCasoCriminal;
	}
	public void setIdCasoCriminal(Integer idCasoCriminal) {
		this.idCasoCriminal = idCasoCriminal;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getAsunto() {
		return asunto;
	}
	public void setAsunto(String asunto) {
		this.asunto = asunto;
	}
	public String getReferencia() {
		return referencia;
	}
	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
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
	public Usuario getUsuario() {
		return usuario;
	}
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	
}
