package com.property.ssm.po;

import java.text.ParseException;
import java.util.Date;

import com.property.ssm.util.DateFormat;

public class FeeRecord implements Comparable<FeeRecord>{
	private String position;
	
	private String project;
	
	private String way;
	
	private Double money;
	
	private String startdate;
	
	private String stopdate;
	
	private String date;
	
	private Integer page;
	
	private Integer rows;
	
	private int index;
	
	private int pagesize;

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}

	public String getWay() {
		return way;
	}

	public void setWay(String way) {
		this.way = way;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public String getDate() {
		return date;
	}

	public void setDate(Date date) throws ParseException {
		this.date = DateFormat.DateToString(date);
	}

	public String getStopdate() {
		return stopdate;
	}

	public void setStopdate(String stopdate) {
		this.stopdate = stopdate;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate){
		this.startdate = startdate;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public int getPagesize() {
		return pagesize;
	}

	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	@Override
	public int compareTo(FeeRecord feeRecord){
		String date = feeRecord.getDate();
		try {
			return DateFormat.comparatorString(this.date, date);
		} catch (ParseException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	
}
