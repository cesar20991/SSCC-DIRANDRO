package com.sscc.model;

import java.sql.Timestamp;
import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Usuario {
	
	@Id @GeneratedValue	
	private Integer idUsuario;
	
	@Column(length = 180, nullable = false)
	private String correoElectronico;
	@Column(length = 60, nullable = false)
	private String contrasena;
	@Column(nullable = false)
	private Timestamp fecCreacion;
	@Column(length = 30, nullable = false)
	private String estado;
	
	//Referencias
	@OneToOne
	@JoinColumn(name = "idPerfil")
	private Perfil perfil;	
	
	@OneToMany(mappedBy = "usuario")
	private Collection<CasoCriminal> casos;
	
	@OneToMany(mappedBy = "usuario")
	private Collection<CasoPorAgente> cpa;
		
	public Integer getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(Integer idUsuario) {
		this.idUsuario = idUsuario;
	}
	public Perfil getPerfil() {
		return perfil;
	}
	public void setPerfil(Perfil perfil) {
		this.perfil = perfil;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getContrasena() {
		return contrasena;
	}
	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
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
	public Collection<CasoCriminal> getCasos() {
		return casos;
	}
	public void setCasos(Collection<CasoCriminal> casos) {
		this.casos = casos;
	}
	public Collection<CasoPorAgente> getCpa() {
		return cpa;
	}
	public void setCpa(Collection<CasoPorAgente> cpa) {
		this.cpa = cpa;
	}
	
}
