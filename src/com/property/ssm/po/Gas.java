package com.property.ssm.po;

import java.util.Date;

public class Gas {
    private Integer gasId;

    private String position;

    private Date startdate;

    private Double price;

    public Integer getGasId() {
        return gasId;
    }

    public void setGasId(Integer gasId) {
        this.gasId = gasId;
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