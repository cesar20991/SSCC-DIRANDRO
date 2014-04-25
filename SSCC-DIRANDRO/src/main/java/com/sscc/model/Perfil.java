package com.sscc.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;


@Entity
public class Perfil {

	@Id @GeneratedValue	
	private Integer idPerfil;
	
	@Column(length = 90, nullable = false)
	private String primerNombre;
	@Column(length = 90, nullable = true)
	private String segundoNombre;
	@Column(length = 90, nullable = false)
	private String apePaterno;
	@Column(length = 90, nullable = false)
	private String apeMaterno;
	@Column(length = 90, nullable = true)
	private String telefono;
	@Column(nullable = false)
	private Integer dni;
	@Column(length = 1, nullable = false)
	private String sexo;//F = femenino, M = masculino
	@Column(length = 1, nullable = false)
	private String entidadPerteneciente;//D = DIRANDRO, M = Ministerio Público
	@Column(length = 30, nullable = false)
	private String estado;
	@Column(nullable = false)
	private Timestamp fecCreacion;
	@Column(nullable = true)
	private Integer numeroDeCarnet;
	@Column(length = 100, nullable = true)
	private String grado;
	@Column(length = 100, nullable = true)
	private String rango;
	@Column(length = 100, nullable = true)
	private String cargo;
	@Column(length = 100, nullable = true)
	private String tipoFiscal;
	
	//Referencias
	@OneToOne(mappedBy="perfil")
	private Usuario usuario;
	

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

	public Integer getDni() {
		return dni;
	}

	public void setDni(Integer dni) {
		this.dni = dni;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getSexo() {
		return sexo;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public String getEntidadPerteneciente() {
		return entidadPerteneciente;
	}

	public void setEntidadPerteneciente(String entidadPerteneciente) {
		this.entidadPerteneciente = entidadPerteneciente;
	}

	public Integer getNumeroDeCarnet() {
		return numeroDeCarnet;
	}

	public void setNumeroDeCarnet(Integer numeroDeCarnet) {
		this.numeroDeCarnet = numeroDeCarnet;
	}

	public String getGrado() {
		return grado;
	}

	public void setGrado(String grado) {
		this.grado = grado;
	}

	public Timestamp getFecCreacion() {
		return fecCreacion;
	}

	public void setFecCreacion(Timestamp fecCreacion) {
		this.fecCreacion = fecCreacion;
	}

	public String getCargo() {
		return cargo;
	}

	public void setCargo(String cargo) {
		this.cargo = cargo;
	}

	public String getRango() {
		return rango;
	}

	public void setRango(String rango) {
		this.rango = rango;
	}

	public String getTipoFiscal() {
		return tipoFiscal;
	}

	public void setTipoFiscal(String tipoFiscal) {
		this.tipoFiscal = tipoFiscal;
	}
	
	
}
