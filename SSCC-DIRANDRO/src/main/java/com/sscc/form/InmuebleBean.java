package com.sscc.form;

public class InmuebleBean {

	// Bien
	private Integer idBien;
	private String descripcion;
	private Double valor;
	private String partidaRegistral;

	// Inmueble
	private Integer idInmueble;
	private String codigo;
	private Double areaTotal;
	private Double areaConstruido;
	private Double areaCercado;
	private Integer pisos;
	private Integer ambientes;
	private String direccion;
	private Double latitud;
	private Double longitud;
	private Integer antiguedad;

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

	

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
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

	public Integer getIdInmueble() {
		return idInmueble;
	}

	public void setIdInmueble(Integer idInmueble) {
		this.idInmueble = idInmueble;
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

	public Double getValor() {
		return valor;
	}

	public void setValor(Double valor) {
		this.valor = valor;
	}

}
