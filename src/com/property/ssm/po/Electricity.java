package com.property.ssm.po;

import java.util.Date;

public class Electricity {
    private Integer electricityId;

    private String position;

    private Date startdate;

    private Double price;

    public Integer getElectricityId() {
        return electricityId;
    }

    public void setElectricityId(Integer electricityId) {
        this.electricityId = electricityId;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}