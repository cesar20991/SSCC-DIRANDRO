package com.sscc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class CasoPorAgente {
	
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idcasoPorAgente;
	
	@ManyToOne
	@JoinColumn(name = "idUsuario")
	private Usuario usuario;	
	
	@ManyToOne
	@JoinColumn(name = "idCasoCriminal")
	private CasoCriminal casoCriminal;
	
	@Column(length = 30, nullable = false)
	private String estado;

	public Integer getIdcasoPorAgente() {
		return idcasoPorAgente;
	}

	public void setIdcasoPorAgente(Integer idcasoPorAgente) {
		this.idcasoPorAgente = idcasoPorAgente;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public CasoCriminal getCasoCriminal() {
		return casoCriminal;
	}

	public void setCasoCriminal(CasoCriminal casoCriminal) {
		this.casoCriminal = casoCriminal;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

}
