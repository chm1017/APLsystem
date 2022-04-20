package com.cm.APL.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeUtil {
	
	public static String getSysTime(){
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date date = new Date();
		String dateStr = sdf.format(date);
		
		return dateStr;
		
	}


	public static void main(String[] args) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		Date date = new Date();
		String dateStr = sdf.format(date);
		System.out.println(dateStr);

	}
	
}
