package com.sscc.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Sospechoso {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idSospechoso;
	@Column(length = 50, nullable = true)
	private String tipodocumento;	
	@Column(length = 20, nullable = true)
	private String codigoUnicoDeIdentificacion;
	@Column(length = 50, nullable = true)
	private String primerApellido;
	@Column(length = 50, nullable = true)
	private String segundoApellido;
	@Column(length = 50, nullable = true)
	private String preNombres;
	@Column(length = 50, nullable = false)
	private String alias;
	@Column(length = 80, nullable = true)
	private String codigo;
	@Column(length = 1, nullable = true)
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
	private String estadoCivil;//comboBox: Soltero, Casado, Divorciado, Viudo
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
	@Column(length = 50, nullable = true)
	private String estado;
	@Column(nullable = false)
	private Timestamp fecCreacionSospechoso;
	
	// DATOS DE CONTACTO
	@Column (length = 1000, nullable = true)
	private String celulares;
	@Column (length = 1000, nullable = true)
	private String correos;
	@Column (length = 1000, nullable = true)
	private String direcciones;
	@Column (length = 1000, nullable = true)
	private String telefonos;
	//url
	@Column(nullable = true)	
	private String urlSospechoso;
	///
	@OneToOne
	@JoinColumn(name = "idRasgosParticulares")
	private RasgosParticulares rasgosParticulares;
	
	@OneToMany(mappedBy = "sospechoso")
	private Collection<CasoPorSospechoso> cpSospechoso;
	
	@OneToMany(mappedBy = "sospechoso")
	private Collection<Archivo> archivos;
	
	@OneToMany(mappedBy = "sospechoso")
	private Collection<Mueble> muebles;

	
	public Collection<Mueble> getMuebles() {
		return muebles;
	}
	public void setMuebles(Collection<Mueble> muebles) {
		this.muebles = muebles;
	}
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
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public Timestamp getFecCreacionSospechoso() {
		return fecCreacionSospechoso;
	}
	public void setFecCreacionSospechoso(Timestamp fecCreacionSospechoso) {
		this.fecCreacionSospechoso = fecCreacionSospechoso;
	}
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public RasgosParticulares getRasgosParticulares() {
		return rasgosParticulares;
	}
	public void setRasgosParticulares(RasgosParticulares rasgosParticulares) {
		this.rasgosParticulares = rasgosParticulares;
	}
	public String getCelulares() {
		return celulares;
	}
	public void setCelulares(String celulares) {
		this.celulares = celulares;
	}
	public String getCorreos() {
		return correos;
	}
	public void setCorreos(String correos) {
		this.correos = correos;
	}
	public String getDirecciones() {
		return direcciones;
	}
	public void setDirecciones(String direcciones) {
		this.direcciones = direcciones;
	}
	public String getTelefonos() {
		return telefonos;
	}
	public void setTelefonos(String telefonos) {
		this.telefonos = telefonos;
	}
	public Collection<CasoPorSospechoso> getCpSospechoso() {
		return cpSospechoso;
	}
	public void setCpSospechoso(Collection<CasoPorSospechoso> cpSospechoso) {
		this.cpSospechoso = cpSospechoso;
	}
	public Collection<Archivo> getArchivos() {
		return archivos;
	}
	public void setArchivos(Collection<Archivo> archivos) {
		this.archivos = archivos;
	}
	public String getUrlSospechoso() {
		return urlSospechoso;
	}
	public void setUrlSospechoso(String urlSospechoso) {
		this.urlSospechoso = urlSospechoso;
	}
	public String getTipodocumento() {
		return tipodocumento;
	}
	public void setTipodocumento(String tipodocumento) {
		this.tipodocumento = tipodocumento;
	}
}