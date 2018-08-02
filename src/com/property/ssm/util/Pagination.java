package com.property.ssm.util;

import java.util.List;
@SuppressWarnings("rawtypes")
public class Pagination {
	private int index;
	private int rows;
	private int count;
	private int pagesize;
	private String navigation;
	private String way;
	private List list;
	
	public Pagination() {
		
	}
	
	public Pagination(int index,int rows, int count,int pagesize,String navigation,List list) {
		this.index=index;
		this.rows=rows;
		this.count=count;
		this.pagesize=pagesize;
		this.navigation=navigation;
		this.list=list;
	}
	
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getPagesize() {
		return pagesize;
	}
	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}

	public String getNavigation() {
		return navigation;
	}

	public void setNavigation(String navigation) {
		this.navigation = navigation;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getWay() {
		return way;
	}

	public void setWay(String way) {
		this.way = way;
	}
	
}
