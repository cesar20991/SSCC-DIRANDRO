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
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.sscc.form.ArchivoBean;
import com.sscc.form.PerfilBean;
import com.sscc.form.adjuntoBean;
import com.sscc.model.Archivo;
import com.sscc.model.CasoCriminal;
import com.sscc.model.Inmueble;
import com.sscc.model.Perfil;
import com.sscc.model.Sospechoso;
import com.sscc.model.Usuario;
import com.sscc.model.Vehiculo;
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
					}else if(tipoEntidad.equals("vehiculo")){
						Vehiculo v = new Vehiculo();
						v.setIdVehiculo(idEntidad);
						archivo.setVehiculo(v);
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
		}else if(tipoEntidad.equals("vehiculo")){
			qArchivos = em.createQuery("SELECT a FROM Archivo a JOIN a.vehiculo v WHERE a.tipoEntidad = 'vehiculo' AND v.idVehiculo="+idEntidad+" AND a.estado = 'habilitado' ORDER BY a.fecCreacion DESC ");
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

	@Transactional
	public Boolean asignarArchivo(String url, Integer idEntidad, HttpSession session) {
		boolean result = false;

		try{
			Perfil p = em.find(Perfil.class, idEntidad);
			Perfil pEdit = em.merge(p);
			
			pEdit.setUrlPerfil(url);
			if(session.getAttribute("idPerfil") == idEntidad){
				session.setAttribute("url", pEdit.getUrlPerfil());
			}
			result = true;
		}catch(Exception e){
			result = false;
		}	

		return result;
	}
	
	@Transactional
	public Boolean asignarArchivoSospechoso(String url, Integer idEntidad, HttpSession session) {
		boolean result = false;

		try{
			Sospechoso s = em.find(Sospechoso.class, idEntidad);
			Sospechoso sEdit = em.merge(s);
			
			sEdit.setUrlSospechoso(url);
			result = true;
		}catch(Exception e){
			result = false;
		}	

		return result;
	}
	
	@Transactional
	public Boolean asignarArchivoInmueble(String url, Integer idEntidad, HttpSession session) {
		boolean result = false;

		try{
			Inmueble s = em.find(Inmueble.class, idEntidad);
			Inmueble sEdit = em.merge(s);
			
			sEdit.setUrlInmueble(url);
			result = true;
		}catch(Exception e){
			result = false;
		}	

		return result;
	}
	
	@Transactional
	public Boolean asignarArchivoVehiculo(String url, Integer idEntidad, HttpSession session) {
		boolean result = false;

		try{
			Vehiculo s = em.find(Vehiculo.class, idEntidad);
			Vehiculo sEdit = em.merge(s);
			
			sEdit.setUrlVehiculo(url);
			result = true;
		}catch(Exception e){
			result = false;
		}	

		return result;
	}
	
}
