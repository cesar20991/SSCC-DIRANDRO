package com.sscc.form;

import javax.persistence.Column;


public class MuebleBean {

	private Integer idMueble;
	private String codigo;
	private String descripcion;
	private String tipo;
	private String especificarTipo;
	private Double valor;
	private String estado;
	private String estadoDeConservasion;

	// usuario
	private String correoElectronico;
	// perfil
	private Integer idPerfil;
	private String primerNombre;
	private String segundoNombre;
	private String apePaterno;
	private String apeMaterno;
	private String tipoFiscal;
	private Integer idUsuario;
	private String nombreCompleto;
	
	
	
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
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
	public String getCorreoElectronico() {
		return correoElectronico;
	}
	public void setCorreoElectronico(String correoElectronico) {
		this.correoElectronico = correoElectronico;
	}
	public Integer getIdPerfil() {
		return idPerfil;
	}
	public void setIdPerfil(Integer idPerfil) {
		this.idPerfil = idPerfil;
	}
	public String getPrimerNombre() {
		return primerNombre;
	}
	public void setPrimerNombre(String primerNombre) {
		this.primerNombre = primerNombre;
	}
	public String getSegundoNombre() {
		return segundoNombre;
	}
	public void setSegundoNombre(String segundoNombre) {
		this.segundoNombre = segundoNombre;
	}
	public String getApePaterno() {
		return apePaterno;
	}
	public void setApePaterno(String apePaterno) {
		this.apePaterno = apePaterno;
	}
	public String getApeMaterno() {
		return apeMaterno;
	}
	public void setApeMaterno(String apeMaterno) {
		this.apeMaterno = apeMaterno;
	}
	public String getTipoFiscal() {
		return tipoFiscal;
	}
	public void setTipoFiscal(String tipoFiscal) {
		this.tipoFiscal = tipoFiscal;
	}
	public Integer getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(Integer idUsuario) {
		this.idUsuario = idUsuario;
	}
	public String getNombreCompleto() {
		return nombreCompleto;
	}
	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
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
	public String getEstadoDeConservasion() {
		return estadoDeConservasion;
	}
	public void setEstadoDeConservasion(String estadoDeConservasion) {
		this.estadoDeConservasion = estadoDeConservasion;
	}
	
	
	

}
