package com.property.ssm.po;

import java.util.Date;

public class Charge {
    private Integer chargeId;

    private Integer ownerId;

    private String position;

    private String project;

    private String way;

    private String unit;

    private Double used;

    private Double price;

    private Double total;

    private Integer inperson;
    
    private Date indate;

    private Date paydate;

    private Integer transactor;

    private String remark;

    public Integer getChargeId() {
        return chargeId;
    }

    public void setChargeId(Integer chargeId) {
        this.chargeId = chargeId;
    }

    public Integer getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(Integer ownerId) {
        this.ownerId = ownerId;
    }

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
        this.project = project == null ? null : project.trim();
    }

    public String getWay() {
        return way;
    }

    public void setWay(String way) {
        this.way = way == null ? null : way.trim();
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit == null ? null : unit.trim();
    }

    public Double getUsed() {
        return used;
    }

    public void setUsed(Double used) {
        this.used = used;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Date getIndate() {
        return indate;
    }

    public void setIndate(Date indate) {
        this.indate = indate;
    }

    public Date getPaydate() {
        return paydate;
    }

    public void setPaydate(Date paydate) {
        this.paydate = paydate;
    }

    public Integer getTransactor() {
        return transactor;
    }

    public void setTransactor(Integer transactor) {
        this.transactor = transactor;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

	public Integer getInperson() {
		return inperson;
	}

	public void setInperson(Integer inperson) {
		this.inperson = inperson;
	}

	@Override
	public String toString() {
		return "Charge [chargeId=" + chargeId + ", ownerId=" + ownerId + ", position=" + position + ", project="
				+ project + ", way=" + way + ", unit=" + unit + ", used=" + used + ", price=" + price + ", total="
				+ total + ", inperson=" + inperson + ", indate=" + indate
				+ ", paydate=" + paydate + ", transactor=" + transactor + ", remark=" + remark + "]";
	}
}