package com.sscc.form;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class fileBean {
	private CommonsMultipartFile file;
	private List<CommonsMultipartFile> filesb;
	private Integer idAttachment;
	private String name;
	private String path;
	private Long size;
	private String fileType;
	private String type;
	private Date lastModified;
	private String createdBy;
	private Integer idEntity;
	private String typeEntity;
	private String url;
	private Timestamp creationDate;
	private String visibility;
	private String description;
	private String otherDetail;
	
	public CommonsMultipartFile getFile() {
		return file;
	}
	public void setFile(CommonsMultipartFile file) {
		this.file = file;
	}
	public List<CommonsMultipartFile> getFilesb() {
		return filesb;
	}
	public void setFilesb(List<CommonsMultipartFile> filesb) {
		this.filesb = filesb;
	}
	public Integer getIdAttachment() {
		return idAttachment;
	}
	public void setIdAttachment(Integer idAttachment) {
		this.idAttachment = idAttachment;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public Long getSize() {
		return size;
	}
	public void setSize(Long size) {
		this.size = size;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Date getLastModified() {
		return lastModified;
	}
	public void setLastModified(Date lastModified) {
		this.lastModified = lastModified;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public Integer getIdEntity() {
		return idEntity;
	}
	public void setIdEntity(Integer idEntity) {
		this.idEntity = idEntity;
	}
	public String getTypeEntity() {
		return typeEntity;
	}
	public void setTypeEntity(String typeEntity) {
		this.typeEntity = typeEntity;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Timestamp getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Timestamp creationDate) {
		this.creationDate = creationDate;
	}
	public String getVisibility() {
		return visibility;
	}
	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getOtherDetail() {
		return otherDetail;
	}
	public void setOtherDetail(String otherDetail) {
		this.otherDetail = otherDetail;
	}
}
