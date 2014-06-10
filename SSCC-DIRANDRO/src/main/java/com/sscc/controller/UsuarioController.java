package com.sscc.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.sscc.form.adjuntoBean;
import com.sscc.model.Usuario;
import com.sscc.service.PerfilService;
import com.sscc.service.UsuarioService;


@Controller
public class UsuarioController {
	
	@Autowired
	UsuarioService usuarioServ;
	
	@Autowired
	PerfilService perfilServ;
	
	@RequestMapping("toLogin")
	public String toLogin() {
		return "login";
	}
	
	@RequestMapping("toUpload")
	public String toUpload() {
		return "uploadFiles";
	}
	
	@RequestMapping("toMap")
	public String toMap() {
		return "mapasEjemplo";
	}
	@RequestMapping("toRutas")
	public String toRutas() {
		return "rutasMapas";
	}
	
	@RequestMapping("tologout")
	public String tologout(HttpServletRequest request, HttpSession session){
		session = request.getSession();
		session.invalidate();
		return "login";
	}

	@RequestMapping("toPantallaPrincipal")
	public String toPantallaPrincipal() {
		return "principal/pantallaPrincipal";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String welcome(@ModelAttribute Usuario usuario, HttpServletRequest req, HttpSession session, Model model){
		String path = "";
		
		if(usuarioServ.login(usuario, req.getSession())) {
			path = "principal/pantallaPrincipal";
		}else{
			model.addAttribute("msg", "Estos datos no son correctos");
			path = "login";
		}

		return path;
	}
	
	@RequestMapping(value = "cambiarClave", method = RequestMethod.POST)
	@ResponseBody
	public Boolean cambiarClave(HttpServletRequest req, HttpSession session){
		
		String claveA = req.getParameter("txtClaveActual");
		String claveN = req.getParameter("txtClaveNueva");
		Integer idUsuario = (Integer) session.getAttribute("idUsuario");

		Boolean resultado = usuarioServ.cambiarClave(claveA, claveN, idUsuario);
		
		return resultado;
	}
	
	//momentaneo para probar
	@RequestMapping(value="new", method= RequestMethod.POST)
	@ResponseBody
	public String uploadFiles(@ModelAttribute adjuntoBean files, HttpServletRequest request, HttpServletResponse res){
		List<CommonsMultipartFile> cmpf = new ArrayList<CommonsMultipartFile>();
		res.setContentType("text/plain");
		//System.err.println("ENTRE!");
		Integer a = 5;
		try{
			cmpf.addAll(files.getFiles());
			//System.err.println("ENTRE! files > 0");
			for(int i = 0 ; i <  cmpf.size() ; i++){
				CommonsMultipartFile file1 = cmpf.get(i);
				//System.err.println("ENTRE!antes del if");
				if(file1 != null && file1.getSize() > 0 && file1.getSize() < (1048576 * a)){
					byte[] bytes = file1.getBytes();
					String fileContentType = file1.getContentType();
					//System.err.println("******* FILE CONTENT TYPE: " + fileContentType);
					//if(fileContentType.contains("image")){
						BufferedImage bufferedImage =ImageIO.read(file1.getInputStream());
						File localFile = new File(request.getServletContext().getRealPath("images")+"/pictures/"+file1.getOriginalFilename());
						System.err.println(request.getServletContext().getRealPath("images")+"/pictures/"+file1.getOriginalFilename());
						boolean dir = localFile.mkdirs();
						file1.transferTo(localFile);
					//}
			    }
			}
			//System.err.println("ENTRE! acabo for");
			return "OK";
		}catch(IOException iox){
		   // System.err.println("***** FILE UPLOAD ERROR ******: " + iox.getMessage());
		    return "MAL";
		}
	}
}
