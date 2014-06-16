package com.sscc.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.sscc.form.ArchivoBean;
import com.sscc.form.adjuntoBean;
import com.sscc.model.Archivo;
import com.sscc.model.CasoCriminal;
import com.sscc.model.Inmueble;
import com.sscc.model.Sospechoso;
import com.sscc.model.Usuario;
import com.sscc.util.DateUtil;

@Service
public class ArchivosServiceImpl implements ArchivosService{
	
	@PersistenceContext
	EntityManager em;
	
	@Transactional	
	public Boolean guardarArchivos(adjuntoBean files, HttpServletRequest request, HttpServletResponse res, String tipoEntidad, Integer idEntidad){
		
		List<CommonsMultipartFile> cmpf = new ArrayList<CommonsMultipartFile>();
		res.setContentType("text/plain");
		
		//Integer a = 5;
		//&& file1.getSize() < (1048576 * a)
		try{
			cmpf.addAll(files.getFiles());

			for(int i = 0 ; i <  cmpf.size() ; i++){
				CommonsMultipartFile file1 = cmpf.get(i);

				if(file1 != null && file1.getSize() > 0 ){
					Archivo archivo = new Archivo();
					//mover a la carpeta
					byte[] bytes = file1.getBytes();
					//String fileContentType = file1.getContentType();
					//System.err.println("******* FILE CONTENT TYPE: " + fileContentType);
					//BufferedImage bufferedImage =ImageIO.read(file1.getInputStream());
					File localFile = new File(request.getServletContext().getRealPath("images")+"/pictures/"+file1.getOriginalFilename());
					System.err.println(request.getServletContext().getRealPath("images")+"/pictures/"+file1.getOriginalFilename());
					boolean dir = localFile.mkdirs();
					file1.transferTo(localFile);
					//setear archivos ;file1.getSize()
					archivo.setEstado("habilitado");
					DateUtil u = new DateUtil();
					archivo.setFecCreacion(u.hoyTimestamp());
					archivo.setNombreArchivo(file1.getOriginalFilename());
					archivo.setTamanio(Math.round(Math.ceil(file1.getSize()/1024.0)));
					archivo.setTipo("");
					archivo.setTipoArchivo(file1.getContentType());
					archivo.setTipoEntidad(tipoEntidad);
					archivo.setIdEntidad(idEntidad);
					archivo.setDescripcion("");
					archivo.setTituloArchivo("");
					archivo.setUrl("images/pictures/"+file1.getOriginalFilename());
					if(tipoEntidad.equals("usuario")){
						Usuario us = new Usuario();
						us.setIdUsuario(idEntidad);
						archivo.setUsuario(us);
					}else if(tipoEntidad.equals("sospechoso")){
						Sospechoso s = new Sospechoso();
						s.setIdSospechoso(idEntidad);
						archivo.setSospechoso(s);
					}else if(tipoEntidad.equals("casoCriminal")){
						CasoCriminal c = new CasoCriminal();
						c.setIdCasoCriminal(idEntidad);
						archivo.setCasoCriminal(c);
					}else if(tipoEntidad.equals("inmueble")){
						Inmueble in = new Inmueble();
						in.setIdInmueble(idEntidad);
						archivo.setInmueble(in);
					}
					em.persist(archivo);
			    }
			}
			
		}catch(IOException iox){
			System.err.println("***** FILE UPLOAD ERROR ******: " + iox.getMessage());
		    return false;
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	public List<ArchivoBean> getArchivosByEntidad(String tipoEntidad, Integer idEntidad) {
		List<ArchivoBean> archivosb = new ArrayList<ArchivoBean>();
		
		Query qArchivos = null;
		if(tipoEntidad.equals("usuario")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.usuario u WHERE a.tipoEntidad = 'usuario' AND u.idUsuario="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
		}else if(tipoEntidad.equals("sospechoso")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.sospechoso s WHERE a.tipoEntidad = 'sospechoso' AND s.idSospechoso="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
		}else if(tipoEntidad.equals("casoCriminal")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.casoCriminal c WHERE a.tipoEntidad = 'casoCriminal' AND c.idCasoCriminal="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
		}else if(tipoEntidad.equals("inmueble")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.inmueble i WHERE a.tipoEntidad = 'inmueble' AND i.idInmueble="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
		}
		
		List<Archivo> a = qArchivos.getResultList();
		
		for(int i = 0;i < a.size();i++){
			ArchivoBean archivobean = new ArchivoBean();
			Archivo archivo = a.get(i);
			archivobean.setDescripcion(archivo.getDescripcion());
			archivobean.setNombreArchivo(archivo.getNombreArchivo());
			archivobean.setTamanio(archivo.getTamanio());
			archivobean.setTipo(archivo.getTipo());
			archivobean.setTipoArchivo(archivo.getTipoArchivo());
			archivobean.setUrl(archivo.getUrl());
			archivobean.setTituloArchivo(archivo.getTituloArchivo());
			archivobean.setIdArchivo(archivo.getIdArchivo());
			archivosb.add(archivobean);
		}
		
		return archivosb;
	}

	@Transactional
	public Boolean editarArchivo(Archivo archivo, Integer idArchivo) {
		try{
			Archivo ar = em.find(Archivo.class, idArchivo);
			Archivo editAr = em.merge(ar);
			editAr.setDescripcion(archivo.getDescripcion());
			editAr.setTituloArchivo(archivo.getTituloArchivo());
			return true;
		}catch(Exception e){
			return false;
		}
		
	}

	@Transactional
	public Boolean separarArchivo(Archivo archivo, Integer idArchivo) {
		try{
			Archivo ar = em.find(Archivo.class, idArchivo);
			Archivo editAr = em.merge(ar);
			editAr.setEstado("deshabilitado");
			return true;
		}catch(Exception e){
			return false;
		}
	}
}
