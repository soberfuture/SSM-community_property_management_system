package com.property.ssm.po;

import java.util.Date;

public class Repair {
    private Integer repairId;

    private Date repairDate;

    private String content;

    private Integer ownerId;

    private String position;

    private String tel;

    private Date handledate;

    private String handler;

    private Double servicecost;

    private Double mattercost;

    private String situation;

    public Integer getRepairId() {
        return repairId;
    }

    public void setRepairId(Integer repairId) {
        this.repairId = repairId;
    }

    public Date getRepairDate() {
        return repairDate;
    }

    public void setRepairDate(Date repairDate) {
        this.repairDate = repairDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
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

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    public Date getHandledate() {
        return handledate;
    }

    public void setHandledate(Date handledate) {
        this.handledate = handledate;
    }

    public String getHandler() {
        return handler;
    }

    public void setHandler(String handler) {
        this.handler = handler == null ? null : handler.trim();
    }

    public Double getServicecost() {
        return servicecost;
    }

    public void setServicecost(Double servicecost) {
        this.servicecost = servicecost;
    }

    public Double getMattercost() {
        return mattercost;
    }

    public void setMattercost(Double mattercost) {
        this.mattercost = mattercost;
    }

    public String getSituation() {
        return situation;
    }

    public void setSituation(String situation) {
        this.situation = situation == null ? null : situation.trim();
    }
}