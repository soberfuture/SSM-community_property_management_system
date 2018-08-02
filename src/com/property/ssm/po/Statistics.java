package com.property.ssm.po;

public class Statistics {

	private String month;
	
	private int count;
	
	private int unsolved;
	
	private int solved;
	
	private Double proportion;
	
	private Double ctime;
	
	private Double score;

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getUnsolved() {
		return unsolved;
	}

	public void setUnsolved(int unsolved) {
		this.unsolved = unsolved;
	}

	public int getSolved() {
		return solved;
	}

	public void setSolved(int solved) {
		this.solved = solved;
	}

	public Double getProportion() {
		return proportion;
	}

	public void setProportion(Double proportion) {
		this.proportion = proportion;
	}


	public Double getCtime() {
		return ctime;
	}

	public void setCtime(Double ctime) {
		this.ctime = ctime;
	}

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}
	
	
}
