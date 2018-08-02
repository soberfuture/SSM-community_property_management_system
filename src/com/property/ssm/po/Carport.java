package com.property.ssm.po;

import java.util.Date;

public class Carport {
    private Integer carportId;

    private String carportPosition;

    private Integer ownerId;
   
    private Date startdate;
    
    private String position;

    private Date stopdate;

    private Double area;

    private Double carportFee;

    private Integer cfee;
    
    private String status;

    public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getCarportId() {
        return carportId;
    }

    public void setCarportId(Integer carportId) {
        this.carportId = carportId;
    }

    public String getCarportPosition() {
        return carportPosition;
    }

    public void setCarportPosition(String carportPosition) {
        this.carportPosition = carportPosition == null ? null : carportPosition.trim();
    }

    public Integer getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(Integer ownerId) {
        this.ownerId = ownerId;
    }

    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public Date getStopdate() {
        return stopdate;
    }

    public void setStopdate(Date stopdate) {
        this.stopdate = stopdate;
    }

    public Double getArea() {
        return area;
    }

    public void setArea(Double area) {
        this.area = area;
    }

    public Double getCarportFee() {
        return carportFee;
    }

    public void setCarportFee(Double carportFee) {
        this.carportFee = carportFee;
    }


	public Integer getCfee() {
		return cfee;
	}

	public void setCfee(Integer cfee) {
		this.cfee = cfee;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position == null ? null : position.trim();
	}
}