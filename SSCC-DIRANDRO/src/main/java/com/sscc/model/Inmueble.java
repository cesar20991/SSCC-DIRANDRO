package com.sscc.model;

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
public class Inmueble {


	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idInmueble;

	@Column(length = 12 ,nullable = false)
	private String codigo;
	
	@Column( nullable = false)
	private Double areaTotal;
	
	@Column( nullable = false)
	private Double areaConstruido;
	
	@Column( nullable = false)
	private Double areaCercado;
	
	@Column(nullable = false)
	private Integer pisos;
	
	@Column(nullable = false)
	private Integer ambientes;
	
	@Column(length=100, nullable = false)
	private String direccion;
	
	@Column( nullable = true)
	private Double latitud;

	@Column( nullable = true)
	private Double longitud;

	@Column(nullable = false)
	private Integer antiguedad;
	
	//TODO falta poner ubigeo
	
	@OneToOne
	@JoinColumn(name = "idBien")
	private Bien bien;
	
	@OneToMany(mappedBy = "inmueble")
	private Collection<Archivo> archivos;

	public Integer getIdInmueble() {
		return idInmueble;
	}

	public void setIdInmueble(Integer idInmueble) {
		this.idInmueble = idInmueble;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public Double getAreaTotal() {
		return areaTotal;
	}

	public void setAreaTotal(Double areaTotal) {
		this.areaTotal = areaTotal;
	}

	public Double getAreaConstruido() {
		return areaConstruido;
	}

	public void setAreaConstruido(Double areaConstruido) {
		this.areaConstruido = areaConstruido;
	}

	public Double getAreaCercado() {
		return areaCercado;
	}

	public void setAreaCercado(Double areaCercado) {
		this.areaCercado = areaCercado;
	}

	public Integer getPisos() {
		return pisos;
	}

	public void setPisos(Integer pisos) {
		this.pisos = pisos;
	}

	public Integer getAmbientes() {
		return ambientes;
	}

	public void setAmbientes(Integer ambientes) {
		this.ambientes = ambientes;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public Double getLatitud() {
		return latitud;
	}

	public void setLatitud(Double latitud) {
		this.latitud = latitud;
	}

	public Double getLongitud() {
		return longitud;
	}

	public void setLongitud(Double longitud) {
		this.longitud = longitud;
	}

	public Integer getAntiguedad() {
		return antiguedad;
	}

	public void setAntiguedad(Integer antiguedad) {
		this.antiguedad = antiguedad;
	}

	public Bien getBien() {
		return bien;
	}

	public void setBien(Bien bien) {
		this.bien = bien;
	}

	public Collection<Archivo> getArchivos() {
		return archivos;
	}

	public void setArchivos(Collection<Archivo> archivos) {
		this.archivos = archivos;
	}
	
	
	
}
