package com.property.ssm.po;

import java.util.List;

public class House {
    private Integer houseId;

    private String position;

    private Double area;

    private Double usedarea;

    private String houseType;

    private String workoff;

    private Integer ownerId;

    private String remark;
    
    private Owner owner;
    
    private List<Carport> carportlist;


	public Owner getOwner() {
		return owner;
	}

	public void setOwner(Owner owner) {
		this.owner = owner;
	}

	public Integer getHouseId() {
        return houseId;
    }

    public void setHouseId(Integer houseId) {
        this.houseId = houseId;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position == null ? null : position.trim();
    }

    public Double getArea() {
        return area;
    }

    public void setArea(Double area) {
        this.area = area;
    }

    public Double getUsedarea() {
        return usedarea;
    }

    public void setUsedarea(Double usedarea) {
        this.usedarea = usedarea;
    }

    public String getHouseType() {
        return houseType;
    }

    public void setHouseType(String houseType) {
        this.houseType = houseType == null ? null : houseType.trim();
    }

    public String getWorkoff() {
        return workoff;
    }

    public void setWorkoff(String workoff) {
        this.workoff = workoff == null ? null : workoff.trim();
    }

    public Integer getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(Integer ownerId) {
        this.ownerId = ownerId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

	public List<Carport> getCarportlist() {
		return carportlist;
	}

	public void setCarportlist(List<Carport> carportlist) {
		this.carportlist = carportlist;
	}
}