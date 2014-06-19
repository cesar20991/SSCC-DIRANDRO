package com.sscc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class BienPorSospechoso {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idBienPorSospechoso;
	
	@ManyToOne
	@JoinColumn(name = "idSospechoso")
	private Sospechoso sospechoso;
	
	@ManyToOne
	@JoinColumn(name = "idBien")
	private Bien bien;
	
	@Column(length = 30, nullable = false)
	private String estado;

	public Integer getIdBienPorSospechoso() {
		return idBienPorSospechoso;
	}

	public void setIdBienPorSospechoso(Integer idBienPorSospechoso) {
		this.idBienPorSospechoso = idBienPorSospechoso;
	}

	public Sospechoso getSospechoso() {
		return sospechoso;
	}

	public void setSospechoso(Sospechoso sospechoso) {
		this.sospechoso = sospechoso;
	}

	public Bien getBien() {
		return bien;
	}

	public void setBien(Bien bien) {
		this.bien = bien;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}
	
	
}
