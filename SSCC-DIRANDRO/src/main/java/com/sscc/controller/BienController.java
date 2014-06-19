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

import com.sscc.form.BienBean;
import com.sscc.form.CasoCriminalBean;
import com.sscc.form.InmuebleBean;
import com.sscc.form.SospechosoBean;
import com.sscc.form.VehiculoBean;
import com.sscc.model.Sospechoso;
import com.sscc.service.BienService;

@Controller
public class BienController {

	@Autowired
	BienService bienServ;
	
	@RequestMapping("toBuscarBien-{idSospechoso}")
	public String toBuscarBien(@PathVariable("idSospechoso")Integer idSospechoso, Model model ) {
		model.addAttribute("idSospechoso", idSospechoso);
		return "principal/buscarBien";
	}
	
	@RequestMapping(value ="asignarBienToSospechoso-{idBien}-{idSospechoso}",method= RequestMethod.POST)
	@ResponseBody
	public Boolean toBuscarBien(@PathVariable("idBien")Integer idBien,@PathVariable("idSospechoso")Integer idSospechoso) {
		return bienServ.asignarBienToSospechoso(idBien, idSospechoso);
	}
	
	
	// Metodos para el Inmueble
	@RequestMapping("toRegistrarInmueble")
	public String toRegistrarInmueble() {
		return "principal/registrarBienInmueble";
	}
	@RequestMapping(value = "registrarInmueble", method = RequestMethod.POST)
	public String registrarInmueble(@ModelAttribute InmuebleBean inmuebleBean, HttpServletRequest req, HttpSession session, Model model){

		Integer idUsuario = (Integer)session.getAttribute("idUsuario");
		Integer id = bienServ.registrarBienInmueble(inmuebleBean, idUsuario);
		
		return "redirect:toInmueble-"+id;
	}
	
	@RequestMapping("toInmueble-{idInmueble}")
	public String toInmueble(@PathVariable("idInmueble")Integer idInmueble, Model model ){
		List<InmuebleBean> i = new ArrayList<InmuebleBean>();
		InmuebleBean ib = new InmuebleBean();
		ib.setIdInmueble(idInmueble);
		i.add(ib);		
		model.addAttribute("inmuebleList", i);
		return "principal/inmueblePrincipal";
	}
	
	@RequestMapping(value= "getInmueble-{idInmueble}", method=RequestMethod.POST)
	@ResponseBody
	public InmuebleBean getInmueble(@PathVariable("idInmueble")Integer idInmueble){
		InmuebleBean inmuebleBean = new InmuebleBean();
		inmuebleBean = bienServ.getInmuebleBean(idInmueble);
		System.out.println(inmuebleBean!=null?"Existe inmueble":"No esta devolviendo el inmueble");
		return inmuebleBean;
	}
	
	@RequestMapping(value = "editarInmueble", method = RequestMethod.POST)
	@ResponseBody
	public InmuebleBean editarSopechoso(@ModelAttribute InmuebleBean inmueble, HttpServletRequest req, HttpSession session, Model model){
		InmuebleBean inmuebleBean = new InmuebleBean();
		inmuebleBean = bienServ.editInmuebleBean(inmueble);
		return inmuebleBean;
	}
	

	// Metodos para el Vehiculo
	@RequestMapping("toRegistrarVehiculo")
	public String toRegistrarVehiculo() {
		return "principal/registrarBienVehicular";
	}
	
	@RequestMapping(value = "registrarVehiculo", method = RequestMethod.POST)
	public String registrarVehiculo(@ModelAttribute VehiculoBean vehiculoBean, HttpServletRequest req, HttpSession session, Model model){
	
		Integer idUsuario = (Integer)session.getAttribute("idUsuario");
		Integer id = bienServ.registrarBienVehicular(vehiculoBean,idUsuario);
		
		return "redirect:toVehiculo-"+id;
	}
	
	@RequestMapping("toVehiculo-{idVehiculo}")
	public String toVehiculo(@PathVariable("idVehiculo")Integer idVehiculo, Model model ){
		List<VehiculoBean> v = new ArrayList<VehiculoBean>();
		VehiculoBean vb = new VehiculoBean();
		vb.setIdVehiculo(idVehiculo);
		v.add(vb);		
		model.addAttribute("vehiculoList", v);
		return "principal/vehiculoPrincipal";
	}
	
	@RequestMapping(value= "getVehiculo-{idVehiculo}", method=RequestMethod.POST)
	@ResponseBody
	public VehiculoBean getVehiculo(@PathVariable("idVehiculo")Integer idVehiculo){
		System.out.println("IdVehiculo = "+idVehiculo);
		VehiculoBean vehiculoBean = new VehiculoBean();
		vehiculoBean = bienServ.getVehiculoBean(idVehiculo);
		
		return vehiculoBean;
	}
	
	@RequestMapping(value = "editarVehiculo", method = RequestMethod.POST)
	@ResponseBody
	public VehiculoBean editarSopechoso(@ModelAttribute VehiculoBean vehiculo, HttpServletRequest req, HttpSession session, Model model){
		VehiculoBean vehiculoBean = new VehiculoBean();
		vehiculoBean = bienServ.editVehiculoBean(vehiculo);
		return vehiculoBean;
	}
	
	// BIENES
	@RequestMapping(value = "getBienes", method = RequestMethod.POST)
	@ResponseBody
	public List<BienBean> getBienes(){
		List<BienBean> bienes=new ArrayList<BienBean>();
		bienes = bienServ.getBienesBean();
		return bienes;
	}
	//Validaciones-Bienes:
	@RequestMapping(value = "getPartidaRegistral-{partidaRegistral}", method = RequestMethod.POST)
	@ResponseBody
	public Boolean getPartidaRegistral(@PathVariable("partidaRegistral") String partidaRegistral){
		if(bienServ.getPartidaRegistral(partidaRegistral)){
			return true;
		}else{
			return false;
		}
	}
	
}
