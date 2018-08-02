package com.property.ssm.mapper;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.Charge;
import com.property.ssm.po.FeeRecord;

public interface ChargeMapper {
    int deleteByPrimaryKey(Integer chargeId);

    int insert(Charge record);

    int insertSelective(Charge record);

    Charge selectByPrimaryKey(Integer chargeId);

    int updateByPrimaryKeySelective(Charge record);

    int updateByPrimaryKey(Charge record);
    
    int findCount();//所有记录数
    
    List<Charge> findByPagination(Map<String, Integer> map);//按分页查询所有记录
    
    int findCountByCondition(Map<String, Object> map);//按条件查询所有记录数
    
    List<Charge> findByPaginationAndCondition(Map<String, Object> map);//按条件分页查询所有记录
    
    List<Charge> findByPositionAndFeeState(String position);
    
    List<FeeRecord> findFeeRecord(Map<String, Object> map);
    
    List<Charge> findByYearAndMonth(Map<String, Object> map);
    
    List<FeeRecord> findListByUserAndCondition(FeeRecord feeRecord);
}