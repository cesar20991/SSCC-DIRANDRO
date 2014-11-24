package com.sscc.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Contactos {
	@Id @GeneratedValue
	private Integer idContacto;
		
	@Column(length = 90, nullable = true)
	private String nombres;
	@Column(length = 90, nullable = true)
	private String apellidoPaterno;
	@Column(length = 90, nullable = true)
	private String apellidoMaterno;
	@Column(length = 30, nullable = true)
	private String telefono;
	@Column(length = 30, nullable = true)
	private String celular;
	@Column(length = 60, nullable = true)
	private String correoElectronico;
	@Column(length = 180, nullable = true)
	private String direccion;
	@Column(length = 90, nullable = true)
	private String departamento;
	@Column(length = 90, nullable = true)
	private String provincia;
	@Column(length = 90, nullable = true)
	private String distrito;
	/*Code for search*/
	@Column(nullable = true)
	private String codigo;
	
	@Column(name = "creationdate", nullable = false)
	private Timestamp fecCreacion;
	@Column(length = 30, nullable = false)
	private String estado;
	
	@ManyToOne
	@JoinColumn(name = "idSospechoso")
	private Sospechoso sospechoso;				
	
	public Integer getIdContacto() {
		return idContacto;
	}
	public void setIdContacto(Integer idContacto) {
		this.idContacto = idContacto;
	}
	public String getNombres() {
		return nombres;
	}
	public void setNombres(String nombres) {
		this.nombres = nombres;
	}
	public String getApellidoPaterno() {
		return apellidoPaterno;
	}
	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}
	public String getApellidoMaterno() {
		return apellidoMaterno;
	}
	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public String getCelular() {
		return celular;
	}
	public void setCelular(String celular) {
		this.celular = celular;
	}
	public String getCorreoElectronico() {
		return correoElectronico;
	}
	public void setCorreoElectronico(String correoElectronico) {
		this.correoElectronico = correoElectronico;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public String getDepartamento() {
		return departamento;
	}
	public void setDepartamento(String departamento) {
		this.departamento = departamento;
	}
	public String getProvincia() {
		return provincia;
	}
	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}
	public String getDistrito() {
		return distrito;
	}
	public void setDistrito(String distrito) {
		this.distrito = distrito;
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
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public Sospechoso getSospechoso() {
		return sospechoso;
	}
	public void setSospechoso(Sospechoso sospechoso) {
		this.sospechoso = sospechoso;
	}
	
}
