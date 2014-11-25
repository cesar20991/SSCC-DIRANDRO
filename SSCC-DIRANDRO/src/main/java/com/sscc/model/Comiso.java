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
public class Comiso {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idComiso;
	
	@Column(length =250, nullable = false)
	private String tipoDeComiso;
	
	@Column(length =250, nullable = false)
	private String tipoDeInsumoOdorga;
	
	@Column(nullable= false)
	private Double valorMonetario;
	
	@Column(nullable= false)
	private Double pesoNeto;
	
	@Column(nullable= false)
	private Double pesoBruto;
	
	@Column(length =50, nullable = false)
	private String unidadDeMedidaNeto;
	
	@Column(length =50, nullable = false)
	private String unidadDeMedidaBruto;
	
	@Column(length =50, nullable = false)
	private String etiquetaOembalaje;
	
	@Column(length =250, nullable = true)
	private String codigo;
	
	@Column(length =250, nullable = false)
	private String estado;
	
	@Column(nullable = false)
	private Timestamp fecCreacion;
	
	@ManyToOne
	@JoinColumn(name = "idCasoCriminal")
	private CasoCriminal casoCriminal;

	public Integer getIdComiso() {
		return idComiso;
	}

	public void setIdComiso(Integer idComiso) {
		this.idComiso = idComiso;
	}

	public String getTipoDeInsumoOdorga() {
		return tipoDeInsumoOdorga;
	}

	public void setTipoDeInsumoOdorga(String tipoDeInsumoOdorga) {
		this.tipoDeInsumoOdorga = tipoDeInsumoOdorga;
	}

	public Double getPesoNeto() {
		return pesoNeto;
	}

	public void setPesoNeto(Double pesoNeto) {
		this.pesoNeto = pesoNeto;
	}

	public Double getPesoBruto() {
		return pesoBruto;
	}

	public void setPesoBruto(Double pesoBruto) {
		this.pesoBruto = pesoBruto;
	}

	public String getEtiquetaOembalaje() {
		return etiquetaOembalaje;
	}

	public void setEtiquetaOembalaje(String etiquetaOembalaje) {
		this.etiquetaOembalaje = etiquetaOembalaje;
	}

	public CasoCriminal getCasoCriminal() {
		return casoCriminal;
	}

	public void setCasoCriminal(CasoCriminal casoCriminal) {
		this.casoCriminal = casoCriminal;
	}

	public String getUnidadDeMedidaNeto() {
		return unidadDeMedidaNeto;
	}

	public void setUnidadDeMedidaNeto(String unidadDeMedidaNeto) {
		this.unidadDeMedidaNeto = unidadDeMedidaNeto;
	}

	public String getUnidadDeMedidaBruto() {
		return unidadDeMedidaBruto;
	}

	public void setUnidadDeMedidaBruto(String unidadDeMedidaBruto) {
		this.unidadDeMedidaBruto = unidadDeMedidaBruto;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public Timestamp getFecCreacion() {
		return fecCreacion;
	}

	public void setFecCreacion(Timestamp fecCreacion) {
		this.fecCreacion = fecCreacion;
	}

	public String getTipoDeComiso() {
		return tipoDeComiso;
	}

	public void setTipoDeComiso(String tipoDeComiso) {
		this.tipoDeComiso = tipoDeComiso;
	}

	public Double getValorMonetario() {
		return valorMonetario;
	}

	public void setValorMonetario(Double valorMonetario) {
		this.valorMonetario = valorMonetario;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}
		
}
