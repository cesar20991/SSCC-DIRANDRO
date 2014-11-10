package com.sscc.form;

import java.sql.Date;
import java.sql.Timestamp;

public class VehiculoBean {

	// Bien
	private Integer idBien;
	private String descripcion;
	private Double valor;
	private String partidaRegistral;

	// Vehiculo
	private Integer idVehiculo;
	private String codigo;
	private String marca;
	private String modelo;
	private String color;
	private String placa;
	private String chasis;
	private String motor;
	private Double altura;
	private Double ancho;
	private Double longitud;
	private Double pesoBruto;
	private Double pesoNeto;
	private Integer ruedas;
	private Integer ejes;
	private Integer pasajeros;
	private Integer asientos;
	private Date fecFabricacion;
	private String urlVehiculo;

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
	public Integer getIdBien() {
		return idBien;
	}
	public void setIdBien(Integer idBien) {
		this.idBien = idBien;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getPartidaRegistral() {
		return partidaRegistral;
	}
	public void setPartidaRegistral(String partidaRegistral) {
		this.partidaRegistral = partidaRegistral;
	}
	public Integer getIdVehiculo() {
		return idVehiculo;
	}
	public void setIdVehiculo(Integer idVehiculo) {
		this.idVehiculo = idVehiculo;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public Double getAltura() {
		return altura;
	}
	public void setAltura(Double altura) {
		this.altura = altura;
	}
	public Double getAncho() {
		return ancho;
	}
	public void setAncho(Double ancho) {
		this.ancho = ancho;
	}
	public Double getLongitud() {
		return longitud;
	}
	public void setLongitud(Double longitud) {
		this.longitud = longitud;
	}
	public Double getPesoBruto() {
		return pesoBruto;
	}
	public void setPesoBruto(Double pesoBruto) {
		this.pesoBruto = pesoBruto;
	}
	public Double getPesoNeto() {
		return pesoNeto;
	}
	public void setPesoNeto(Double pesoNeto) {
		this.pesoNeto = pesoNeto;
	}
	public String getPlaca() {
		return placa;
	}
	public void setPlaca(String placa) {
		this.placa = placa;
	}
	public String getMarca() {
		return marca;
	}
	public void setMarca(String marca) {
		this.marca = marca;
	}
	public String getModelo() {
		return modelo;
	}
	public void setModelo(String modelo) {
		this.modelo = modelo;
	}
	public String getChasis() {
		return chasis;
	}
	public void setChasis(String chasis) {
		this.chasis = chasis;
	}
	public String getMotor() {
		return motor;
	}
	public void setMotor(String motor) {
		this.motor = motor;
	}
	public Integer getRuedas() {
		return ruedas;
	}
	public void setRuedas(Integer ruedas) {
		this.ruedas = ruedas;
	}
	public Integer getEjes() {
		return ejes;
	}
	public void setEjes(Integer ejes) {
		this.ejes = ejes;
	}
	public Integer getPasajeros() {
		return pasajeros;
	}
	public void setPasajeros(Integer pasajeros) {
		this.pasajeros = pasajeros;
	}
	public Integer getAsientos() {
		return asientos;
	}
	public void setAsientos(Integer asientos) {
		this.asientos = asientos;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public Date getFecFabricacion() {
		return fecFabricacion;
	}
	public void setFecFabricacion(Date fecFabricacion) {
		this.fecFabricacion = fecFabricacion;
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
	public Double getValor() {
		return valor;
	}
	public void setValor(Double valor) {
		this.valor = valor;
	}
	public String getUrlVehiculo() {
		return urlVehiculo;
	}
	public void setUrlVehiculo(String urlVehiculo) {
		this.urlVehiculo = urlVehiculo;
	}
}
