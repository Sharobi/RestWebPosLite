package com.sharobi.webpos.util;

import java.sql.Date;
import java.text.SimpleDateFormat;


public class Utility {
	private final static SimpleDateFormat sdfShort = new SimpleDateFormat(CommonResource.getProperty(CommonResource.DATE_FORMAT_SHORT));

	public static String getFormatedDateShort(long date) {
		return getFormatedDateShort(new Date(date));
	}

	public static String getFormatedDateShort(java.util.Date date) {
		return sdfShort.format(date);
	}
	public static double round(double value, int places) {
	    if (places < 0) throw new IllegalArgumentException();
	    long factor = (long) Math.pow(10, places);
	    value = value * factor;
	    long tmp = Math.round(value);
	    return (double) tmp / factor;
	}
	
}
