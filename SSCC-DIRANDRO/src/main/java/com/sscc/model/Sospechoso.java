package com.sscc.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Sospechoso {

	@Id @GeneratedValue
	private Integer idSospechoso;
	
	@Column(length = 20, nullable = true)
	private String codigoUnicoDeIdentificacion;
	@Column(length = 50, nullable = true)
	private String primerApellido;
	@Column(length = 50, nullable = true)
	private String segundoApellido;
	@Column(length = 50, nullable = true)
	private String preNombres;
	@Column(length = 1, nullable = false)
	private String sexo;//F = femenino, M = masculino
	@Column(nullable=true)
	private Date fechaDeNacimiento;
	@Column(length = 50, nullable = true)
	private String departamentoDeNacimiento;
	@Column(length = 50, nullable = true)
	private String provinciaDeNacimiento;
	@Column(length = 50, nullable = true)
	private String distritoDeNacimiento;
	@Column(length = 50, nullable = true)
	private String gradoDeInstruccion;
	@Column(length = 50, nullable = true)
	private String estadoCivil;
	@Column(nullable = true)
	private Double estatura;
	@Column(nullable=true)
	private Date fechaDeInscripcion;
	@Column(length = 50, nullable = true)
	private String nombrePadre;
	@Column(length = 50, nullable = true)
	private String nombreMadre;
	@Column(nullable=true)
	private Date fechaDeEmision;
	@Column(length = 50, nullable = true)
	private String restriccion;
	@Column(length = 50, nullable = true)
	private String domicilio;
	@Column(length = 50, nullable = true)
	private String departamentoDeDomicilio;
	@Column(length = 50, nullable = true)
	private String provinciaDeDomicilio;
	@Column(length = 50, nullable = true)
	private String distritoDeDomicilio;
	@Column(nullable = true)
	private Integer multasElectorales;
	
	
	public Integer getIdSospechoso() {
		return idSospechoso;
	}
	public void setIdSospechoso(Integer idSospechoso) {
		this.idSospechoso = idSospechoso;
	}
	public String getCodigoUnicoDeIdentificacion() {
		return codigoUnicoDeIdentificacion;
	}
	public void setCodigoUnicoDeIdentificacion(String codigoUnicoDeIdentificacion) {
		this.codigoUnicoDeIdentificacion = codigoUnicoDeIdentificacion;
	}
	public String getPrimerApellido() {
		return primerApellido;
	}
	public void setPrimerApellido(String primerApellido) {
		this.primerApellido = primerApellido;
	}
	public String getSegundoApellido() {
		return segundoApellido;
	}
	public void setSegundoApellido(String segundoApellido) {
		this.segundoApellido = segundoApellido;
	}
	public String getPreNombres() {
		return preNombres;
	}
	public void setPreNombres(String preNombres) {
		this.preNombres = preNombres;
	}
	public String getSexo() {
		return sexo;
	}
	public void setSexo(String sexo) {
		this.sexo = sexo;
	}
	public Date getFechaDeNacimiento() {
		return fechaDeNacimiento;
	}
	public void setFechaDeNacimiento(Date fechaDeNacimiento) {
		this.fechaDeNacimiento = fechaDeNacimiento;
	}
	public String getDepartamentoDeNacimiento() {
		return departamentoDeNacimiento;
	}
	public void setDepartamentoDeNacimiento(String departamentoDeNacimiento) {
		this.departamentoDeNacimiento = departamentoDeNacimiento;
	}
	public String getProvinciaDeNacimiento() {
		return provinciaDeNacimiento;
	}
	public void setProvinciaDeNacimiento(String provinciaDeNacimiento) {
		this.provinciaDeNacimiento = provinciaDeNacimiento;
	}
	public String getDistritoDeNacimiento() {
		return distritoDeNacimiento;
	}
	public void setDistritoDeNacimiento(String distritoDeNacimiento) {
		this.distritoDeNacimiento = distritoDeNacimiento;
	}
	public String getGradoDeInstruccion() {
		return gradoDeInstruccion;
	}
	public void setGradoDeInstruccion(String gradoDeInstruccion) {
		this.gradoDeInstruccion = gradoDeInstruccion;
	}
	public Double getEstatura() {
		return estatura;
	}
	public void setEstatura(Double estatura) {
		this.estatura = estatura;
	}
	public Date getFechaDeInscripcion() {
		return fechaDeInscripcion;
	}
	public void setFechaDeInscripcion(Date fechaDeInscripcion) {
		this.fechaDeInscripcion = fechaDeInscripcion;
	}
	public String getNombrePadre() {
		return nombrePadre;
	}
	public void setNombrePadre(String nombrePadre) {
		this.nombrePadre = nombrePadre;
	}
	public String getNombreMadre() {
		return nombreMadre;
	}
	public void setNombreMadre(String nombreMadre) {
		this.nombreMadre = nombreMadre;
	}
	public Date getFechaDeEmision() {
		return fechaDeEmision;
	}
	public void setFechaDeEmision(Date fechaDeEmision) {
		this.fechaDeEmision = fechaDeEmision;
	}
	public String getRestriccion() {
		return restriccion;
	}
	public void setRestriccion(String restriccion) {
		this.restriccion = restriccion;
	}
	public String getDomicilio() {
		return domicilio;
	}
	public void setDomicilio(String domicilio) {
		this.domicilio = domicilio;
	}
	public String getDepartamentoDeDomicilio() {
		return departamentoDeDomicilio;
	}
	public void setDepartamentoDeDomicilio(String departamentoDeDomicilio) {
		this.departamentoDeDomicilio = departamentoDeDomicilio;
	}
	public String getProvinciaDeDomicilio() {
		return provinciaDeDomicilio;
	}
	public void setProvinciaDeDomicilio(String provinciaDeDomicilio) {
		this.provinciaDeDomicilio = provinciaDeDomicilio;
	}
	public String getDistritoDeDomicilio() {
		return distritoDeDomicilio;
	}
	public void setDistritoDeDomicilio(String distritoDeDomicilio) {
		this.distritoDeDomicilio = distritoDeDomicilio;
	}
	public Integer getMultasElectorales() {
		return multasElectorales;
	}
	public void setMultasElectorales(Integer multasElectorales) {
		this.multasElectorales = multasElectorales;
	}
	public String getEstadoCivil() {
		return estadoCivil;
	}
	public void setEstadoCivil(String estadoCivil) {
		this.estadoCivil = estadoCivil;
	}
}
