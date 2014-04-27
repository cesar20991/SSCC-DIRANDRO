package com.sscc.util;

public class DateUtil {
	
	public java.sql.Timestamp hoyTimestamp(){
		java.util.Date d = new java.util.Date(System.currentTimeMillis()); 
		java.sql.Timestamp ts = new java.sql.Timestamp(d.getTime());    	
    	return ts;		
	}
	
	public java.sql.Date hoy(){
		java.sql.Date d = new java.sql.Date(System.currentTimeMillis());
		return d;
	}
}
