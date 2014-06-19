package com.sscc.form;

import java.sql.Timestamp;

public class CasoCriminalBean {
	//caso criminal
	private Integer idCasoCriminal;	
	private String codigo;
	private String asunto;
	private String referencia;
	private String descripcion;
	private String importancia;
	private String estado;
	private Timestamp fecCreacion;
	private Integer diasDiligenciasPreliminares;
	private Timestamp fecDiligenciasPre;
	private String cometarioPausaDoc;
	private String estadoAnterior;
	private String cometarioPausaNCaso;
	
	//usuario
	private String correoElectronico;
	//perfil
	private Integer idPerfil;
	private String primerNombre;
	private String segundoNombre;
	private String apePaterno;
	private String apeMaterno;
	private String tipoFiscal;
	private Integer idUsuario;
	private String nombreCompleto;
	
	public Integer getIdCasoCriminal() {
		return idCasoCriminal;
	}
	public void setIdCasoCriminal(Integer idCasoCriminal) {
		this.idCasoCriminal = idCasoCriminal;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getAsunto() {
		return asunto;
	}
	public void setAsunto(String asunto) {
		this.asunto = asunto;
	}
	public String getReferencia() {
		return referencia;
	}
	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public Timestamp getFecCreacion() {
		return fecCreacion;
	}
	public void setFecCreacion(Timestamp fecCreacion) {
		this.fecCreacion = fecCreacion;
	}
	public String getCorreoElectronico() {
		return correoElectronico;
	}
	public void setCorreoElectronico(String correoElectronico) {
		this.correoElectronico = correoElectronico;
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
	public Integer getIdPerfil() {
		return idPerfil;
	}
	public void setIdPerfil(Integer idPerfil) {
		this.idPerfil = idPerfil;
	}
	public String getNombreCompleto() {
		return nombreCompleto;
	}
	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}
	public Integer getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(Integer idUsuario) {
		this.idUsuario = idUsuario;
	}
	public String getImportancia() {
		return importancia;
	}
	public void setImportancia(String importancia) {
		this.importancia = importancia;
	}
	public Integer getDiasDiligenciasPreliminares() {
		return diasDiligenciasPreliminares;
	}
	public void setDiasDiligenciasPreliminares(Integer diasDiligenciasPreliminares) {
		this.diasDiligenciasPreliminares = diasDiligenciasPreliminares;
	}
	public Timestamp getFecDiligenciasPre() {
		return fecDiligenciasPre;
	}
	public void setFecDiligenciasPre(Timestamp fecDiligenciasPre) {
		this.fecDiligenciasPre = fecDiligenciasPre;
	}
	public String getCometarioPausaDoc() {
		return cometarioPausaDoc;
	}
	public void setCometarioPausaDoc(String cometarioPausaDoc) {
		this.cometarioPausaDoc = cometarioPausaDoc;
	}
	public String getEstadoAnterior() {
		return estadoAnterior;
	}
	public void setEstadoAnterior(String estadoAnterior) {
		this.estadoAnterior = estadoAnterior;
	}
	public String getCometarioPausaNCaso() {
		return cometarioPausaNCaso;
	}
	public void setCometarioPausaNCaso(String cometarioPausaNCaso) {
		this.cometarioPausaNCaso = cometarioPausaNCaso;
	}
}
