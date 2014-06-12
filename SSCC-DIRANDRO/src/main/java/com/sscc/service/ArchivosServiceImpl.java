package com.sscc.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.sscc.form.adjuntoBean;
import com.sscc.model.Archivo;
import com.sscc.model.Usuario;
import com.sscc.util.DateUtil;

@Service
public class ArchivosServiceImpl implements ArchivosService{
	
	@PersistenceContext
	EntityManager em;
	
	@Transactional
	public List<Archivo> guardarArchivos(adjuntoBean files, HttpServletRequest request, HttpServletResponse res, String tipoEntidad, Integer idEntidad){
		Archivo archivo = new Archivo();
		List<CommonsMultipartFile> cmpf = new ArrayList<CommonsMultipartFile>();
		res.setContentType("text/plain");
		
		//Integer a = 5;
		//&& file1.getSize() < (1048576 * a)
		try{
			cmpf.addAll(files.getFiles());
			//System.err.println("ENTRE! files > 0");
			for(int i = 0 ; i <  cmpf.size() ; i++){
				CommonsMultipartFile file1 = cmpf.get(i);

				if(file1 != null && file1.getSize() > 0 ){
					//mover a la carpeta
					byte[] bytes = file1.getBytes();
					//String fileContentType = file1.getContentType();
					//System.err.println("******* FILE CONTENT TYPE: " + fileContentType);
					BufferedImage bufferedImage =ImageIO.read(file1.getInputStream());
					File localFile = new File(request.getServletContext().getRealPath("images")+"/pictures/"+file1.getOriginalFilename()+"/"+file1.getOriginalFilename());
					System.err.println(request.getServletContext().getRealPath("images")+"/pictures/"+file1.getOriginalFilename()+"/"+file1.getOriginalFilename());
					boolean dir = localFile.mkdirs();
					file1.transferTo(localFile);
					//setear archivos
					archivo.setEstado("habilitado");
					DateUtil u = new DateUtil();
					archivo.setFecCreacion(u.hoyTimestamp());
					archivo.setNombreArchivo(file1.getOriginalFilename());
					archivo.setTamanio(file1.getSize());
					archivo.setTipo("");
					archivo.setTipoArchivo(file1.getContentType());
					archivo.setTipoEntidad(tipoEntidad);
					archivo.setIdEntidad(idEntidad);
					archivo.setUrl(request.getServletContext().getRealPath("images")+"/pictures/"+file1.getOriginalFilename()+"/"+file1.getOriginalFilename());
					Usuario us = new Usuario();
					if(tipoEntidad.equals("usuario")){						
						us.setIdUsuario(idEntidad);
						archivo.setUsuario(us);
					}
					em.persist(archivo);
			    }
			}
			
		}catch(IOException iox){
			System.err.println("***** FILE UPLOAD ERROR ******: " + iox.getMessage());
		    return null;
		}
		return getArchivosByEntidad(tipoEntidad, idEntidad);
	}

	@Transactional
	public List<Archivo> getArchivosByEntidad(String tipoEntidad, Integer idEntidad) {
		//List<Archivo> archivos = new ArrayList<Archivo>();
		
		Query qArchivos = null;
		if(tipoEntidad.equals("usuario")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.usuario u WHERE a.tipoEntidad='usuario' AND u.idUsuario="+idEntidad);
		}
		List<Archivo> a = qArchivos.getResultList();
		
		return a;
	}
	
	

}
