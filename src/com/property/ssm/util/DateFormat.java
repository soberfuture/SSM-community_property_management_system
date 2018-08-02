package com.property.ssm.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateFormat {

	public static Date StringToDate(String date1) throws ParseException {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = simpleDateFormat.parse(date1);
		return date;
	}
	
	public static String DateToString(Date date1) throws ParseException {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = simpleDateFormat.format(date1);
		return dateString;
	}
	
	public static Date StringToFullDate(String date1) throws ParseException {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date fulldate = simpleDateFormat.parse(date1);
		return fulldate;
	}
	
	public static String FullDateToString(Date date1) throws ParseException {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String fulldateString = simpleDateFormat.format(date1);
		return fulldateString;
	}
	
	public static long getDaySubDate(Date date1,Date date2) {
		long day = (date1.getTime()-date2.getTime())/(24*60*60*1000);
		return day;
	}
	
	public static long getMinutesSubDate(Date date1,Date date2) {
		long minutes = (date1.getTime()-date2.getTime())/(60*1000);
		return minutes;
	}
	
	public static long getSecondSubDate(Date date1,Date date2) {
		long seconds = (date1.getTime()-date2.getTime())/(1000);
		return seconds;
	}
	
	public static int getMonth(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int month = calendar.get(Calendar.MONTH)+1;
		return month;
	}
	
	public static int comparatorDate(Date date1,Date date2) {
		if(date1.getTime()>date2.getTime()) {
			return 1;
		}else if(date1.getTime()<date2.getTime()) {
			return -1;
		}else {
			return 0;
		}
	}
	
	public static int comparatorString(String dateStr1,String dateStr2) throws ParseException {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date1 = simpleDateFormat.parse(dateStr1);
		Date date2 = simpleDateFormat.parse(dateStr2);
		if(date1.getTime()>date2.getTime()) {
			return 1;
		}else if(date1.getTime()<date2.getTime()) {
			return -1;
		}else {
			return 0;
		}
	}
}
