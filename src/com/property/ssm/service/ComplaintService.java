package com.property.ssm.service;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.Complaint;
import com.property.ssm.po.FeeRecord;

public interface ComplaintService {
    int deleteByPrimaryKey(Integer complaintId);

    int insert(Complaint record);

    int insertSelective(Complaint record);

    Complaint selectByPrimaryKey(Integer complaintId);

    int updateByPrimaryKeySelective(Complaint record);

    int updateByPrimaryKey(Complaint record);
    
    int findCount();//所有记录数
    
    List<Complaint> findByPagination(Map<String, Integer> map);//按分页查询所有记录
    
    List<Complaint> findByPosition(String position);
    
    List<Complaint> findByPositionAndComplaintStatus(FeeRecord feeRecord);
    
    List<Complaint> findComplaintAndEvaluate();
    
    List<Complaint> findByStatus(Map<String, Object> map);
    
    int findCountByConditionAndPagination(FeeRecord feeRecord);
    
    List<Complaint> findByConditionAndPagination(FeeRecord feeRecord);
}
