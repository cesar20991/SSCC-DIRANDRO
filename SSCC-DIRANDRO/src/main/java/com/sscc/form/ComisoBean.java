package com.sscc.form;

import java.sql.Timestamp;

public class ComisoBean {

	private Integer idComiso;
	private String tipoDeComiso;
	private String tipoDeInsumoOdorga;
	private Double valorMonetario;
	private Double pesoNeto;
	private Double pesoBruto;
	private String unidadDeMedidaNeto;
	private String unidadDeMedidaBruto;
	private String etiquetaOembalaje;
	private String codigo;
	private Timestamp fecCreacion;
	public Integer getIdComiso() {
		return idComiso;
	}
	public void setIdComiso(Integer idComiso) {
		this.idComiso = idComiso;
	}
	public String getTipoDeComiso() {
		return tipoDeComiso;
	}
	public void setTipoDeComiso(String tipoDeComiso) {
		this.tipoDeComiso = tipoDeComiso;
	}
	public String getTipoDeInsumoOdorga() {
		return tipoDeInsumoOdorga;
	}
	public void setTipoDeInsumoOdorga(String tipoDeInsumoOdorga) {
		this.tipoDeInsumoOdorga = tipoDeInsumoOdorga;
	}
	public Double getValorMonetario() {
		return valorMonetario;
	}
	public void setValorMonetario(Double valorMonetario) {
		this.valorMonetario = valorMonetario;
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
	public String getEtiquetaOembalaje() {
		return etiquetaOembalaje;
	}
	public void setEtiquetaOembalaje(String etiquetaOembalaje) {
		this.etiquetaOembalaje = etiquetaOembalaje;
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
	
}
