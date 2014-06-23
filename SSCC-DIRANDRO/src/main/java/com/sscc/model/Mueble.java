package com.sscc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;


@Entity
public class Mueble {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer idMueble;

	@Column(nullable=true, length=30)
	private String codigo;
	
	@Column(nullable=true, length=250)
	private String descripcion;
	
	@Column(nullable=false)
	private Integer tipo;
	
	@Column(nullable=true, length=30)
	private String nombreTipo;
	
	@Column(nullable=false)
	private Double valor;
	
	
	
	
}
