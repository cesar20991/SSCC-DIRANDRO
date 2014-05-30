package com.sscc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;

@Entity
public class RasgosParticulares {
	
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)	
	private Integer idRasgosParticulares;
	
	@Column(length = 2, nullable = true)
	private String tatuaje;
	@Column(length = 2, nullable = true)
	private String lunares;
	@Column(length = 2, nullable = true)
	private String cicatrices;
	@Column(length = 2, nullable = true)
	private String deficiencias;
	@Column(length = 2, nullable = true)
	private String otros;
	
	@Column(length = 1500, nullable = true)
	private String textoTatuaje;
	@Column(length = 1500, nullable = true)
	private String textoLunares;
	@Column(length = 1500, nullable = true)
	private String textoCicatrices;
	@Column(length = 1500, nullable = true)
	private String textoDeficiencias;
	@Column(length = 1500, nullable = true)
	private String textoOtros;
	
	//Referencias
	@OneToOne(mappedBy="rasgosParticulares")
	private Sospechoso sospechoso;

	public Integer getIdRasgosParticulares() {
		return idRasgosParticulares;
	}

	public void setIdRasgosParticulares(Integer idRasgosParticulares) {
		this.idRasgosParticulares = idRasgosParticulares;
	}

	public String getTatuaje() {
		return tatuaje;
	}

	public void setTatuaje(String tatuaje) {
		this.tatuaje = tatuaje;
	}

	public String getLunares() {
		return lunares;
	}

	public void setLunares(String lunares) {
		this.lunares = lunares;
	}

	public String getDeficiencias() {
		return deficiencias;
	}

	public void setDeficiencias(String deficiencias) {
		this.deficiencias = deficiencias;
	}

	public String getOtros() {
		return otros;
	}

	public void setOtros(String otros) {
		this.otros = otros;
	}

	public String getTextoTatuaje() {
		return textoTatuaje;
	}

	public void setTextoTatuaje(String textoTatuaje) {
		this.textoTatuaje = textoTatuaje;
	}

	public String getTextoLunares() {
		return textoLunares;
	}

	public void setTextoLunares(String textoLunares) {
		this.textoLunares = textoLunares;
	}

	public String getTextoCicatrices() {
		return textoCicatrices;
	}

	public void setTextoCicatrices(String textoCicatrices) {
		this.textoCicatrices = textoCicatrices;
	}

	public String getTextoDeficiencias() {
		return textoDeficiencias;
	}

	public void setTextoDeficiencias(String textoDeficiencias) {
		this.textoDeficiencias = textoDeficiencias;
	}

	public String getTextoOtros() {
		return textoOtros;
	}

	public void setTextoOtros(String textoOtros) {
		this.textoOtros = textoOtros;
	}

	public String getCicatrices() {
		return cicatrices;
	}

	public void setCicatrices(String cicatrices) {
		this.cicatrices = cicatrices;
	}

	public Sospechoso getSospechoso() {
		return sospechoso;
	}

	public void setSospechoso(Sospechoso sospechoso) {
		this.sospechoso = sospechoso;
	}
}
