package com.sscc.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sscc.form.CasoCriminalBean;
import com.sscc.form.SospechosoBean;
import com.sscc.model.CasoCriminal;
import com.sscc.model.Sospechoso;
import com.sscc.service.CasoCriminalService;
import com.sscc.service.SospechosoService;

@Controller
public class CasoCriminalController {
	
	@Autowired
	CasoCriminalService casoServ;
	
	@Autowired
	SospechosoService sospechosoServ;
	
	@RequestMapping("toCrearCaso")
	public String toCrearCaso() {
		return "principal/crearCaso";
	}
	
	@RequestMapping("toBuscarCaso")
	public String toBuscarCaso() {
		return "principal/buscarCasoCriminal";
	}
	
	@RequestMapping("toAsignarCaso")
	public String toAsignarCaso() {
		return "principal/asignarCasoCriminal";
	}
	
	@RequestMapping("toAsignarPersonal")
	public String toAsignarPersonal() {
		return "principal/asignarPersonalPolicial";
	}
	
	@RequestMapping(value = "crearCaso", method = RequestMethod.POST)
	public String crearSospechoso(@ModelAttribute CasoCriminal caso, HttpServletRequest req, HttpSession session, Model model){

		Integer idUsuario = (Integer) session.getAttribute("idUsuario");
		Integer id = casoServ.crearCasoCriminal(caso, idUsuario);
		
		return "redirect:toCasoCriminal-"+id;
	}
	
	@RequestMapping("toCasoCriminal-{idCaso}")
	public String toCrearUsuario(@PathVariable("idCaso") Integer idCaso, Model model) {
		List<CasoCriminalBean> c=new ArrayList<CasoCriminalBean>();
		CasoCriminalBean cb = new CasoCriminalBean();
		cb.setIdCasoCriminal(idCaso);
		c.add(cb);
		model.addAttribute("casoList",c);
		return "principal/casoCriminalPrincipal";
	}
	
	@RequestMapping(value = "getCaso-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public CasoCriminalBean getCaso(@PathVariable("idCaso") Integer idCaso){
		CasoCriminalBean casobean = new CasoCriminalBean();
		casobean = casoServ.getCasoCriminalBean(idCaso);
		return casobean;
	}
	
	@RequestMapping(value = "getCasosPersonal", method = RequestMethod.POST)
	@ResponseBody
	public List<CasoCriminalBean> getCasosPersonal(){
		List<CasoCriminalBean> c=new ArrayList<CasoCriminalBean>();
		c = casoServ.getCasosCriminalBeanPersonal();
		return c;
	}
	
	@RequestMapping(value = "getCasos", method = RequestMethod.POST)
	@ResponseBody
	public List<CasoCriminalBean> getCasos(){
		List<CasoCriminalBean> c=new ArrayList<CasoCriminalBean>();
		c = casoServ.getCasosCriminalBean();
		return c;
	}
	
	@RequestMapping(value = "asignarCaso-{idCaso}-{idJefeDeUnidad}", method = RequestMethod.POST)
	@ResponseBody
	public List<CasoCriminalBean> asignarCaso(@PathVariable("idCaso") Integer idCaso, @PathVariable("idJefeDeUnidad") Integer idJefeDeUnidad){
		List<CasoCriminalBean> c=new ArrayList<CasoCriminalBean>();
		c = casoServ.asignarCasoCriminalEditar(idCaso, idJefeDeUnidad);
		return c;
	}
	
	@RequestMapping("getStatusList")
	@ResponseBody
	public List<String> getStatusList(HttpServletRequest req){
		List<String> list = new ArrayList<String>();
		list = casoServ.getStatusCasoCriminal();		
		return list;
	}
	
	@RequestMapping("getLastCasosCriminales")
	@ResponseBody
	public List<CasoCriminalBean> getLastCasosCriminales(HttpServletRequest req){
		List<CasoCriminalBean> list = new ArrayList<CasoCriminalBean>();
		list = casoServ.getLastCasosCriminales(req.getSession());		
		return list;
	}
	
	@RequestMapping("editarCasoCriminal")
	@ResponseBody
	public CasoCriminalBean editarCasoCriminal(@ModelAttribute CasoCriminal caso, HttpServletRequest req){
		CasoCriminalBean list = casoServ.editarCasoCriminal(caso);		
		return list;
	}
	
	@RequestMapping(value = "asignarPersonalPolicial-{idCaso}-{idPolicia}", method = RequestMethod.POST)
	@ResponseBody
	public Boolean asignarPersonalPolicial(@PathVariable("idCaso") Integer idCaso, @PathVariable("idPolicia") Integer idPolicia){
		if(casoServ.asignarPersonalPolicial(idCaso, idPolicia, "habilitado")){
			return true;
		}else{
			return false;
		}		
	}
	
	@RequestMapping(value = "reAsignarPersonalPolicial-{idCaso}-{idPolicia}", method = RequestMethod.POST)
	@ResponseBody
	public Boolean reAsignarPersonalPolicial(@PathVariable("idCaso") Integer idCaso, @PathVariable("idPolicia") Integer idPolicia){
		casoServ.reAsignarPersonalPolicial(idCaso, idPolicia, "deshabilitado");		
		return true;
	}
	
	@RequestMapping(value = "crearSospechosoAlCaso-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public List<SospechosoBean> crearSospechosoAlCaso(@ModelAttribute Sospechoso sospechoso, @PathVariable("idCaso") Integer idCaso){
		Integer idSospechoso = sospechosoServ.crearSospechoso(sospechoso);
		if(casoServ.crearSospechosoAlCaso(idCaso, idSospechoso)){
			return casoServ.getSospechosoPorCaso(idCaso);
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "crearSospechosoExistenteAlCaso-{idCaso}-{idSospechoso}", method = RequestMethod.POST)
	@ResponseBody
	public List<SospechosoBean> crearSospechosoExistenteAlCaso(@PathVariable("idSospechoso") Integer idSospechoso, @PathVariable("idCaso") Integer idCaso){
		if(casoServ.crearSospechosoExistenteAlCaso(idCaso, idSospechoso)){
			return casoServ.getSospechosoPorCaso(idCaso);
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "toDiligenciasPre-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public CasoCriminalBean crearSospechosoExistenteAlCaso(@ModelAttribute CasoCriminal casoCriminal, @PathVariable("idCaso") Integer idCaso){
		if(casoServ.toDiligenciasPre(casoCriminal, idCaso)){
			return casoServ.getCasoCriminalBean(idCaso);
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "calificacionFiscal-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public CasoCriminalBean calificacionFiscal(@PathVariable("idCaso") Integer idCaso){
		if(casoServ.toCalificacionFiscal(idCaso)){
			return casoServ.getCasoCriminalBean(idCaso);
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "cerrarCaso-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public CasoCriminalBean cerrarCaso(@PathVariable("idCaso") Integer idCaso){
		if(casoServ.toCalificacionFiscal(idCaso)){
			return casoServ.getCasoCriminalBean(idCaso);
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "dejarComentarioCerrarCaso-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public CasoCriminalBean dejarComentarioCerrarCaso(@ModelAttribute CasoCriminal casoCriminal, @PathVariable("idCaso") Integer idCaso){
		if(casoServ.comentarioPausaDoc(casoCriminal, idCaso)){
			return casoServ.getCasoCriminalBean(idCaso);
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "toPausaDoc-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public CasoCriminalBean toPausaDoc(@PathVariable("idCaso") Integer idCaso){
		if(casoServ.toPausaDocumentacion(idCaso)){
			return casoServ.getCasoCriminalBean(idCaso);
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "toPausaNCaso-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public CasoCriminalBean toPausaNCaso(@PathVariable("idCaso") Integer idCaso){
		if(casoServ.toPausaNuevoCaso(idCaso)){
			return casoServ.getCasoCriminalBean(idCaso);
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "removerPausa-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public CasoCriminalBean removerPausa(@PathVariable("idCaso") Integer idCaso){
		if(casoServ.removerPausa(idCaso)){
			return casoServ.getCasoCriminalBean(idCaso);
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "dejarComentarioPausaDoc-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public CasoCriminalBean dejarComentarioPausaDoc(@ModelAttribute CasoCriminal casoCriminal, @PathVariable("idCaso") Integer idCaso){
		if(casoServ.comentarioPausaDoc(casoCriminal, idCaso)){
			return casoServ.getCasoCriminalBean(idCaso);
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "dejarComentarioPausaNCaso-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public CasoCriminalBean dejarComentarioPausaNCaso(@ModelAttribute CasoCriminal casoCriminal, @PathVariable("idCaso") Integer idCaso){
		if(casoServ.comentarioPausaNCaso(casoCriminal, idCaso)){
			return casoServ.getCasoCriminalBean(idCaso);
		}else{
			return null;
		}		
	}
	
	@RequestMapping(value = "getSopechososPorCaso-{idCaso}", method = RequestMethod.POST)
	@ResponseBody
	public List<SospechosoBean> getSopechososPorCaso(@PathVariable("idCaso") Integer idCaso){
			return casoServ.getSospechosoPorCaso(idCaso);
	}

	@RequestMapping(value = "deshasignarSospechoso-{idCaso}-{idSospechoso}", method = RequestMethod.POST)
	@ResponseBody
	public List<SospechosoBean> deshasignarSospechoso(@PathVariable("idCaso") Integer idCaso,@PathVariable("idSospechoso") Integer idSospechoso){
		if(casoServ.deshasignarSospechosoDelCaso(idCaso, idSospechoso)){
			return casoServ.getSospechosoPorCaso(idCaso);
		}else{
			return null;
		}
	}
	
	@RequestMapping(value = "deshasignarCasoDelSospechoso-{idCaso}-{idSospechoso}", method = RequestMethod.POST)
	@ResponseBody
	public List<CasoCriminalBean> deshasignarCasoDelSospechoso(@PathVariable("idCaso") Integer idCaso,@PathVariable("idSospechoso") Integer idSospechoso){
		if(casoServ.deshasignarSospechosoDelCaso(idCaso, idSospechoso)){
			return sospechosoServ.getCasosDelSospechoso(idSospechoso);
		}else{
			return null;
		}
	}
	
	@RequestMapping("popUpAsignarSospechoso")
	public String popUpAsignarSospechoso(){
		return "principal/popUpBuscarSospechoso";	
	}
}
