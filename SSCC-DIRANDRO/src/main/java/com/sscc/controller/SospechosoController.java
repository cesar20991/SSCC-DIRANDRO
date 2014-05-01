package com.sscc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SospechosoController {
	
	@RequestMapping("toCrearSospechoso")
	public String toCrearSospechoso() {
		return "principal/sospechosoNuevo";
	}
}
