package com.property.ssm.service;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.FeeRecord;
import com.property.ssm.po.Repair;

public interface RepairService {
    int deleteByPrimaryKey(Integer repairId);

    int insert(Repair record);

    int insertSelective(Repair record);

    Repair selectByPrimaryKey(Integer repairId);

    int updateByPrimaryKeySelective(Repair record);

    int updateByPrimaryKey(Repair record);
    
    int findCount();//所有记录数
    
    List<Repair> findByPagination(Map<String, Integer> map);//按分页查询所有记录    

    List<Repair> findByPosition(String position);
    
    List<Repair> findByPositionAndSituation(FeeRecord feeRecord);
    
    List<Repair> findByStatus(Map<String, Object> map);
    
    int findCountByConditionAndPagination(FeeRecord feeRecord);
    
    List<Repair> findByConditionAndPagination(FeeRecord feeRecord);
}
