package com.sscc.form;

import java.sql.Date;
import java.sql.Timestamp;

public class PerfilBean {

	private Integer idUsuario;	
	private String correoElectronico;
	private String contrasena;
	private Timestamp fecCreacionUsuario;
	private String estadoUsuario;
	
	private Integer idPerfil;
	private String primerNombre;
	private String nombreCompleto;
	private String segundoNombre;
	private String apePaterno;
	private String apeMaterno;
	private String telefono;
	private Integer dni;
	private String sexo;//F = femenino, M = masculino
	private Date fecNacimiento;
	private String entidadPerteneciente;//D = DIRANDRO, M = Ministerio Público
	private String estadoPerfil;
	private Timestamp fecCreacionPerfil;
	private Integer numeroDeCarnet;
	private String grado;
	private String cargo;
	private String rango;
	private String tipoFiscal;
	private String codigoPerfil;
	
	public Integer getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(Integer idUsuario) {
		this.idUsuario = idUsuario;
	}	
	public String getEstadoUsuario() {
		return estadoUsuario;
	}
	public void setEstadoUsuario(String estadoUsuario) {
		this.estadoUsuario = estadoUsuario;
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
	public Integer getDni() {
		return dni;
	}
	public void setDni(Integer dni) {
		this.dni = dni;
	}
	public Date getFecNacimiento() {
		return fecNacimiento;
	}
	public void setFecNacimiento(Date fecNacimiento) {
		this.fecNacimiento = fecNacimiento;
	}
	public String getEstadoPerfil() {
		return estadoPerfil;
	}
	public void setEstadoPerfil(String estadoPerfil) {
		this.estadoPerfil = estadoPerfil;
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
	public String getCorreoElectronico() {
		return correoElectronico;
	}
	public void setCorreoElectronico(String correoElectronico) {
		this.correoElectronico = correoElectronico;
	}
	public String getContrasena() {
		return contrasena;
	}
	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}
	public Timestamp getFecCreacionUsuario() {
		return fecCreacionUsuario;
	}
	public void setFecCreacionUsuario(Timestamp fecCreacionUsuario) {
		this.fecCreacionUsuario = fecCreacionUsuario;
	}
	public Timestamp getFecCreacionPerfil() {
		return fecCreacionPerfil;
	}
	public void setFecCreacionPerfil(Timestamp fecCreacionPerfil) {
		this.fecCreacionPerfil = fecCreacionPerfil;
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
	public String getNombreCompleto() {
		return nombreCompleto;
	}
	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}
	public String getCodigoPerfil() {
		return codigoPerfil;
	}
	public void setCodigoPerfil(String codigoPerfil) {
		this.codigoPerfil = codigoPerfil;
	}
	
}
