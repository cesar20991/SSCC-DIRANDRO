package com.sscc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class CasoPorSospechoso {
	
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idCasoPorSospechoso;
	
	@ManyToOne
	@JoinColumn(name = "idSospechoso")
	private Sospechoso sospechoso;
	
	@ManyToOne
	@JoinColumn(name = "idCasoCriminal")
	private CasoCriminal casoCriminal;

	@Column(length = 30, nullable = false)
	private String estado;

	public Integer getIdCasoPorSospechoso() {
		return idCasoPorSospechoso;
	}

	public void setIdCasoPorSospechoso(Integer idCasoPorSospechoso) {
		this.idCasoPorSospechoso = idCasoPorSospechoso;
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

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}
}
