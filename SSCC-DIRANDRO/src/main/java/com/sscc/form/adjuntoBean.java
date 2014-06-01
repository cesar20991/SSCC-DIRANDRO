package com.sscc.form;

import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class adjuntoBean {
	private List<CommonsMultipartFile> files;

	public List<CommonsMultipartFile> getFiles() {
		return files;
	}

	public void setFiles(List<CommonsMultipartFile> files) {
		this.files = files;
	}
	
	private List<fileBean> filesbean;

	public List<fileBean> getFilesbean() {
		return filesbean;
	}

	public void setFilesbean(List<fileBean> filesbean) {
		this.filesbean = filesbean;
	}

}
