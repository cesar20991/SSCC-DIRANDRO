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
public class Vehiculo {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idVehiculo;
	
	@Column(length = 12 ,nullable = false)
	private String codigo;
	
	@Column(nullable = false)
	private Double altura;

	@Column(nullable = false)
	private Double ancho;

	@Column(nullable = false)
	private Double longitud;
	
	@Column(nullable = true)
	private Double pesoBruto;

	@Column(nullable = true)
	private Double pesoNeto;

	@Column(length=30, nullable = false)
	private String placa;

	@Column(length=30, nullable = false)
	private String marca;

	@Column(length=30, nullable = false)
	private String modelo;

	@Column(length=50, nullable = false)
	private String chasis;

	@Column(length=50, nullable = false)
	private String motor;

	@Column(nullable = true)
	private Integer ruedas;

	@Column(nullable = true)
	private Integer ejes;
	
	@Column(nullable = true)
	private Integer pasajeros;

	@Column(nullable = true)
	private Integer asientos;
	
	@Column(length = 30 ,nullable = false)
	private String color;

	@Column(nullable = false)
	private Date fecFabricacion;
	
	@Column(nullable = true)	
	private String urlVehiculo;

	@OneToOne
	@JoinColumn(name = "idBien")
	private Bien bien;
	
	@OneToMany(mappedBy = "vehiculo")
	private Collection<Archivo> archivos;

	public Integer getIdVehiculo() {
		return idVehiculo;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public void setIdVehiculo(Integer idVehiculo) {
		this.idVehiculo = idVehiculo;
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

	public String getUrlVehiculo() {
		return urlVehiculo;
	}

	public void setUrlVehiculo(String urlVehiculo) {
		this.urlVehiculo = urlVehiculo;
	}
}
